<#include "_shell.ftl">
<#assign pageTitle = "Record " + party.name + "'s personal loan in " + currency>
<@document kind="memo" title=pageTitle grid=true footer="confidential">
<main>
<p class="label">Executive memo</p>
<p class="title">Record ${party.name}'s personal loan in ${currency}</p>
<div class="fields" id="ff_memo_header">
<div class="row"><span class="k">To</span><span class="v">${party.name}, ${party.role}</span></div>
<div class="row"><span class="k">From</span><span class="v">${company}</span></div>
<div class="row"><span class="k">Date</span><span class="v">${issuedOn}</span></div>
<div class="row"><span class="k">Decision by</span><span class="v">${effectiveOn}</span></div>
<div class="row"><span class="k">Classification</span><span class="v">Confidential</span></div>
</div>
<@h1 "ff_recommendation" "Recommendation"/>
<p class="lead">Record agreement ${contract.id} for ${party.name} as a ${product.name} denominated in ${currency}, effective ${effectiveOn} and ending ${endsOn}.</p>
<@h1 "ff_why" "Why now"/>
<p>The agreement was issued on ${issuedOn}. Its status is ${contract.status}. The effective date is ${effectiveOn}, so the record needs to be in place before that date.</p>
<@h1 "ff_options" "Options considered"/>
<table>
<colgroup><col style="width: 22%"><col style="width: 26%"><col style="width: 26%"><col style="width: 26%"></colgroup>
<thead><tr><th>Option</th><th>What it means</th><th>What is fixed</th><th>What it depends on</th></tr></thead>
<tbody>
<tr><td>Record the agreement</td><td>Keep ${contract.id} as issued</td><td>${currency}, ${effectiveOn} through ${endsOn}</td><td>${party.name} is the ${party.role}</td></tr>
<tr><td>Wait</td><td>Leave the ${contract.status} record unchanged until ${effectiveOn}</td><td>The identifiers stay the same</td><td>A question sent to ${email}</td></tr>
</tbody>
</table>
<p class="caption">Agreement ${contract.id}. Product ${product.id}. Party ${party.id}. This memo states no fee.</p>
<@h1 "ff_risks" "What is already fixed"/>
<ul>
<li>Party ${party.name}, identifier ${party.id}.</li>
<li>Product ${product.name}, family ${product.family}, ${regulatedLabel?lower_case}.</li>
<li>Currency ${currency}. Effective ${effectiveOn}. Ends ${endsOn}.</li>
</ul>
<@h1 "ff_next" "Next steps"/>
<ol>
<li>${party.name} keeps agreement ${contract.id}.</li>
<li>The agreement takes effect on ${effectiveOn}.</li>
<li>Questions go to ${email} before ${effectiveOn}.</li>
</ol>
<@facts/>
<p class="small">Contact: ${company}, ${email}.</p>
</main>
</@document>
