<#include "_shell.ftl">
<#assign pageTitle = "Personal loan agreement " + contract.id>
<@document kind="letter" title=pageTitle letter=true footer="company">
<main>
<@letterhead/>
<@recipient/>
<p class="date">${placeDate}</p>
<p class="subject">Personal loan agreement ${contract.id}</p>
<p class="salutation">Dear ${party.name},</p>
<p>This letter confirms your ${product.name} agreement ${contract.id}. Firefly Software Solutions Inc. issued it on ${issuedOn}.</p>
<p>The product identifier is ${product.id}. The product family is ${product.family}. The agreement is denominated in ${currency} and is ${regulatedLabel?lower_case}. Its status is ${contract.status}.</p>
<p>The agreement takes effect on ${effectiveOn} and ends on ${endsOn}. Please keep this letter with the agreement identifier. Questions go to ${email}.</p>
<@facts/>
<@signature/>
</main>
</@document>
