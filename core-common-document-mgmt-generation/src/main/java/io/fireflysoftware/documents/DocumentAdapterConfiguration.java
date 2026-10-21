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

package io.fireflysoftware.documents;

import io.fireflysoftware.commons.ecm.models.repositories.DocumentMetadataRepository;
import io.fireflysoftware.commons.ecm.models.repositories.DocumentRepository;
import io.fireflysoftware.documents.render.DocumentRenderPort;
import io.fireflysoftware.documents.render.FreeMarkerDocumentRenderAdapter;
import io.fireflysoftware.documents.storage.DocumentCoreStorageAdapter;
import io.fireflysoftware.documents.storage.DocumentStoragePort;
import io.fireflysoftware.documents.storage.SandboxDocumentStorageAdapter;
import io.fireflysoftware.domain.referencedata.catalog.ReferenceCatalogPort;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Sandbox storage and FreeMarker are the defaults. Neither opens a network connection.
 * {@code firefly.documents.storage=core} selects the document-core adapter.
 * {@code firefly.documents.render=freemarker} selects FreeMarker. A future engine replaces that bean.
 */
@Configuration
public class DocumentAdapterConfiguration {

    @Bean
    @ConditionalOnProperty(prefix = "firefly.documents", name = "render", havingValue = "freemarker", matchIfMissing = true)
    public DocumentRenderPort freeMarkerDocumentRenderPort() {
        return new FreeMarkerDocumentRenderAdapter();
    }

    @Bean
    @ConditionalOnProperty(prefix = "firefly.documents", name = "storage", havingValue = "sandbox", matchIfMissing = true)
    public DocumentStoragePort sandboxDocumentStoragePort() {
        return new SandboxDocumentStorageAdapter();
    }

    @Bean
    @ConditionalOnProperty(prefix = "firefly.documents", name = "storage", havingValue = "core")
    public DocumentStoragePort documentCoreStoragePort(DocumentRepository documents, DocumentMetadataRepository metadata) {
        return new DocumentCoreStorageAdapter(documents, metadata);
    }

    @Bean
    public DocumentPort documentPort(ReferenceCatalogPort catalogs, DocumentRenderPort renderer, DocumentStoragePort storage) {
        return new DocumentIssuance(catalogs, renderer, storage);
    }
}
