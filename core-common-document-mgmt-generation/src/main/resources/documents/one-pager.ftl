<#include "_shell.ftl">
<#assign pageTitle = party.name + "'s personal loan in " + currency>
<@document kind="one-pager" title=pageTitle single=true footer="company">
<main>
<p class="label">${product.name}</p>
<p class="title">${party.name}'s personal loan in ${currency}</p>
<p class="lead">${party.name} holds agreement ${contract.id} for a ${product.name}. It is denominated in ${currency}, takes effect on ${effectiveOn}, and ends on ${endsOn}.</p>
<div class="cols">
<div>
<@h1 "ff_record" "The agreement"/>
<p>Status ${contract.status}. Issued ${issuedOn}. Product identifier ${product.id}. Product family ${product.family}. ${regulatedLabel}.</p>
<@h1 "ff_dates" "The dates"/>
<ol>
<li>Issued on ${issuedOn}.</li>
<li>Effective on ${effectiveOn}.</li>
<li>Ends on ${endsOn}.</li>
</ol>
</div>
<div>
<@h1 "ff_parties" "The parties"/>
<ul>
<li>${party.name}, ${party.role}, party ${party.id}.</li>
<li>${company}, ${email}.</li>
<li>Currency ${currency}. No other amount is stated on this page.</li>
</ul>
<@h1 "ff_contact" "Where to write"/>
<p>Send a question about agreement ${contract.id} to ${email}. Include the agreement identifier and the party identifier.</p>
</div>
</div>
<@h1 "ff_schedule" "What the record shows"/>
<table>
<colgroup><col style="width: 28%"><col style="width: 22%"><col style="width: 50%"></colgroup>
<thead><tr><th>Point</th><th>Date</th><th>What ${party.name} has</th></tr></thead>
<tbody>
<tr><td>Issued</td><td>${issuedOn}</td><td>Agreement ${contract.id} recorded as ${contract.status}</td></tr>
<tr><td>Effective</td><td>${effectiveOn}</td><td>${product.name} in ${currency} becomes effective</td></tr>
<tr><td>Ends</td><td>${endsOn}</td><td>The agreement end date on the record</td></tr>
</tbody>
</table>
<p class="caption">Source: agreement ${contract.id}, party ${party.id}, product ${product.id}.</p>
<@facts/>
</main>
</@document>
