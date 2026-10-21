<#include "_shell.ftl">
<#assign pageTitle = party.name + "'s personal loan statement of work">
<@document kind="sow" title=pageTitle grid=true opener=true footer="confidential">
<@cover pageTitle "Between " + party.name + " and " + company + ", agreement " + contract.id/>
<nav class="toc" id="ff_toc" aria-label="Contents">
<p class="toc-title">Contents</p>
<@toc1 "ff_purpose" "Purpose and background"/>
<@toc1 "ff_scope" "Scope"/>
<@toc1 "ff_deliverables" "Deliverables"/>
<@toc1 "ff_assumptions" "Assumptions and dependencies"/>
<@toc1 "ff_acceptance" "Acceptance"/>
<@toc1 "ff_governance" "Governance"/>
<@toc1 "ff_change_control" "Change control"/>
<@toc1 "ff_fees" "Fees and invoicing"/>
<@toc1 "ff_approval" "Approval"/>
</nav>
<main>
<@h1 "ff_purpose" "Purpose and background"/>
<p class="lead">This statement of work describes agreement ${contract.id} between ${party.name} and ${company}. It states the ${product.name}, the currency ${currency}, and the dates on the record.</p>
<p>The agreement was issued on ${issuedOn}. Its status is ${contract.status}. It takes effect on ${effectiveOn} and ends on ${endsOn}.</p>
<@h1 "ff_scope" "Scope"/>
<p>The scope is the ${product.name} named on agreement ${contract.id}. Anything not listed here is outside this statement of work.</p>
<table>
<colgroup><col style="width: 22%"><col style="width: 39%"><col style="width: 39%"></colgroup>
<thead><tr><th>Area</th><th>In scope</th><th>Out of scope</th></tr></thead>
<tbody>
<tr><td>Party</td><td>${party.name}, ${party.role}, ${party.id}</td><td>Any other party</td></tr>
<tr><td>Product</td><td>${product.name}, ${product.id}, family ${product.family}</td><td>Any other product</td></tr>
<tr><td>Term</td><td>${effectiveOn} through ${endsOn}, currency ${currency}</td><td>A fee or an amount</td></tr>
</tbody>
</table>
<p class="caption">Scope of agreement ${contract.id}, issued ${issuedOn}.</p>
<@h1 "ff_deliverables" "Deliverables"/>
<p>The deliverable is the agreement record ${party.name} can identify and ${company} can answer questions about.</p>
<table>
<colgroup><col style="width: 12%"><col style="width: 38%"><col style="width: 30%"><col style="width: 20%"></colgroup>
<thead><tr><th>ID</th><th>Deliverable</th><th>Acceptance</th><th>Due</th></tr></thead>
<tbody>
<tr><td>D1</td><td>Agreement ${contract.id} for the ${product.name}</td><td>${party.name} can match party ${party.id} and product ${product.id}</td><td>${effectiveOn}</td></tr>
</tbody>
</table>
<p class="caption">Deliverable on agreement ${contract.id}.</p>
<@h2 "ff_timeline" "Timeline"/>
<p>The agreement was issued on ${issuedOn}, takes effect on ${effectiveOn}, and ends on ${endsOn}.</p>
<@h2 "ff_roles" "Roles and responsibilities"/>
<table>
<colgroup><col style="width: 40%"><col style="width: 30%"><col style="width: 30%"></colgroup>
<thead><tr><th>Activity</th><th>${company}</th><th>${party.name}</th></tr></thead>
<tbody>
<tr><td>Keep the agreement record</td><td>Responsible</td><td>Informed</td></tr>
<tr><td>Hold the ${party.role} role</td><td>Informed</td><td>Responsible</td></tr>
<tr><td>Questions about the agreement</td><td>Responsible, at ${email}</td><td>Sends agreement ${contract.id}</td></tr>
</tbody>
</table>
<p class="caption">Roles on agreement ${contract.id}.</p>
<@h1 "ff_assumptions" "Assumptions and dependencies"/>
<p>This statement uses only the fields recorded on the agreement.</p>
<ul>
<li>${party.name} is the ${party.role}, party ${party.id}.</li>
<li>The product is ${product.name}, ${product.id}, family ${product.family}, ${regulatedLabel?lower_case}.</li>
<li>The currency is ${currency}.</li>
<li>The status on ${issuedOn} is ${contract.status}.</li>
</ul>
<@h1 "ff_acceptance" "Acceptance"/>
<p>${company} provides agreement ${contract.id} with the party, product, currency, and dates in this statement. ${party.name} accepts that record or sends a question to ${email} before ${effectiveOn}.</p>
<ol>
<li>The record shows party ${party.id}, product ${product.id}, and currency ${currency}.</li>
<li>${party.name} reviews it before ${effectiveOn}.</li>
<li>A question names agreement ${contract.id}.</li>
<li>${company} answers at ${email}.</li>
</ol>
<@h1 "ff_governance" "Governance"/>
<table>
<colgroup><col style="width: 24%"><col style="width: 36%"><col style="width: 16%"><col style="width: 24%"></colgroup>
<thead><tr><th>Forum</th><th>Members</th><th>When</th><th>Purpose</th></tr></thead>
<tbody>
<tr><td>Agreement record</td><td>${party.name}; ${company}</td><td>${effectiveOn}</td><td>The ${product.name} takes effect</td></tr>
</tbody>
</table>
<p class="caption">The parties on agreement ${contract.id}. No other forum is named.</p>
<@h1 "ff_change_control" "Change control"/>
<p>A change to agreement ${contract.id} is sent in writing to ${email} and names the agreement identifier. ${company} records the change against that identifier. No change is made by this statement of work itself. The record remains status ${contract.status} as issued on ${issuedOn}.</p>
<@h1 "ff_fees" "Fees and invoicing"/>
<p>Agreement ${contract.id} is denominated in ${currency}. This statement of work does not set a fee, a rate, or an amount.</p>
<table>
<colgroup><col style="width: 40%"><col style="width: 36%"><col style="width: 24%"></colgroup>
<thead><tr><th>Item</th><th>Basis</th><th>Currency</th></tr></thead>
<tbody>
<tr><td>${product.name}</td><td>Agreement ${contract.id}</td><td>${currency}</td></tr>
</tbody>
</table>
<p class="caption">Currency on agreement ${contract.id}. No amount is stated.</p>
<@h1 "ff_approval" "Approval"/>
<table>
<colgroup><col style="width: 28%"><col style="width: 36%"><col style="width: 36%"></colgroup>
<thead><tr><th>Party</th><th>Name</th><th>Role</th></tr></thead>
<tbody>
<tr><td>${party.role}</td><td>${party.name}</td><td>Party ${party.id}</td></tr>
<tr><td>Provider</td><td>${company}</td><td>${email}</td></tr>
</tbody>
</table>
<p class="caption">Named parties on agreement ${contract.id}, issued ${issuedOn}.</p>
<@facts/>
</main>
<@back "Agreement " + contract.id/>
</@document>
