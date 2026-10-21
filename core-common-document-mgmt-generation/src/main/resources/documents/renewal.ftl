<#include "_shell.ftl">
<#assign pageTitle = "Renewal of agreement " + contract.predecessorId>
<@document kind="renewal" title=pageTitle description="Continuation of agreement " + contract.predecessorId shortTitle=party.name + " · Renewal" grid=true opener=true>
<@cover pageTitle "Agreement " + contract.predecessorId + " continued"/>
<@toc>
<@toc1 "s1" "Predecessor"/>
<@toc1 "s2" "New term"/>
<@toc1 "s3" "What continues"/>
<@toc1 "s4" "Contract lines"/>
</@toc>
<main>
<@h1 "s1" "Predecessor"/>
<@lead "This renewal is agreement " + contract.id + ". It continues predecessor agreement " + contract.predecessorId + "."/>
<@body party.name + ", party " + party.id + ", remains the " + party.role + ". " + company + " records the renewal. It was issued on " + issuedOn + " and its status is " + contract.status + "."/>
<@h1 "s2" "New term"/>
<@body "The new term starts on " + effectiveOn + " and ends on " + endsOn + "."/>
<@h1 "s3" "What continues"/>
<@body "The product continues as " + product.name + ", identifier " + product.id + ", family " + product.family + ". The currency continues as " + currency + ". The amount is " + contract.amount + " " + currency + ". The agreement is " + regulatedLabel?lower_case + "."/>
<@h1 "s4" "Contract lines"/>
<table>
<colgroup><col style="width: 28%"><col style="width: 28%"><col style="width: 16%"><col style="width: 14%"><col style="width: 14%"></colgroup>
<thead><tr><th>Line</th><th>Product</th><th>Role</th><th class="num">Quantity</th><th>Primary</th></tr></thead>
<tbody>
<#list contract.lines as line>
<tr><td>${line.id}</td><td>${line.productId}</td><td>${line.role}</td><td class="num">${line.quantity}</td><td>${line.primary}</td></tr>
</#list>
</tbody>
</table>
<@caption "Lines on agreement " + contract.id + ", renewing " + contract.predecessorId + "."/>
</main>
<@back/>
</@document>
