<#include "_shell.ftl">
<#assign pageTitle = "A personal loan agreement for " + party.name>
<@document kind="proposal" title=pageTitle description=product.name + " in " + currency shortTitle=party.name + " · Proposal" grid=true opener=true>
<@cover pageTitle product.name + " in " + currency + ", effective " + effectiveOn/>
<@toc>
<@toc1 "ff_summary" "Executive summary"/>
<@toc1 "ff_context" "Context and objectives"/>
<@toc2 "s3" "What " + party.name + " wants to achieve"/>
<@toc2 "s4" "What success looks like"/>
<@toc1 "ff_approach" "Our approach"/>
<@toc2 "s6" "Phase 1. Define"/>
<@toc2 "s7" "Phase 2. Build"/>
<@toc2 "s8" "Phase 3. Run"/>
<@toc1 "ff_plan" "Plan and timeline"/>
<@toc1 "ff_team" "Team"/>
<@toc1 "ff_commercials" "Commercials"/>
<@toc2 "s12" "Terms"/>
<@toc1 "ff_next_steps" "Next steps"/>
<@toc1 "ff_appendix" "Appendix"/>
<@toc2 "s15" "Assumptions"/>
<@toc2 "s16" "About Firefly Software"/>
</@toc>
<main>
<@h1 "ff_summary" "Executive summary"/>
<@lead party.name + " is offered agreement " + contract.id + ": a " + product.name + " denominated in " + currency + ", effective " + effectiveOn + " and ending " + endsOn + "."/>
<@body "The agreement was issued on " + issuedOn + ". Its status is " + contract.status + ". " + company + " is the provider. This proposal states the record. It does not add a fee."/>
<table>
<colgroup><col style="width: 30%"><col style="width: 70%"></colgroup>
<thead><tr><th>At a glance</th><th>In brief</th></tr></thead>
<tbody>
<tr><td>Outcome</td><td>${product.name} for ${party.name}</td></tr>
<tr><td>Approach</td><td>Issued ${issuedOn}, effective ${effectiveOn}, ends ${endsOn}</td></tr>
<tr><td>Duration</td><td>${effectiveOn} through ${endsOn}</td></tr>
<tr><td>Team</td><td>${party.name} and ${company}</td></tr>
<tr><td>Investment</td><td>${currency}. This proposal states no fee.</td></tr>
</tbody>
</table>
<@caption "The engagement on one page. Agreement " + contract.id + ". Product " + product.id + ". Party " + party.id + "."/>
<@h1 "ff_context" "Context and objectives"/>
<@body "The agreement names " + party.name + " as " + party.role + ". The product is " + product.name + ", family " + product.family + ", identifier " + product.id + ". The agreement is " + regulatedLabel?lower_case + "."/>
<@h2 "s3" "What " + party.name + " wants to achieve"/>
<ol>
<li>Agreement ${contract.id} recorded for party ${party.id}.</li>
<li>${product.name} in the ${product.family} family.</li>
<li>The term ${effectiveOn} through ${endsOn}, denominated in ${currency}.</li>
</ol>
<@h2 "s4" "What success looks like"/>
<@body party.name + " can match agreement " + contract.id + " to product " + product.id + " and currency " + currency + " on " + effectiveOn + "."/>
<@h1 "ff_approach" "Our approach"/>
<@body company + " records the agreement, gives " + party.name + " the identifier " + contract.id + ", and answers questions at " + email + "."/>
<@h2 "s6" "Phase 1. Define"/>
<@body "The agreement was issued on " + issuedOn + " with status " + contract.status + "."/>
<@h2 "s7" "Phase 2. Build"/>
<@body "The " + product.name + " takes effect on " + effectiveOn + " and is denominated in " + currency + "."/>
<@h2 "s8" "Phase 3. Run"/>
<@body "The agreement ends on " + endsOn + "."/>
<blockquote><p>Where AI is part of the solution, it decides on its own only within approved limits, and every decision is explained, recorded and open to human review. Significant decisions, or those beyond delegated limits, go to people with delegated authority.</p></blockquote>
<@h1 "ff_plan" "Plan and timeline"/>
<@body "The dates below are the dates on agreement " + contract.id + "."/>
<table>
<colgroup><col style="width: 16%"><col style="width: 22%"><col style="width: 34%"><col style="width: 28%"></colgroup>
<thead><tr><th>Phase</th><th>Weeks</th><th>Main activities</th><th>Decision at the end</th></tr></thead>
<tbody>
<tr><td>Issued</td><td>${issuedOn}</td><td>Record agreement ${contract.id}</td><td>Status ${contract.status}</td></tr>
<tr><td>Effective</td><td>${effectiveOn}</td><td>${product.name} in ${currency}</td><td>The agreement takes effect</td></tr>
<tr><td>Ends</td><td>${endsOn}</td><td>The recorded end date</td><td>The agreement ends</td></tr>
</tbody>
</table>
<@caption "Indicative plan. Dates are the dates on agreement " + contract.id + "."/>
<@h1 "ff_team" "Team"/>
<@body "The parties named on the agreement are " + party.name + " and " + company/>
<table>
<colgroup><col style="width: 22%"><col style="width: 28%"><col style="width: 16%"><col style="width: 34%"></colgroup>
<thead><tr><th>Role</th><th>Name</th><th>Dedication</th><th>Responsibilities</th></tr></thead>
<tbody>
<tr><td>${party.role}</td><td>${party.name}</td><td>Named on the agreement</td><td>Party ${party.id} on agreement ${contract.id}</td></tr>
<tr><td>Provider</td><td>${company}</td><td>Named on the agreement</td><td>Keeps the agreement and answers ${email}</td></tr>
</tbody>
</table>
<@caption "No other person is named on agreement " + contract.id + "."/>
<@h1 "ff_commercials" "Commercials"/>
<@body "The agreement is denominated in " + currency + ". This proposal does not state a fee, a rate, or an amount."/>
<table>
<colgroup><col style="width: 18%"><col style="width: 46%"><col style="width: 18%"><col style="width: 18%"></colgroup>
<thead><tr><th>Option</th><th>Scope</th><th>Duration</th><th>Investment</th></tr></thead>
<tbody>
<tr><td>${product.name}</td><td>Agreement ${contract.id} for ${party.name}</td><td>${effectiveOn} to ${endsOn}</td><td>${currency}</td></tr>
</tbody>
</table>
<@caption "Product " + product.id + ". Issued " + issuedOn + ". Effective " + effectiveOn + "."/>
<@h2 "s12" "Terms"/>
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
<@h2 "s15" "Assumptions"/>
<ul>
<li>${party.name} is the ${party.role}, party ${party.id}.</li>
<li>The product is ${product.name}, ${product.id}, family ${product.family}.</li>
<li>The currency is ${currency}.</li>
</ul>
<@h2 "s16" "About Firefly Software"/>
<@body company + " keeps agreement " + contract.id + ". The registered address is " + registeredLines[0] + ", " + registeredLines[1] + "."/>
</main>
<@back/>
</@document>
