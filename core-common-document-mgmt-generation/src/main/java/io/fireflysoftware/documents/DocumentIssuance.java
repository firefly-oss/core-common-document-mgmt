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

import io.fireflysoftware.domain.referencedata.catalog.CatalogCode;
import io.fireflysoftware.domain.referencedata.catalog.CatalogEntry;
import io.fireflysoftware.domain.referencedata.catalog.CatalogStatus;
import io.fireflysoftware.domain.referencedata.catalog.ReferenceCatalogPort;
import io.fireflysoftware.documents.render.DocumentRenderPort;
import io.fireflysoftware.documents.render.RenderedDocument;
import io.fireflysoftware.documents.storage.DocumentStoragePort;
import io.fireflysoftware.documents.storage.StoredDocument;

import java.time.Duration;
import java.util.UUID;
import java.util.regex.Pattern;

/**
 * Resolves a consulting-kit template from {@link ReferenceCatalogPort}, renders it, and stores it
 * in the document core through {@link DocumentStoragePort}.
 */
public final class DocumentIssuance implements DocumentPort {

    private static final Pattern CURRENCY = Pattern.compile("^[A-Z]{3}$");
    private static final Duration READ_TIMEOUT = Duration.ofSeconds(5);

    private final ReferenceCatalogPort catalogs;
    private final DocumentRenderPort renderer;
    private final DocumentStoragePort storage;

    public DocumentIssuance(ReferenceCatalogPort catalogs, DocumentRenderPort renderer, DocumentStoragePort storage) {
        this.catalogs = catalogs;
        this.renderer = renderer;
        this.storage = storage;
    }

    @Override
    public IssuedDocument issue(IssueDocument command) {
        validate(command);
        CatalogEntry template = resolve(command);
        RenderedDocument rendered = renderer.render(template.attributes().get("templateCode"),
                template.attributes().get("kitKind"), template.label(), command);
        if (rendered.html() == null || rendered.html().isBlank()) {
            throw new IllegalArgumentException("Template " + command.templateCode() + " rendered an empty document");
        }
        String name = template.label() + " for " + command.party().name();
        try {
            StoredDocument stored = storage.store(new StoredDocument(null, template.code(), rendered.mediaType(),
                    rendered.html(), name));
            return toIssued(stored);
        } catch (DocumentStoreException ex) {
            if (ex.documentId() != null) {
                storage.remove(ex.documentId());
            }
            throw ex;
        }
    }

    @Override
    public IssuedDocument read(UUID documentId) {
        if (documentId == null) {
            throw new IllegalArgumentException("Document id is required");
        }
        return storage.read(documentId).map(DocumentIssuance::toIssued)
                .orElseThrow(() -> new DocumentNotFoundException(documentId));
    }

    private CatalogEntry resolve(IssueDocument command) {
        CatalogEntry entry = catalogs.find(CatalogCode.DOCUMENT_TYPE, command.templateCode()).block(READ_TIMEOUT);
        if (entry == null || entry.status() != CatalogStatus.ACTIVE) {
            throw unknown(command);
        }
        String language = entry.attributes().get("language");
        String family = entry.attributes().get("productFamily");
        String regulated = entry.attributes().get("regulated");
        String templateCode = entry.attributes().get("templateCode");
        boolean sameLanguage = command.language().code().equals(language);
        boolean sameFamily = command.productFamily().name().equals(family);
        boolean sameRegulated = Boolean.toString(command.regulated()).equals(regulated);
        boolean sameTemplate = command.templateCode().equals(templateCode);
        if (!sameLanguage || !sameFamily || !sameRegulated || !sameTemplate) {
            throw unknown(command);
        }
        return entry;
    }

    private static UnknownDocumentTypeException unknown(IssueDocument command) {
        return new UnknownDocumentTypeException("No document template is catalogued for type '"
                + command.templateCode() + "' with language " + command.language().code()
                + ", product family " + command.productFamily().name()
                + ", and regulated " + command.regulated() + ". Nothing was stored.");
    }

    private static void validate(IssueDocument command) {
        if (command == null) {
            throw new IllegalArgumentException("Document request is required");
        }
        if (command.templateCode() == null || command.templateCode().isBlank()) {
            throw new IllegalArgumentException("Document type is required");
        }
        if (command.language() == null) {
            throw new IllegalArgumentException("Document language is required");
        }
        if (command.productFamily() == null) {
            throw new IllegalArgumentException("Product family is required");
        }
        if (command.party() == null || command.party().id() == null || command.party().name() == null
                || command.party().name().isBlank() || command.party().givenName() == null
                || command.party().givenName().isBlank() || command.party().role() == null
                || command.party().role().isBlank()) {
            throw new IllegalArgumentException("Party id, given name, name, and role are required");
        }
        if (command.contract() == null || command.contract().id() == null || command.contract().status() == null
                || command.contract().status().isBlank()) {
            throw new IllegalArgumentException("Agreement id and status are required");
        }
        if (command.product() == null || command.product().id() == null || command.product().name() == null
                || command.product().name().isBlank() || command.product().family() == null) {
            throw new IllegalArgumentException("Product id, name, and family are required");
        }
        if (command.product().family() != command.productFamily()) {
            throw new IllegalArgumentException("Product family does not match the document request");
        }
        if (command.currency() == null || !CURRENCY.matcher(command.currency()).matches()) {
            throw new IllegalArgumentException("Currency must be a three-letter code");
        }
        if (command.issuedOn() == null || command.effectiveOn() == null || command.endsOn() == null) {
            throw new IllegalArgumentException("Issued, effective, and end dates are required");
        }
    }

    private static IssuedDocument toIssued(StoredDocument stored) {
        return new IssuedDocument(stored.id(), stored.templateCode(), stored.mediaType(), stored.html(), stored.name());
    }
}
