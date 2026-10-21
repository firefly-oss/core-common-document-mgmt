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

import io.fireflysoftware.commons.ecm.interfaces.enums.DocumentStatus;
import io.fireflysoftware.commons.ecm.interfaces.enums.DocumentType;
import io.fireflysoftware.commons.ecm.interfaces.enums.SecurityLevel;
import io.fireflysoftware.commons.ecm.interfaces.enums.StorageType;
import io.fireflysoftware.commons.ecm.models.entities.Document;
import io.fireflysoftware.commons.ecm.models.entities.DocumentMetadata;
import io.fireflysoftware.commons.ecm.models.repositories.DocumentMetadataRepository;
import io.fireflysoftware.commons.ecm.models.repositories.DocumentRepository;
import io.fireflysoftware.documents.DocumentStoreException;

import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Writes the rendered HTML onto the document core: a {@code documents} row plus
 * {@code templateCode} and {@code html} metadata. It does not open another store.
 */
public final class DocumentCoreStorageAdapter implements DocumentStoragePort {

    static final String TEMPLATE_CODE = "templateCode";
    static final String HTML = "html";
    static final String TENANT = "openplatform";
    private static final Duration TIMEOUT = Duration.ofSeconds(5);

    private final DocumentRepository documents;
    private final DocumentMetadataRepository metadata;

    public DocumentCoreStorageAdapter(DocumentRepository documents, DocumentMetadataRepository metadata) {
        this.documents = documents;
        this.metadata = metadata;
    }

    @Override
    public StoredDocument store(StoredDocument draft) {
        Document entity = new Document();
        entity.setName(draft.name());
        entity.setDescription(draft.templateCode());
        entity.setFileName(draft.templateCode() + ".html");
        entity.setFileExtension("html");
        entity.setMimeType(draft.mediaType());
        entity.setFileSize((long) draft.html().getBytes(StandardCharsets.UTF_8).length);
        entity.setDocumentType(ecmType(draft.templateCode()));
        entity.setDocumentStatus(DocumentStatus.PUBLISHED);
        entity.setStorageType(StorageType.DATABASE);
        entity.setStoragePath("document-core/" + draft.templateCode());
        entity.setSecurityLevel(SecurityLevel.CONFIDENTIAL);
        entity.setTenantId(TENANT);
        UUID id = null;
        try {
            Document saved = documents.save(entity).block(TIMEOUT);
            if (saved == null || saved.getId() == null) {
                throw new IllegalStateException("Document core did not return an id");
            }
            id = saved.getId();
            metadata.save(meta(id, TEMPLATE_CODE, draft.templateCode())).block(TIMEOUT);
            metadata.save(meta(id, HTML, draft.html())).block(TIMEOUT);
            return draft.withId(id);
        } catch (RuntimeException ex) {
            if (id != null) {
                remove(id);
            }
            throw new DocumentStoreException("The document was not stored", id, ex);
        }
    }

    @Override
    public Optional<StoredDocument> read(UUID id) {
        if (id == null) {
            return Optional.empty();
        }
        Document document = documents.findById(id).block(TIMEOUT);
        if (document == null) {
            return Optional.empty();
        }
        List<DocumentMetadata> rows = metadata.findByDocumentId(id).collectList().block(TIMEOUT);
        if (rows == null) {
            return Optional.empty();
        }
        String templateCode = value(rows, TEMPLATE_CODE);
        String html = value(rows, HTML);
        if (templateCode == null || html == null || html.isBlank()) {
            return Optional.empty();
        }
        return Optional.of(new StoredDocument(document.getId(), templateCode, document.getMimeType(), html,
                document.getName()));
    }

    @Override
    public void remove(UUID id) {
        if (id == null) {
            return;
        }
        List<DocumentMetadata> rows = metadata.findByDocumentId(id).collectList().block(TIMEOUT);
        if (rows != null) {
            for (DocumentMetadata row : rows) {
                metadata.deleteById(row.getId()).block(TIMEOUT);
            }
        }
        documents.deleteById(id).block(TIMEOUT);
    }

    private static DocumentMetadata meta(UUID documentId, String key, String value) {
        DocumentMetadata row = new DocumentMetadata();
        row.setDocumentId(documentId);
        row.setKey(key);
        row.setValue(value);
        row.setType("STRING");
        row.setIsSearchable(true);
        row.setIsSystemMetadata(true);
        row.setTenantId(TENANT);
        return row;
    }

    private static String value(List<DocumentMetadata> rows, String key) {
        for (DocumentMetadata row : rows) {
            if (key.equals(row.getKey())) {
                return row.getValue();
            }
        }
        return null;
    }

    private static DocumentType ecmType(String templateCode) {
        return switch (templateCode) {
            case "sow" -> DocumentType.CONTRACT;
            case "report" -> DocumentType.REPORT;
            default -> DocumentType.DOCUMENT;
        };
    }
}
