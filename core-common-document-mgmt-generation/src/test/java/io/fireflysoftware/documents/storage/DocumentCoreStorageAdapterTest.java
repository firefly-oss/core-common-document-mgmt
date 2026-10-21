/*
 * Copyright 2025 Firefly Software Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package io.fireflysoftware.documents.storage;

import io.fireflysoftware.commons.ecm.models.entities.Document;
import io.fireflysoftware.commons.ecm.models.entities.DocumentMetadata;
import io.fireflysoftware.commons.ecm.models.repositories.DocumentMetadataRepository;
import io.fireflysoftware.commons.ecm.models.repositories.DocumentRepository;
import io.fireflysoftware.documents.DocumentStoreException;
import io.fireflysoftware.documents.SandboxEngagement;
import io.fireflysoftware.documents.render.FreeMarkerDocumentRenderAdapter;
import io.fireflysoftware.documents.render.RenderedDocument;
import io.fireflysoftware.documents.DocumentTypeCode;
import org.junit.jupiter.api.Test;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class DocumentCoreStorageAdapterTest {

    @Test
    void everyRenderedTemplateIsWrittenToTheDocumentCoreAndReadBack() {
        MemoryCore core = new MemoryCore(false);
        DocumentCoreStorageAdapter adapter = core.adapter();
        FreeMarkerDocumentRenderAdapter renderer = new FreeMarkerDocumentRenderAdapter();

        for (DocumentTypeCode type : DocumentTypeCode.values()) {
            RenderedDocument rendered = renderer.render(type.code(), type.kitKind(), type.label(),
                    SandboxEngagement.issue(type));
            StoredDocument stored = adapter.store(new StoredDocument(null, type.code(), rendered.mediaType(),
                    rendered.html(), type.label() + " for " + SandboxEngagement.PARTY_NAME));
            Optional<StoredDocument> read = adapter.read(stored.id());

            assertThat(read).isPresent();
            assertThat(read.orElseThrow().templateCode()).isEqualTo(type.code());
            assertThat(read.orElseThrow().mediaType()).isEqualTo(FreeMarkerDocumentRenderAdapter.MEDIA_TYPE);
            assertThat(read.orElseThrow().html()).isEqualTo(rendered.html());
            assertThat(read.orElseThrow().html()).contains(SandboxEngagement.PARTY_NAME);
            assertThat(read.orElseThrow().html()).contains(SandboxEngagement.CONTRACT_ID.toString());
            assertThat(core.documents).containsKey(stored.id());
        }
    }

    @Test
    void failedMetadataWriteRemovesTheDocumentRow() {
        MemoryCore core = new MemoryCore(true);
        DocumentCoreStorageAdapter adapter = core.adapter();
        RenderedDocument rendered = new FreeMarkerDocumentRenderAdapter().render("letter", "letter", "Letter",
                SandboxEngagement.issue(DocumentTypeCode.LETTER));

        assertThatThrownBy(() -> adapter.store(new StoredDocument(null, "letter", rendered.mediaType(),
                rendered.html(), "Letter for Ada Lovelace")))
                .isInstanceOf(DocumentStoreException.class);
        assertThat(core.documents).isEmpty();
        assertThat(core.metadata).isEmpty();
    }

    private static final class MemoryCore {
        private final ConcurrentHashMap<UUID, Document> documents = new ConcurrentHashMap<>();
        private final ConcurrentHashMap<UUID, List<DocumentMetadata>> metadata = new ConcurrentHashMap<>();
        private final DocumentRepository documentRepository = mock(DocumentRepository.class);
        private final DocumentMetadataRepository metadataRepository = mock(DocumentMetadataRepository.class);

        private MemoryCore(boolean failSecondMetadataWrite) {
            AtomicInteger metadataWrites = new AtomicInteger();
            when(documentRepository.save(any(Document.class))).thenAnswer(invocation -> {
                Document document = invocation.getArgument(0);
                if (document.getId() == null) {
                    document.setId(UUID.randomUUID());
                }
                documents.put(document.getId(), document);
                return Mono.just(document);
            });
            when(documentRepository.findById(any(UUID.class))).thenAnswer(invocation ->
                    Mono.justOrEmpty(documents.get(invocation.getArgument(0))));
            when(documentRepository.deleteById(any(UUID.class))).thenAnswer(invocation -> {
                documents.remove(invocation.getArgument(0));
                return Mono.empty();
            });
            when(metadataRepository.save(any(DocumentMetadata.class))).thenAnswer(invocation -> {
                if (failSecondMetadataWrite && metadataWrites.incrementAndGet() == 2) {
                    return Mono.error(new IllegalStateException("metadata write failed"));
                }
                DocumentMetadata row = invocation.getArgument(0);
                if (row.getId() == null) {
                    row.setId(UUID.randomUUID());
                }
                metadata.computeIfAbsent(row.getDocumentId(), ignored -> new ArrayList<>()).add(row);
                return Mono.just(row);
            });
            when(metadataRepository.findByDocumentId(any(UUID.class))).thenAnswer(invocation -> {
                List<DocumentMetadata> rows = metadata.getOrDefault(invocation.getArgument(0), List.of());
                return Flux.fromIterable(List.copyOf(rows));
            });
            when(metadataRepository.deleteById(any(UUID.class))).thenAnswer(invocation -> {
                UUID id = invocation.getArgument(0);
                metadata.values().forEach(rows -> rows.removeIf(row -> id.equals(row.getId())));
                metadata.entrySet().removeIf(entry -> entry.getValue().isEmpty());
                return Mono.empty();
            });
        }

        private DocumentCoreStorageAdapter adapter() {
            return new DocumentCoreStorageAdapter(documentRepository, metadataRepository);
        }
    }
}
