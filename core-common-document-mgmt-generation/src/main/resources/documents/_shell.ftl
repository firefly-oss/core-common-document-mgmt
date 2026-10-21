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

Structure, section ids, and stylesheet follow the Firefly consulting kit documents.
The mark is not redrawn here. The letterhead slot keeps the kit's accessible name.
-->
<#macro document kind title letter=false grid=false single=false opener=false footer="confidential">
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title}</title>
<meta name="author" content="${company}">
<meta name="description" content="${product.name} for ${party.name}">
<meta name="firefly:kind" content="${kitKind}">
<meta name="firefly:template" content="${templateCode}">
<style>
<#include "document.css" parse=false>
@page {
  size: A4;
  margin: 25mm 22mm 25mm 22mm;
  @top-right {
    content: "${kindLabel}";
    vertical-align: top;
    padding-top: 12.75mm;
    font: 400 7pt/10pt Manrope, sans-serif;
    letter-spacing: 0.1pt;
    color: #62645b;
  }
  @bottom-left {
    content: "<#if footer == "company">Firefly Software<#else>Firefly Software · Confidential</#if>";
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
@page cover { margin: 0; @top-right { content: none; } @bottom-left { content: none; } @bottom-right { content: none; } }
@page back { margin: 0; @top-right { content: none; } @bottom-left { content: none; } @bottom-right { content: none; } }
<#if letter>
@page :first {
  margin-top: 16mm;
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
</style>
</head>
<body class="kind-${kind}<#if grid> g</#if><#if opener> opener</#if><#if single> single</#if>">
<#nested>
</body>
</html>
</#macro>

<#macro letterhead>
<div class="letterhead" id="ff_letterhead" role="img" aria-label="${logoAlt}"></div>
</#macro>

<#macro recipient>
<div class="recipient" id="ff_recipient">
<p>${party.name}</p>
<p>${party.role}</p>
</div>
</#macro>

<#macro signature>
<div class="signature" id="ff_signature">
<p class="closing">Kind regards,</p>
<p class="name">${company}</p>
<p class="role">${email}</p>
<p class="role">${domain}</p>
</div>
</#macro>

<#macro facts>
<div class="fields" id="ff_facts">
<div class="row"><span class="k">Party</span><span class="v">${party.name}</span></div>
<div class="row"><span class="k">Role</span><span class="v">${party.role}</span></div>
<div class="row"><span class="k">Party identifier</span><span class="v">${party.id}</span></div>
<div class="row"><span class="k">Agreement</span><span class="v">${contract.id}</span></div>
<div class="row"><span class="k">Status</span><span class="v">${contract.status}</span></div>
<div class="row"><span class="k">Product</span><span class="v">${product.name}</span></div>
<div class="row"><span class="k">Product identifier</span><span class="v">${product.id}</span></div>
<div class="row"><span class="k">Product family</span><span class="v">${product.family}</span></div>
<div class="row"><span class="k">Currency</span><span class="v">${currency}</span></div>
<div class="row"><span class="k">Issued</span><span class="v">${issuedOn}</span></div>
<div class="row"><span class="k">Effective</span><span class="v">${effectiveOn}</span></div>
<div class="row"><span class="k">Ends</span><span class="v">${endsOn}</span></div>
<div class="row"><span class="k">Regulation</span><span class="v">${regulatedLabel}</span></div>
</div>
</#macro>

<#macro cover title subtitle>
<section class="cover cover--dark" id="ff_cover" aria-label="${kindLabel}">
<div class="lockup" role="img" aria-label="${logoAlt}"></div>
<div class="titles" style="top: 150mm">
<p class="label">${kindLabel}</p>
<p class="cover-title" role="heading" aria-level="1">${title}</p>
<p class="cover-subtitle">${subtitle}</p>
</div>
<div class="meta">
<div class="cells">
<div><span class="k">Prepared for</span>${party.name}</div>
<div><span class="k">Date</span>${issuedOn}</div>
<div><span class="k">Agreement</span>${contract.id}</div>
</div>
<p class="cover-note">Confidential. Prepared for ${party.name}. Agreement ${contract.id}.</p>
</div>
</section>
</#macro>

<#macro back title>
<section class="back back--dark" id="ff_back">
<div class="lockup" role="img" aria-label="${logoAlt}"></div>
<p class="back-title">${title}</p>
<div class="contact">
<div class="cells">
<div><span class="k">Contact</span><p>${email}</p><p>${domain}</p></div>
<div><span class="k">${registeredLabel}</span><#list registeredLines as line><p>${line}</p></#list></div>
</div>
<p class="legal">${company}. Agreement ${contract.id}, denominated in ${currency}.</p>
</div>
</section>
</#macro>

<#macro h1 id text><h1 id="${id}"><span class="t">${text}</span></h1></#macro>
<#macro h2 id text><h2 id="${id}">${text}</h2></#macro>
<#macro toc1 id text><div class="t1"><a href="#${id}"><span class="n" aria-hidden="true"></span><span class="t">${text}</span></a></div></#macro>
<#macro toc2 id text><div class="t2"><a href="#${id}"><span class="t">${text}</span></a></div></#macro>
