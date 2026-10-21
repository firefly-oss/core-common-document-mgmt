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

package io.fireflysoftware.documents.render;

import io.fireflysoftware.documents.IssueDocument;

import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/** Values the FreeMarker templates print. Dates use US English. */
public final class DocumentModel {

    private static final DateTimeFormatter LONG = DateTimeFormatter.ofPattern("MMMM d, yyyy", Locale.US);

    private DocumentModel() {
    }

    public static Map<String, Object> of(IssueDocument command, String templateCode, String kitKind, String label) {
        Map<String, Object> party = new LinkedHashMap<>();
        party.put("id", command.party().id().toString());
        party.put("givenName", command.party().givenName());
        party.put("name", command.party().name());
        party.put("role", command.party().role());

        Map<String, Object> contract = new LinkedHashMap<>();
        contract.put("id", command.contract().id().toString());
        contract.put("status", command.contract().status());

        String family = familyLabel(command.product().family().name());
        Map<String, Object> product = new LinkedHashMap<>();
        product.put("id", command.product().id().toString());
        product.put("name", command.product().name());
        product.put("family", family);

        String issuedOn = LONG.format(command.issuedOn());
        Map<String, Object> model = new LinkedHashMap<>();
        model.put("templateCode", templateCode);
        model.put("kitKind", kitKind);
        model.put("kindLabel", label);
        model.put("party", party);
        model.put("contract", contract);
        model.put("product", product);
        model.put("currency", command.currency());
        model.put("issuedOn", issuedOn);
        model.put("effectiveOn", LONG.format(command.effectiveOn()));
        model.put("endsOn", LONG.format(command.endsOn()));
        model.put("placeDate", KitStationery.PLACE + ", " + issuedOn);
        model.put("regulatedLabel", command.regulated() ? "Regulated" : "Not regulated");
        model.put("company", KitStationery.COMPANY);
        model.put("email", KitStationery.EMAIL);
        model.put("domain", KitStationery.DOMAIN);
        model.put("slogan", KitStationery.SLOGAN);
        model.put("logoAlt", KitStationery.LOGO_ALT);
        model.put("registeredLabel", KitStationery.REGISTERED_LABEL);
        model.put("registeredLines", List.of(KitStationery.REGISTERED_LINE_1, KitStationery.REGISTERED_LINE_2));
        return model;
    }

    private static String familyLabel(String family) {
        String lower = family.toLowerCase(Locale.US);
        return Character.toUpperCase(lower.charAt(0)) + lower.substring(1);
    }
}
