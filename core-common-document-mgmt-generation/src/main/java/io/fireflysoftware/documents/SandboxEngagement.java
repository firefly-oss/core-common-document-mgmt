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

import io.fireflysoftware.domain.referencedata.catalog.DocumentLanguage;
import io.fireflysoftware.domain.referencedata.catalog.DocumentTypeCode;
import io.fireflysoftware.domain.referencedata.catalog.ProductFamilyCode;

import java.time.LocalDate;
import java.util.UUID;

/**
 * The sandbox party and agreement already used by the payments journey, and the sandbox personal loan.
 * Samples render this record. They do not invent a second customer.
 */
public final class SandboxEngagement {

    public static final UUID PARTY_ID = UUID.fromString("11111111-1111-4111-8111-111111111111");
    public static final UUID CONTRACT_ID = UUID.fromString("10000000-0000-4000-8000-000000000021");
    public static final UUID PRODUCT_ID = UUID.fromString("10000000-0000-4000-8000-000000000202");
    public static final String GIVEN_NAME = "Ada";
    public static final String PARTY_NAME = "Ada Lovelace";
    public static final String PARTY_ROLE = "Account holder";
    public static final String PRODUCT_NAME = "Personal loan";
    public static final String CURRENCY = "EUR";
    public static final String STATUS = "Draft";
    public static final LocalDate ISSUED_ON = LocalDate.of(2026, 10, 20);
    public static final LocalDate EFFECTIVE_ON = LocalDate.of(2026, 11, 1);
    public static final LocalDate ENDS_ON = LocalDate.of(2029, 11, 1);

    private SandboxEngagement() {
    }

    public static IssueDocument issue(DocumentTypeCode type) {
        return issue(type.code());
    }

    public static IssueDocument issue(String templateCode) {
        return new IssueDocument(templateCode, DocumentLanguage.EN, ProductFamilyCode.LENDING, true,
                new Party(PARTY_ID, GIVEN_NAME, PARTY_NAME, PARTY_ROLE),
                new Agreement(CONTRACT_ID, STATUS),
                new Product(PRODUCT_ID, PRODUCT_NAME, ProductFamilyCode.LENDING),
                CURRENCY, ISSUED_ON, EFFECTIVE_ON, ENDS_ON);
    }
}
