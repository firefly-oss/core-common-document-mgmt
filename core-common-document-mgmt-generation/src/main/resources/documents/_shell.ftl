<#--
Copyright 2025 Firefly Software Foundation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Page chrome from consulting/documents/templates/_base.html.j2, letter.html.j2,
_blocks.html.j2 and _cover.html.j2. The stylesheet is document.css unchanged.
-->
<#macro document kind title description shortTitle grid=false opener=false single=false letter=false companyFooter=false topRight="">
<!doctype html>
<html lang="en-GB">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title}</title>
<meta name="description" content="${description}">
<meta name="author" content="${company}">
<meta name="generator" content="Firefly consulting kit">
<meta name="firefly:kind" content="${kind}">
<meta name="firefly:template" content="${templateCode}">
<style>
<#include "document.css" parse=false>
:root{--accent:#FFB34A;--accent-text:#855414;--tint:#F3F1EB;--table-rule:#10110F;--label-dark:#FFB34A;}
@page {
  size: A4;
  margin: 25mm 22mm 25mm 22mm;
  @top-left {
    content: "";
    width: 60mm;
    background: url("<#include "compact-on-light.uri" parse=false>") no-repeat left 9.7mm / 21mm auto;
  }
  @top-right {
    content: "${shortTitle}";
    vertical-align: top;
    padding-top: 12.75mm;
    font: 400 7pt/10pt Manrope, sans-serif;
    letter-spacing: 0.1pt;
    color: #62645b;
  }
  @bottom-left {
    content: "<#if companyFooter>${company} · ${domain}<#else>Firefly Software · Confidential</#if>";
    vertical-align: top;
    padding-top: 9.5mm;
    font: 400 7pt/10pt Manrope, sans-serif;
    letter-spacing: 0.1pt;
    color: #62645b;
  }
  @bottom-right {
    content: "Page " counter(page) " of " counter(pages);
    vertical-align: top;
    padding-top: 9.5mm;
    font: 400 7pt/10pt Manrope, sans-serif;
    letter-spacing: 0.1pt;
    color: #62645b;
  }
}
@page cover { margin: 0; @top-left { content: none; background: none; } @top-right { content: none; } @bottom-left { content: none; } @bottom-right { content: none; } }
@page back { margin: 0; @top-left { content: none; background: none; } @top-right { content: none; } @bottom-left { content: none; } @bottom-right { content: none; } }
<#if letter>
@page :first {
  margin-top: 16mm;
  @top-left { content: none; background: none; }
  @top-right { content: none; }
  @bottom-left {
    content: "${company}";
    width: 36%;
    vertical-align: top;
    padding-top: 2.5mm;
    font: 600 7pt/10pt Manrope, sans-serif;
    color: #10110f;
  }
  @bottom-center {
    content: "${registeredLabel}\A ${registeredLines[0]}\A ${registeredLines[1]}";
    white-space: pre;
    text-align: left;
    width: 32%;
    vertical-align: top;
    padding-top: 2.5mm;
    font: 400 7pt/10pt Manrope, sans-serif;
    color: #62645b;
  }
  @bottom-right {
    content: "${email}\A ${domain}";
    white-space: pre;
    text-align: left;
    vertical-align: top;
    padding-top: 2.5mm;
    font: 400 7pt/10pt Manrope, sans-serif;
    color: #62645b;
  }
}
</#if>
<#if topRight != "">
@page { @top-right { content: "${topRight}"; } }
</#if>
</style>
</head>
<body class="kind-${kind}<#if grid> g</#if><#if opener> opener</#if><#if single> single</#if>">
<#nested>
</body>
</html>
</#macro>

<#macro letterhead><div class="letterhead" id="ff_letterhead" role="img" aria-label="${logoAlt}"><#include "lockup-on-light.svg" parse=false></div></#macro>
<#macro h1 id text><h1 id="${id}"><span class="t">${text}</span></h1></#macro>
<#macro h2 id text><h2 id="${id}">${text}</h2></#macro>
<#macro h3 id text><h3 id="${id}">${text}</h3></#macro>
<#macro lead text><p class="lead">${text}</p></#macro>
<#macro body text><p class="body">${text}</p></#macro>
<#macro label text><p class="label">${text}</p></#macro>
<#macro caption text><p class="caption">${text}</p></#macro>
<#macro small text><p class="small">${text}</p></#macro>

<#macro cover title subtitle>
<section class="cover cover--dark" id="ff_cover" aria-label="${kindLabel}">
<div class="art" aria-hidden="true"><#include "cover-dark.svg" parse=false></div>
<div class="lockup" role="img" aria-label="${logoAlt}"><#include "lockup-on-dark.svg" parse=false></div>
<div class="titles" style="top: 150mm">
<p class="label">${kindLabel}</p>
<p class="cover-title" role="heading" aria-level="1">${title}</p>
<p class="cover-subtitle">${subtitle}</p>
</div>
<div class="meta">
<div class="cells">
<div><span class="k">Prepared for</span>${party.name}</div>
<div><span class="k">Date</span>${issuedOn}</div>
<div><span class="k">Version</span>0.1 · Draft</div>
</div>
<p class="cover-note">Confidential. Prepared for ${party.name}; not for onward distribution.</p>
</div>
</section>
</#macro>

<#macro toc><nav class="toc" id="ff_toc" aria-label="Contents">
<p class="toc-title">Contents</p>
<#nested>
</nav></#macro>
<#macro toc1 id text><div class="t1"><a href="#${id}"><span class="n" aria-hidden="true"></span><span class="t">${text}</span><span class="pg"></span></a></div></#macro>
<#macro toc2 id text><div class="t2"><a href="#${id}"><span class="t">${text}</span><span class="pg"></span></a></div></#macro>

<#macro back>
<section class="back back--dark" id="ff_back">
<div class="lockup" role="img" aria-label="${logoAlt}"><#include "lockup-on-dark.svg" parse=false></div>
<p class="back-title">Let’s talk about what comes next.</p>
<div class="contact">
<div class="cells">
<div><span class="k">Contact</span><p>${email}</p><p>${domain}</p></div>
<div><span class="k">${registeredLabel}</span><#list registeredLines as line><p>${line}</p></#list></div>
</div>
<p class="legal">© 2026 ${company}. All rights reserved. This document is confidential and intended solely for its addressee.</p>
</div>
</section>
</#macro>

<#macro signature>
<div class="signature"><p class="closing">Kind regards,</p>
<p class="name" id="ff_signature">${company}</p>
<p class="role">${email}</p>
<p class="role">${domain}</p></div>
</#macro>
