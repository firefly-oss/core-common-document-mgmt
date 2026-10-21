<#include "_shell.ftl">
<#assign pageTitle = "A personal loan agreement for " + party.name>
<@document kind="proposal" title=pageTitle grid=true opener=true footer="confidential">
<@cover pageTitle product.name + " in " + currency + ", effective " + effectiveOn/>
<nav class="toc" id="ff_toc" aria-label="Contents">
<p class="toc-title">Contents</p>
<@toc1 "ff_summary" "Executive summary"/>
<@toc1 "ff_context" "Context and objectives"/>
<@toc1 "ff_approach" "Our approach"/>
<@toc1 "ff_plan" "Plan and timeline"/>
<@toc1 "ff_team" "Team"/>
<@toc1 "ff_commercials" "Commercials"/>
<@toc1 "ff_next_steps" "Next steps"/>
<@toc1 "ff_appendix" "Appendix"/>
</nav>
<main>
<@h1 "ff_summary" "Executive summary"/>
<p class="lead">${party.name} is offered agreement ${contract.id}: a ${product.name} denominated in ${currency}, effective ${effectiveOn} and ending ${endsOn}.</p>
<p>The agreement was issued on ${issuedOn}. Its status is ${contract.status}. ${company} is the provider. This proposal states the record. It does not add a fee.</p>
<table>
<colgroup><col style="width: 30%"><col style="width: 70%"></colgroup>
<thead><tr><th>At a glance</th><th>In brief</th></tr></thead>
<tbody>
<tr><td>Outcome</td><td>${product.name} for ${party.name}</td></tr>
<tr><td>Agreement</td><td>${contract.id}, status ${contract.status}</td></tr>
<tr><td>Currency</td><td>${currency}</td></tr>
<tr><td>Effective</td><td>${effectiveOn}</td></tr>
<tr><td>Ends</td><td>${endsOn}</td></tr>
</tbody>
</table>
<p class="caption">Agreement ${contract.id}. Product ${product.id}. Party ${party.id}.</p>
<@h1 "ff_context" "Context and objectives"/>
<p>The agreement names ${party.name} as ${party.role}. The product is ${product.name}, family ${product.family}, identifier ${product.id}. The agreement is ${regulatedLabel?lower_case}.</p>
<@h2 "ff_objectives" "What the agreement records"/>
<ol>
<li>${party.name}, party ${party.id}, is the ${party.role}.</li>
<li>The product family is ${product.family}.</li>
<li>The agreement runs from ${effectiveOn} through ${endsOn}.</li>
</ol>
<@h1 "ff_approach" "Our approach"/>
<p>${company} records the agreement, gives ${party.name} the identifier ${contract.id}, and answers questions at ${email}.</p>
<@h2 "ff_phase_record" "Record"/>
<p>The agreement was issued on ${issuedOn} with status ${contract.status}.</p>
<@h2 "ff_phase_effective" "Effective date"/>
<p>The ${product.name} takes effect on ${effectiveOn} and is denominated in ${currency}.</p>
<@h2 "ff_phase_end" "End date"/>
<p>The agreement ends on ${endsOn}.</p>
<@h1 "ff_plan" "Plan and timeline"/>
<table>
<colgroup><col style="width: 22%"><col style="width: 28%"><col style="width: 50%"></colgroup>
<thead><tr><th>Point</th><th>Date</th><th>Decision at that date</th></tr></thead>
<tbody>
<tr><td>Issued</td><td>${issuedOn}</td><td>Agreement ${contract.id} is on the record</td></tr>
<tr><td>Effective</td><td>${effectiveOn}</td><td>${product.name} in ${currency} takes effect</td></tr>
<tr><td>Ends</td><td>${endsOn}</td><td>The recorded end of the agreement</td></tr>
</tbody>
</table>
<p class="caption">Dates on agreement ${contract.id}.</p>
<@h1 "ff_team" "Team"/>
<p>The parties named on the agreement are ${party.name} and ${company}.</p>
<table>
<colgroup><col style="width: 28%"><col style="width: 40%"><col style="width: 32%"></colgroup>
<thead><tr><th>Role</th><th>Name</th><th>Responsibility</th></tr></thead>
<tbody>
<tr><td>${party.role}</td><td>${party.name}</td><td>Party ${party.id} on agreement ${contract.id}</td></tr>
<tr><td>Provider</td><td>${company}</td><td>Keeps the agreement and answers ${email}</td></tr>
</tbody>
</table>
<p class="caption">No other person is named on agreement ${contract.id}.</p>
<@h1 "ff_commercials" "Commercials"/>
<p>The agreement is denominated in ${currency}. This proposal does not state a fee, a rate, or an amount.</p>
<table>
<colgroup><col style="width: 28%"><col style="width: 46%"><col style="width: 26%"></colgroup>
<thead><tr><th>Item</th><th>What it covers</th><th>Currency</th></tr></thead>
<tbody>
<tr><td>${product.name}</td><td>Agreement ${contract.id} for ${party.name}</td><td>${currency}</td></tr>
</tbody>
</table>
<p class="caption">Product ${product.id}. Issued ${issuedOn}. Effective ${effectiveOn}.</p>
<@h2 "ff_terms" "Terms on the record"/>
<ul>
<li>Status: ${contract.status}.</li>
<li>Regulation: ${regulatedLabel}.</li>
<li>Contact: ${email}.</li>
</ul>
<@h1 "ff_next_steps" "Next steps"/>
<ol>
<li>${party.name} keeps agreement ${contract.id}.</li>
<li>Questions go to ${email} before ${effectiveOn}.</li>
<li>The agreement takes effect on ${effectiveOn}.</li>
</ol>
<@h1 "ff_appendix" "Appendix"/>
<@h2 "ff_identifiers" "Identifiers"/>
<@facts/>
</main>
<@back "Agreement " + contract.id/>
</@document>
