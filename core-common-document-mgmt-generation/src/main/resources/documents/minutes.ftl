<#include "_shell.ftl">
<#assign pageTitle = "Minutes for " + party.name + "'s personal loan">
<@document kind="minutes" title=pageTitle grid=true footer="confidential">
<main>
<p class="label">Meeting minutes</p>
<p class="title">Minutes for ${party.name}'s personal loan</p>
<div class="fields" id="ff_minutes_header">
<div class="row"><span class="k">Date</span><span class="v">${issuedOn}</span></div>
<div class="row"><span class="k">Subject</span><span class="v">Agreement ${contract.id}</span></div>
<div class="row"><span class="k">Chair</span><span class="v">${company}</span></div>
<div class="row"><span class="k">Attendees</span><span class="v">${party.name} (${party.role}); ${company}</span></div>
<div class="row"><span class="k">Record</span><span class="v">${email}</span></div>
</div>
<@h1 "ff_agenda" "Agenda"/>
<ol>
<li>Agreement ${contract.id} for ${party.name}.</li>
<li>Product ${product.name}, identifier ${product.id}.</li>
<li>Dates ${effectiveOn} through ${endsOn}, currency ${currency}.</li>
</ol>
<@h1 "ff_discussion" "Discussion"/>
<@h2 "ff_discussion_agreement" "1. The agreement"/>
<p>Agreement ${contract.id} is ${contract.status}. It was issued on ${issuedOn}. ${party.name}, party ${party.id}, is the ${party.role}.</p>
<@h2 "ff_discussion_product" "2. The product"/>
<p>The product is ${product.name}, family ${product.family}, identifier ${product.id}. It is ${regulatedLabel?lower_case}. The agreement is denominated in ${currency}.</p>
<@h2 "ff_discussion_dates" "3. The dates"/>
<p>The agreement takes effect on ${effectiveOn} and ends on ${endsOn}. No other date was recorded.</p>
<@h1 "ff_decisions" "Decisions"/>
<table>
<colgroup><col style="width: 10%"><col style="width: 62%"><col style="width: 28%"></colgroup>
<thead><tr><th>No.</th><th>Decision</th><th>Decided by</th></tr></thead>
<tbody>
<tr><td>D1</td><td>Agreement ${contract.id} for ${party.name} is a ${product.name} denominated in ${currency}, effective ${effectiveOn} and ending ${endsOn}.</td><td>${company} and ${party.name}</td></tr>
</tbody>
</table>
<p class="caption">Decision recorded on ${issuedOn}. Status on the agreement: ${contract.status}.</p>
<@h1 "ff_actions" "Actions"/>
<table>
<colgroup><col style="width: 10%"><col style="width: 42%"><col style="width: 20%"><col style="width: 16%"><col style="width: 12%"></colgroup>
<thead><tr><th>No.</th><th>Action</th><th>Owner</th><th>Due</th><th>Status</th></tr></thead>
<tbody>
<tr><td>A1</td><td>Keep agreement ${contract.id} with the ${party.role} record.</td><td>${party.name}</td><td>${effectiveOn}</td><td>Open</td></tr>
<tr><td>A2</td><td>Answer questions about the agreement at ${email}.</td><td>${company}</td><td>${effectiveOn}</td><td>Open</td></tr>
</tbody>
</table>
<@h1 "ff_next_meeting" "Next date"/>
<p>The agreement takes effect on ${effectiveOn}. Send a question about agreement ${contract.id} to ${email} before that date.</p>
<@facts/>
</main>
</@document>
