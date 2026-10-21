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

import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * In-memory document core used when no document service is running.
 * An installer replaces this class with {@link DocumentCoreStorageAdapter}.
 */
public final class SandboxDocumentStorageAdapter implements DocumentStoragePort {

    private final ConcurrentHashMap<UUID, StoredDocument> rows = new ConcurrentHashMap<>();

    @Override
    public StoredDocument store(StoredDocument draft) {
        UUID id = draft.id() == null ? UUID.randomUUID() : draft.id();
        StoredDocument stored = draft.withId(id);
        rows.put(id, stored);
        return stored;
    }

    @Override
    public Optional<StoredDocument> read(UUID id) {
        if (id == null) {
            return Optional.empty();
        }
        return Optional.ofNullable(rows.get(id));
    }

    @Override
    public void remove(UUID id) {
        if (id != null) {
            rows.remove(id);
        }
    }
}
