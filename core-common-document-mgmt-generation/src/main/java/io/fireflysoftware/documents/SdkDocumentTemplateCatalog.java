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

import io.fireflysoftware.common.reference.master.data.sdk.api.DocumentTemplatesApi;
import io.fireflysoftware.common.reference.master.data.sdk.invoker.ApiClient;
import io.fireflysoftware.common.reference.master.data.sdk.model.DocumentTemplateCatalogDTO;
import org.springframework.web.reactive.function.client.WebClientResponseException;

import java.time.Duration;

/**
 * Confirms a template code with {@code core-common-reference-master-data-sdk}.
 * Only the five codes this module can render are accepted. A missing code returns null.
 */
public final class SdkDocumentTemplateCatalog implements DocumentTemplateCatalog {

    private static final Duration TIMEOUT = Duration.ofSeconds(5);

    private final DocumentTemplatesApi templates;

    public SdkDocumentTemplateCatalog(String baseUrl) {
        ApiClient client = new ApiClient();
        client.setBasePath(strip(baseUrl));
        this.templates = new DocumentTemplatesApi(client);
    }

    @Override
    public DocumentTemplate find(String templateCode) {
        DocumentTypeCode type = DocumentTypeCode.fromCode(templateCode);
        if (type == null) {
            return null;
        }
        DocumentTemplateCatalogDTO row;
        try {
            row = templates.getDocumentTemplateByCode(type.code(), null).block(TIMEOUT);
        } catch (WebClientResponseException.NotFound notFound) {
            return null;
        }
        if (row == null || row.getStatus() != DocumentTemplateCatalogDTO.StatusEnum.ACTIVE) {
            return null;
        }
        if (!type.code().equals(row.getTemplateCode())) {
            return null;
        }
        return SandboxDocumentTemplateCatalog.definition(type);
    }

    private static String strip(String baseUrl) {
        if (baseUrl == null || baseUrl.isBlank()) {
            return "http://localhost:8080";
        }
        return baseUrl.endsWith("/") ? baseUrl.substring(0, baseUrl.length() - 1) : baseUrl;
    }
}
