<#include "_shell.ftl">
<#assign pageTitle = "Minutes: " + party.name + " personal loan">
<@document kind="minutes" title=pageTitle description=pageTitle shortTitle="Meeting minutes" grid=true>
<main>
<@label "Meeting minutes"/>
<p class="title" role="heading" aria-level="1">${pageTitle}</p>
<div class="fields" id="ff_minutes_header">
<div class="row"><span class="k">Date</span><span class="v">${issuedOn}</span></div>
<div class="row"><span class="k">Time and place</span><span class="v">Agreement ${contract.id}</span></div>
<div class="row"><span class="k">Chair</span><span class="v">${company}</span></div>
<div class="row"><span class="k">Attendees</span><span class="v">${party.name} (${party.role}), ${company}</span></div>
<div class="row"><span class="k">Apologies</span><span class="v">No other party is named on the agreement</span></div>
<div class="row"><span class="k">Minutes by</span><span class="v">${email}</span></div>
</div>
<@h1 "s1" "Agenda"/>
<ol>
<li>Review of agreement ${contract.id}</li>
<li>${product.name}, identifier ${product.id}</li>
<li>Dates ${effectiveOn} to ${endsOn}, currency ${currency}</li>
<li>Any other business</li>
</ol>
<@h1 "s2" "Discussion"/>
<@h2 "s3" "1. Review of actions"/>
<@body "Agreement " + contract.id + " is " + contract.status + ". It was issued on " + issuedOn + ". " + party.name + ", party " + party.id + ", is the " + party.role + "."/>
<@h2 "s4" "2. The product"/>
<@body "The product is " + product.name + ", family " + product.family + ", identifier " + product.id + ". It is " + regulatedLabel?lower_case + ". The agreement is denominated in " + currency + "."/>
<@h2 "s5" "3. The dates"/>
<@body "The agreement takes effect on " + effectiveOn + " and ends on " + endsOn + "."/>
<@h1 "ff_decisions" "Decisions"/>
<table>
<colgroup><col style="width: 8%"><col style="width: 64%"><col style="width: 28%"></colgroup>
<thead><tr><th>No.</th><th>Decision</th><th>Decided by</th></tr></thead>
<tbody>
<tr><td>D1</td><td>Agreement ${contract.id} for ${party.name} is a ${product.name} denominated in ${currency}, effective ${effectiveOn} and ending ${endsOn}.</td><td>${company} and ${party.name}</td></tr>
</tbody>
</table>
<@caption "Decisions taken"/>
<@h1 "ff_actions" "Actions"/>
<table>
<colgroup><col style="width: 8%"><col style="width: 44%"><col style="width: 20%"><col style="width: 14%"><col style="width: 14%"></colgroup>
<thead><tr><th>No.</th><th>Action</th><th>Owner</th><th>Due</th><th>Status</th></tr></thead>
<tbody>
<tr><td>A1</td><td>Keep agreement ${contract.id} with the ${party.role} record.</td><td>${party.name}</td><td>${effectiveOn}</td><td>Open</td></tr>
<tr><td>A2</td><td>Answer questions about the agreement at ${email}.</td><td>${company}</td><td>${effectiveOn}</td><td>Open</td></tr>
</tbody>
</table>
<@h1 "s8" "Next meeting"/>
<@body effectiveOn + ". Send a question about agreement " + contract.id + " to " + email + " before that date."/>
</main>
</@document>
