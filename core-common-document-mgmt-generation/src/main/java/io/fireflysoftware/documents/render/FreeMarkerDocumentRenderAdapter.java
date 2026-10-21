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

import freemarker.core.HTMLOutputFormat;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import io.fireflysoftware.documents.IssueDocument;

import java.io.IOException;
import java.io.StringWriter;

/**
 * Renders consulting-kit document structures to HTML.
 * An installer replaces this class with another {@link DocumentRenderPort} when a different engine is selected.
 */
public final class FreeMarkerDocumentRenderAdapter implements DocumentRenderPort {

    public static final String MEDIA_TYPE = "text/html;charset=UTF-8";

    private final Configuration configuration;

    public FreeMarkerDocumentRenderAdapter() {
        Configuration configuration = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
        configuration.setClassLoaderForTemplateLoading(FreeMarkerDocumentRenderAdapter.class.getClassLoader(), "documents");
        configuration.setDefaultEncoding("UTF-8");
        configuration.setOutputFormat(HTMLOutputFormat.INSTANCE);
        configuration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        configuration.setLogTemplateExceptions(false);
        configuration.setWrapUncheckedExceptions(true);
        configuration.setLocalizedLookup(false);
        this.configuration = configuration;
    }

    @Override
    public RenderedDocument render(String templateCode, String kitKind, String label, IssueDocument command) {
        try {
            Template template = configuration.getTemplate(templateCode + ".ftl");
            StringWriter writer = new StringWriter();
            template.process(DocumentModel.of(command, templateCode, kitKind, label), writer);
            return new RenderedDocument(templateCode, MEDIA_TYPE, writer.toString());
        } catch (IOException | TemplateException ex) {
            throw new IllegalArgumentException("Template " + templateCode + " could not be rendered", ex);
        }
    }
}
