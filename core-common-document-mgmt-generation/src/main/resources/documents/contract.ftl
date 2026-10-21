<#include "_shell.ftl">
<#assign pageTitle = product.name>
<@document kind="contract" title=pageTitle description=product.name + " for " + party.name shortTitle=party.name + " · Contract" grid=true opener=true>
<@cover pageTitle "A five-year agreement for " + party.name + ", denominated in " + currency + "."/>
<@toc>
<@toc1 "s1" "Parties"/>
<@toc1 "s2" "Product"/>
<@toc1 "s3" "Amount"/>
<@toc1 "s4" "Term"/>
<@toc1 "s5" "Contract lines"/>
</@toc>
<main>
<@h1 "s1" "Parties"/>
<@lead "Agreement " + contract.id + " is between " + party.name + " and " + company/>
<@body party.name + ", party " + party.id + ", is the " + party.role + ". " + company + " keeps the agreement. It was issued on " + issuedOn + " and its status is " + contract.status + "."/>
<table>
<colgroup><col style="width: 28%"><col style="width: 40%"><col style="width: 32%"></colgroup>
<thead><tr><th>Role</th><th>Name</th><th>Identifier</th></tr></thead>
<tbody>
<tr><td>${party.role}</td><td>${party.name}</td><td>${party.id}</td></tr>
<tr><td>Provider</td><td>${company}</td><td>${email}</td></tr>
</tbody>
</table>
<@caption "Parties on agreement " + contract.id + "."/>
</main>
<main>
<@h1 "s2" "Product"/>
<@body "The product is " + product.name + ", identifier " + product.id + ", in the " + product.family + " family. The agreement is " + regulatedLabel?lower_case + "."/>
</main>
<main>
<@h1 "s3" "Amount"/>
<@body "The agreement is denominated in " + currency + ". The amount is " + contract.amount + " " + currency + "."/>
</main>
<main>
<@h1 "s4" "Term"/>
<@body "The agreement takes effect on " + effectiveOn + " and ends on " + endsOn + ". The term is five years."/>
</main>
<main>
<@h1 "s5" "Contract lines"/>
<table>
<colgroup><col style="width: 28%"><col style="width: 28%"><col style="width: 16%"><col style="width: 14%"><col style="width: 14%"></colgroup>
<thead><tr><th>Line</th><th>Product</th><th>Role</th><th class="num">Quantity</th><th>Primary</th></tr></thead>
<tbody>
<#list contract.lines as line>
<tr><td>${line.id}</td><td>${line.productId}</td><td>${line.role}</td><td class="num">${line.quantity}</td><td><#if line.primary == "true">Yes<#else>No</#if></td></tr>
</#list>
</tbody>
</table>
<@caption "Lines on agreement " + contract.id + ". Product " + product.name + ". Amount " + contract.amount + " " + currency + "."/>
</main>
<@back/>
</@document>
