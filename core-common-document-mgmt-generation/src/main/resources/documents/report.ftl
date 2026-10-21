<#include "_shell.ftl">
<#assign pageTitle = "The personal loan agreement runs to November 2029">
<@document kind="report" title=pageTitle description=product.name + " for " + party.name shortTitle=party.name + " · Personal loan" grid=true opener=true>
<@cover pageTitle product.name + " for " + party.name + ", denominated in " + currency/>
<@toc>
<@toc1 "ff_summary" "Executive summary"/>
<@toc2 "s2" "What we recommend"/>
<@toc1 "s3" "Context and objectives"/>
<@toc2 "s4" "Scope"/>
<@toc1 "s5" "Findings"/>
<@toc2 "s6" party.name + " is the " + party.role/>
<@toc2 "s7" "The agreement is denominated in " + currency/>
<@toc2 "s8" "Where AI supports the process"/>
<@toc1 "s9" "Recommendations"/>
<@toc2 "s10" "Recommendation one"/>
<@toc2 "s12" "Recommendation two"/>
<@toc1 "s13" "Roadmap and next steps"/>
<@toc2 "s14" "Next steps"/>
</@toc>
<main>
<@h1 "ff_summary" "Executive summary"/>
<@lead "Agreement " + contract.id + " is a " + product.name + " for " + party.name + ", denominated in " + currency + ", effective " + effectiveOn + " and ending " + endsOn + "."/>
<@body "The agreement was issued on " + issuedOn + ". Its status is " + contract.status + ". " + party.name + " is the " + party.role + ". The product family is " + product.family + ", and the agreement is " + regulatedLabel?lower_case + "."/>
<ul>
<li><strong>Party ${party.id} is ${party.name}.</strong> The role on the agreement is ${party.role}.</li>
<li><strong>Product ${product.id} is ${product.name}.</strong> The family is ${product.family}.</li>
<li><strong>The currency is ${currency}.</strong> This report states no fee.</li>
</ul>
<@h2 "s2" "What we recommend"/>
<ol>
<li>${party.name} keeps agreement ${contract.id} with this report.</li>
<li>${company} answers questions at ${email} before ${effectiveOn}.</li>
<li>The agreement takes effect on ${effectiveOn}.</li>
</ol>
<@h1 "s3" "Context and objectives"/>
<@body "This report records the " + product.name + " issued to " + party.name + " on " + issuedOn + ". It answers who the agreement is for, which product it uses, which currency it uses, and which dates it runs."/>
<@h2 "s4" "Scope"/>
<@body "The findings are limited to agreement " + contract.id + "."/>
<table>
<colgroup><col style="width: 24%"><col style="width: 38%"><col style="width: 38%"></colgroup>
<thead><tr><th>Area</th><th>In scope</th><th>Out of scope</th></tr></thead>
<tbody>
<tr><td>Party</td><td>${party.name}, ${party.id}</td><td>Any person other than ${party.name}</td></tr>
<tr><td>Agreement</td><td>${contract.id}, status ${contract.status}</td><td>A fee other than the currency ${currency}</td></tr>
<tr><td>Product</td><td>${product.name}, ${product.id}, ${product.family}</td><td>Any product other than ${product.name}</td></tr>
</tbody>
</table>
<@caption "Table 1. Scope of the review. Source: agreement " + contract.id + ", issued " + issuedOn + "."/>
<@h1 "s5" "Findings"/>
<@body "The findings below are the fields on the agreement record."/>
<@h2 "s6" party.name + " is the " + party.role/>
<@body "The party identifier is " + party.id + ". The role on the agreement is " + party.role + "."/>
<@h2 "s7" "The agreement is denominated in " + currency/>
<@body "Product " + product.name + " (" + product.id + ") is in the " + product.family + " family. The agreement is " + regulatedLabel?lower_case + ". It runs from " + effectiveOn + " through " + endsOn + "."/>
<table>
<colgroup><col style="width: 34%"><col style="width: 22%"><col style="width: 22%"><col style="width: 22%"></colgroup>
<thead><tr><th>Indicator</th><th>Baseline</th><th>Target</th><th>Source</th></tr></thead>
<tbody>
<tr><td>Status</td><td>${contract.status}</td><td>${contract.status}</td><td>Agreement ${contract.id}</td></tr>
<tr><td>Effective</td><td>${issuedOn}</td><td>${effectiveOn}</td><td>Agreement ${contract.id}</td></tr>
<tr><td>Ends</td><td>${effectiveOn}</td><td>${endsOn}</td><td>Agreement ${contract.id}</td></tr>
<tr><td>Currency</td><td>${currency}</td><td>${currency}</td><td>Agreement ${contract.id}</td></tr>
</tbody>
</table>
<@caption "Table 2. Indicators used in this report. Source: agreement " + contract.id + "."/>
<@h2 "s8" "Where AI supports the process"/>
<@body "This agreement record does not assign a decision to AI. Where AI is used, it decides on its own only within approved limits, and every decision is explained, recorded and open to human review. Decisions with significant effects on people, or beyond delegated limits, go to people with delegated authority."/>
<@h1 "s9" "Recommendations"/>
<@body "Turn the record into the next action for " + party.name + " and for " + company/>
<@h2 "s10" "Recommendation one"/>
<@body party.name + " holds agreement " + contract.id + ". Questions go to " + email + " and include that identifier before " + effectiveOn + "."/>
<@h3 "s11" "What it takes"/>
<ul>
<li>People: ${party.name}, ${party.role}, and ${company}.</li>
<li>Decisions: the agreement takes effect on ${effectiveOn}.</li>
<li>Dependencies: product ${product.id} and party ${party.id}.</li>
</ul>
<@h2 "s12" "Recommendation two"/>
<@body company + " keeps the " + currency + " denomination and the end date " + endsOn + " on agreement " + contract.id + "."/>
<@h1 "s13" "Roadmap and next steps"/>
<table>
<colgroup><col style="width: 26%"><col style="width: 28%"><col style="width: 46%"></colgroup>
<thead><tr><th>Phase</th><th>Duration</th><th>Outcome</th></tr></thead>
<tbody>
<tr><td>Issued</td><td>${issuedOn}</td><td>Agreement ${contract.id} recorded as ${contract.status}</td></tr>
<tr><td>Effective</td><td>${effectiveOn}</td><td>${product.name} in ${currency} takes effect</td></tr>
<tr><td>Ends</td><td>${endsOn}</td><td>End date on the agreement record</td></tr>
</tbody>
</table>
<@caption "Table 3. Indicative roadmap."/>
<@h2 "s14" "Next steps"/>
<ol>
<li>Review this report with ${party.name}.</li>
<li>Confirm agreement ${contract.id}, product ${product.id}, and currency ${currency}.</li>
<li>The agreement takes effect on ${effectiveOn}.</li>
</ol>
</main>
<@back/>
</@document>
