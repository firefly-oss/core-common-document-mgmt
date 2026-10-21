<#include "_shell.ftl">
<#assign pageTitle = "Amendment">
<@document kind="amendment" title="Amendment of agreement " + contract.predecessorId description="Change to agreement " + contract.predecessorId shortTitle=party.name + " · Amendment" grid=true opener=true>
<@cover pageTitle "A change to agreement " + contract.predecessorId + " for " + party.name + "."/>
<@toc>
<@toc1 "s1" "Predecessor"/>
<@toc1 "s2" "What changed"/>
<@toc1 "s3" "The agreement after the change"/>
<@toc1 "s4" "Contract lines"/>
</@toc>
<main>
<@h1 "s1" "Predecessor"/>
<@lead "This amendment is agreement " + contract.id + ". It changes predecessor agreement " + contract.predecessorId + "."/>
<@body party.name + ", party " + party.id + ", is the " + party.role + ". " + company + " records the change. The amendment was issued on " + issuedOn + " and its status is " + contract.status + "."/>
</main>
<main>
<@h1 "s2" "What changed"/>
<@body contract.change/>
</main>
<main>
<@h1 "s3" "The agreement after the change"/>
<@body "The product remains " + product.name + ", identifier " + product.id + ", family " + product.family + ". The currency remains " + currency + ". The amount is " + contract.amount + " " + currency + ". The term runs from " + effectiveOn + " through " + endsOn + ". The agreement is " + regulatedLabel?lower_case + "."/>
</main>
<main>
<@h1 "s4" "Contract lines"/>
<table>
<colgroup><col style="width: 28%"><col style="width: 28%"><col style="width: 16%"><col style="width: 14%"><col style="width: 14%"></colgroup>
<thead><tr><th>Line</th><th>Product</th><th>Role</th><th class="num">Quantity</th><th>Primary</th></tr></thead>
<tbody>
<#list contract.lines as line>
<tr><td>${line.id}</td><td>${line.productId}</td><td>${line.role}</td><td class="num">${line.quantity}</td><td><#if line.primary == "true">Yes<#else>No</#if></td></tr>
</#list>
</tbody>
</table>
<@caption "Lines on agreement " + contract.id + ", amending " + contract.predecessorId + "."/>
</main>
<@back/>
</@document>
