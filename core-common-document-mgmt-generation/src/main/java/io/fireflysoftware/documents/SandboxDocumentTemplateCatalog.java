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

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * The five template codes, held in this module. Nothing here opens a socket.
 * Each row is English, lending, and regulated, which is the sandbox engagement.
 */
public final class SandboxDocumentTemplateCatalog implements DocumentTemplateCatalog {

    private final Map<String, DocumentTemplate> templates;

    public SandboxDocumentTemplateCatalog() {
        Map<String, DocumentTemplate> rows = new LinkedHashMap<>();
        for (DocumentTypeCode type : DocumentTypeCode.values()) {
            rows.put(type.code(), definition(type));
        }
        this.templates = Map.copyOf(rows);
    }

    public static DocumentTemplate definition(DocumentTypeCode type) {
        return new DocumentTemplate(type.code(), type.kitKind(), type.label(),
                DocumentLanguage.EN, ProductFamilyCode.LENDING, true, true);
    }

    @Override
    public DocumentTemplate find(String templateCode) {
        if (templateCode == null || templateCode.isBlank()) {
            return null;
        }
        return templates.get(templateCode.trim());
    }
}
