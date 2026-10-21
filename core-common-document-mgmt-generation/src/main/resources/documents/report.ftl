<#include "_shell.ftl">
<#assign pageTitle = "The personal loan agreement runs to November 2029">
<@document kind="report" title=pageTitle grid=true opener=true footer="confidential">
<@cover pageTitle product.name + " for " + party.name + ", denominated in " + currency/>
<nav class="toc" id="ff_toc" aria-label="Contents">
<p class="toc-title">Contents</p>
<@toc1 "ff_summary" "Executive summary"/>
<@toc1 "ff_context" "Context and objectives"/>
<@toc2 "ff_scope" "Scope"/>
<@toc1 "ff_findings" "Findings"/>
<@toc1 "ff_recommendations" "Recommendations"/>
<@toc1 "ff_roadmap" "Roadmap and next steps"/>
</nav>
<main>
<@h1 "ff_summary" "Executive summary"/>
<p class="lead">Agreement ${contract.id} is a ${product.name} for ${party.name}, denominated in ${currency}, effective ${effectiveOn} and ending ${endsOn}.</p>
<p>The agreement was issued on ${issuedOn}. Its status is ${contract.status}. ${party.name} is the ${party.role}. The product family is ${product.family}, and the agreement is ${regulatedLabel?lower_case}.</p>
<ul>
<li>Party ${party.id} is ${party.name}.</li>
<li>Product ${product.id} is ${product.name}.</li>
<li>The currency on the agreement is ${currency}. This report states no fee.</li>
</ul>
<@h2 "ff_recommend_now" "What we recommend"/>
<ol>
<li>${party.name} keeps agreement ${contract.id} with this report.</li>
<li>${company} answers questions at ${email} before ${effectiveOn}.</li>
<li>The agreement takes effect on ${effectiveOn}.</li>
</ol>
<@h1 "ff_context" "Context and objectives"/>
<p>This report records the ${product.name} issued to ${party.name} on ${issuedOn}. The question it answers is what the agreement record contains: who it is for, which product it uses, which currency it uses, and which dates it runs.</p>
<@h2 "ff_scope" "Scope"/>
<table>
<colgroup><col style="width: 24%"><col style="width: 38%"><col style="width: 38%"></colgroup>
<thead><tr><th>Area</th><th>In this report</th><th>Not in this report</th></tr></thead>
<tbody>
<tr><td>Party</td><td>${party.name}, ${party.id}</td><td>Any person other than ${party.name}</td></tr>
<tr><td>Agreement</td><td>${contract.id}, status ${contract.status}</td><td>A fee or an amount other than the currency ${currency}</td></tr>
<tr><td>Product</td><td>${product.name}, ${product.id}, ${product.family}</td><td>Any product other than ${product.name}</td></tr>
</tbody>
</table>
<p class="caption">Source: agreement ${contract.id}, issued ${issuedOn}.</p>
<@h1 "ff_findings" "Findings"/>
<p>The findings below are the fields on the agreement record. They are not estimates.</p>
<@h2 "ff_finding_party" party.name + " is the " + party.role/>
<p>The party identifier is ${party.id}. The role on the agreement is ${party.role}.</p>
<@h2 "ff_finding_terms" "The agreement is denominated in " + currency/>
<p>Product ${product.name} (${product.id}) is in the ${product.family} family. The agreement is ${regulatedLabel?lower_case}. It runs from ${effectiveOn} through ${endsOn}.</p>
<table>
<colgroup><col style="width: 34%"><col style="width: 33%"><col style="width: 33%"></colgroup>
<thead><tr><th>Field</th><th>Value</th><th>Source</th></tr></thead>
<tbody>
<tr><td>Status</td><td>${contract.status}</td><td>Agreement ${contract.id}</td></tr>
<tr><td>Issued</td><td>${issuedOn}</td><td>Agreement ${contract.id}</td></tr>
<tr><td>Effective</td><td>${effectiveOn}</td><td>Agreement ${contract.id}</td></tr>
<tr><td>Ends</td><td>${endsOn}</td><td>Agreement ${contract.id}</td></tr>
<tr><td>Currency</td><td>${currency}</td><td>Agreement ${contract.id}</td></tr>
</tbody>
</table>
<p class="caption">Fields on agreement ${contract.id}. Party ${party.id}. Product ${product.id}.</p>
<@h1 "ff_recommendations" "Recommendations"/>
<p>Turn the record into the next action for ${party.name} and for ${company}.</p>
<@h2 "ff_recommendation_one" "Keep the agreement identifier with the party"/>
<p>${party.name} holds agreement ${contract.id}. The effective date is ${effectiveOn}. Questions go to ${email} and include that identifier.</p>
<@h1 "ff_roadmap" "Roadmap and next steps"/>
<table>
<colgroup><col style="width: 26%"><col style="width: 28%"><col style="width: 46%"></colgroup>
<thead><tr><th>Point</th><th>Date</th><th>Outcome</th></tr></thead>
<tbody>
<tr><td>Issued</td><td>${issuedOn}</td><td>Agreement ${contract.id} recorded as ${contract.status}</td></tr>
<tr><td>Effective</td><td>${effectiveOn}</td><td>${product.name} in ${currency} takes effect</td></tr>
<tr><td>Ends</td><td>${endsOn}</td><td>End date on the agreement record</td></tr>
</tbody>
</table>
<p class="caption">Dates on agreement ${contract.id}.</p>
<@facts/>
</main>
<@back "Questions about agreement " + contract.id/>
</@document>
