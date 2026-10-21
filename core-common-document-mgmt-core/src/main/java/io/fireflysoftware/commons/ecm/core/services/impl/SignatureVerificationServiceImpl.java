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


package io.fireflysoftware.commons.ecm.core.services.impl;

import org.fireflyframework.core.filters.FilterRequest;
import org.fireflyframework.core.filters.FilterUtils;
import org.fireflyframework.core.queries.PaginationResponse;
import io.fireflysoftware.commons.ecm.core.mappers.SignatureVerificationMapper;
import io.fireflysoftware.commons.ecm.core.services.DocumentSignatureService;
import io.fireflysoftware.commons.ecm.core.services.SignatureVerificationService;
import io.fireflysoftware.commons.ecm.interfaces.dtos.DocumentSignatureDTO;
import io.fireflysoftware.commons.ecm.interfaces.dtos.SignatureVerificationDTO;
import io.fireflysoftware.commons.ecm.interfaces.enums.SignatureStatus;
import io.fireflysoftware.commons.ecm.interfaces.enums.VerificationStatus;
import io.fireflysoftware.commons.ecm.models.entities.SignatureVerification;
import io.fireflysoftware.commons.ecm.models.repositories.SignatureVerificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import java.util.UUID;
import java.time.LocalDateTime;

/**
 * Implementation of the SignatureVerificationService interface.
 */
@Service
@Transactional
public class SignatureVerificationServiceImpl implements SignatureVerificationService {

    @Autowired
    private SignatureVerificationRepository repository;

    @Autowired
    private SignatureVerificationMapper mapper;

    @Autowired
    private DocumentSignatureService documentSignatureService;

    @Override
    public Mono<SignatureVerificationDTO> getById(UUID id) {
        return repository.findById(id)
                .map(mapper::toDTO);
    }

    @Override
    public Mono<PaginationResponse<SignatureVerificationDTO>> filter(FilterRequest<SignatureVerificationDTO> filterRequest) {
        return FilterUtils.createFilter(
                SignatureVerification.class,
                mapper::toDTO
        ).filter(filterRequest);
    }

    @Override
    public Mono<SignatureVerificationDTO> update(SignatureVerificationDTO signatureVerification) {
        if (signatureVerification.getId() == null) {
            return Mono.error(new IllegalArgumentException("ID cannot be null for update operation"));
        }

        return repository.findById(signatureVerification.getId())
                .switchIfEmpty(Mono.error(new RuntimeException("Signature verification not found with ID: " + signatureVerification.getId())))
                .flatMap(existingEntity -> {
                    SignatureVerification entityToUpdate = mapper.toEntity(signatureVerification);
                    // Preserve created info
                    entityToUpdate.setCreatedAt(existingEntity.getCreatedAt());
                    entityToUpdate.setCreatedBy(existingEntity.getCreatedBy());
                    return repository.save(entityToUpdate);
                })
                .map(mapper::toDTO);
    }

    @Override
    public Mono<SignatureVerificationDTO> create(SignatureVerificationDTO signatureVerification) {
        // Ensure ID is null for create operation
        signatureVerification.setId(null);

        // Set default values if not provided
        if (signatureVerification.getVerificationTimestamp() == null) {
            signatureVerification.setVerificationTimestamp(LocalDateTime.now());
        }
        if (signatureVerification.getVerificationStatus() == null) {
            signatureVerification.setVerificationStatus(VerificationStatus.NOT_VERIFIED);
        }

        SignatureVerification entity = mapper.toEntity(signatureVerification);
        return repository.save(entity)
                .map(mapper::toDTO);
    }

    @Override
    public Mono<Void> delete(UUID id) {
        return repository.findById(id)
                .switchIfEmpty(Mono.error(new RuntimeException("Signature verification not found with ID: " + id)))
                .flatMap(entity -> repository.delete(entity));
    }

    @Override
    public Flux<SignatureVerificationDTO> getByDocumentSignatureId(UUID documentSignatureId) {
        return repository.findByDocumentSignatureId(documentSignatureId)
                .map(mapper::toDTO);
    }

    @Override
    public Mono<SignatureVerificationDTO> getLatestVerification(UUID documentSignatureId) {
        return repository.findFirstByDocumentSignatureIdOrderByVerificationTimestampDesc(documentSignatureId)
                .map(mapper::toDTO);
    }

    @Override
    public Flux<SignatureVerificationDTO> getByVerificationStatus(VerificationStatus verificationStatus) {
        return repository.findByVerificationStatus(verificationStatus)
                .map(mapper::toDTO);
    }

    @Override
    public Mono<SignatureVerificationDTO> verifySignature(UUID documentSignatureId) {
        return documentSignatureService.getById(documentSignatureId)
                .switchIfEmpty(Mono.error(new RuntimeException("Document signature not found with ID: " + documentSignatureId)))
                .flatMap(signature -> {
                    VerificationStatus status = recordedStatus(signature);
                    boolean certificatePresent = signature.getSignatureCertificate() != null
                            && !signature.getSignatureCertificate().isBlank();
                    SignatureVerificationDTO verification = SignatureVerificationDTO.builder()
                            .documentSignatureId(documentSignatureId)
                            .verificationStatus(status)
                            .verificationDetails(details(status))
                            .verificationProvider(signature.getSignatureProviderId() == null
                                    ? null : signature.getSignatureProviderId().toString())
                            .verificationTimestamp(LocalDateTime.now())
                            .certificateValid(certificatePresent && status == VerificationStatus.VALID)
                            .certificateDetails(signature.getSignatureCertificate())
                            .certificateValidUntil(signature.getExpirationDate())
                            .tenantId(signature.getTenantId())
                            .build();
                    return create(verification);
                });
    }

    private static VerificationStatus recordedStatus(DocumentSignatureDTO signature) {
        SignatureStatus recorded = signature.getSignatureStatus();
        boolean signed = recorded == SignatureStatus.SIGNED
                && signature.getSignatureData() != null
                && !signature.getSignatureData().isBlank();
        boolean expired = signature.getExpirationDate() != null
                && !signature.getExpirationDate().isAfter(LocalDateTime.now());
        if (signed && !expired) {
            return VerificationStatus.VALID;
        }
        if (recorded == null || recorded == SignatureStatus.PENDING || recorded == SignatureStatus.IN_PROGRESS) {
            return VerificationStatus.NOT_VERIFIED;
        }
        return VerificationStatus.INVALID;
    }

    private static String details(VerificationStatus status) {
        return switch (status) {
            case VALID -> "Stored signature is signed and unexpired";
            case NOT_VERIFIED -> "Stored signature is not signed";
            default -> "Stored signature is not a current signature";
        };
    }

    @Override
    public Flux<SignatureVerificationDTO> verifyAllSignaturesForDocument(UUID documentId) {
        // Get all signatures for the document and verify each one
        return documentSignatureService.getByDocumentId(documentId)
                .flatMap(signature -> verifySignature(signature.getId()));
    }
}
