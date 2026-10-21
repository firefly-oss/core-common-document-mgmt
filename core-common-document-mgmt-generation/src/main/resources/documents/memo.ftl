<#include "_shell.ftl">
<#assign pageTitle = "Record " + party.name + "'s personal loan in " + currency>
<@document kind="memo" title=pageTitle description=pageTitle shortTitle="Executive memo" grid=true>
<main>
<@label "Executive memo"/>
<p class="title" role="heading" aria-level="1">${pageTitle}</p>
<div class="fields" id="ff_memo_header">
<div class="row"><span class="k">To</span><span class="v">${party.name}, ${party.role}</span></div>
<div class="row"><span class="k">From</span><span class="v">${company}</span></div>
<div class="row"><span class="k">Date</span><span class="v">${issuedOn}</span></div>
<div class="row"><span class="k">Decision by</span><span class="v">${effectiveOn}</span></div>
<div class="row"><span class="k">Classification</span><span class="v">Confidential</span></div>
</div>
<@h1 "ff_recommendation" "Recommendation"/>
<@lead "Record agreement " + contract.id + " for " + party.name + " as a " + product.name + " denominated in " + currency + ", effective " + effectiveOn + " and ending " + endsOn + "."/>
<@h1 "s2" "Why now"/>
<@body "The agreement was issued on " + issuedOn + ". Its status is " + contract.status + ". The effective date is " + effectiveOn + "."/>
<@h1 "s3" "Options considered"/>
<table>
<colgroup><col style="width: 18%"><col style="width: 32%"><col style="width: 25%"><col style="width: 25%"></colgroup>
<thead><tr><th>Option</th><th>What it means</th><th>Benefits</th><th>Risks</th></tr></thead>
<tbody>
<tr><td>Record it</td><td>Keep agreement ${contract.id} as issued</td><td>${currency} from ${effectiveOn}</td><td>The record stays ${contract.status} until ${effectiveOn}</td></tr>
<tr><td>Wait</td><td>Leave the record unchanged</td><td>The identifiers stay the same</td><td>Questions wait until ${email} is used</td></tr>
</tbody>
</table>
<@caption "Options for agreement " + contract.id + ". Product " + product.id + ". Party " + party.id + ". This memo states no fee."/>
<@h1 "s4" "Risks and how we manage them"/>
<ul>
<li><strong>The party record.</strong> ${party.name}, identifier ${party.id}, is the ${party.role}.</li>
<li><strong>The product record.</strong> ${product.name}, identifier ${product.id}, family ${product.family}, ${regulatedLabel?lower_case}.</li>
<li><strong>The term.</strong> Currency ${currency}. Effective ${effectiveOn}. Ends ${endsOn}.</li>
</ul>
<@h1 "s5" "Next steps"/>
<ol>
<li>${party.name} keeps agreement ${contract.id}.</li>
<li>The agreement takes effect on ${effectiveOn}.</li>
<li>Questions go to ${email} before ${effectiveOn}.</li>
</ol>
<@small "Contact: " + company + ", " + email + "."/>
</main>
</@document>
