<#include "_shell.ftl">
<#assign pageTitle = "Personal loan agreement " + contract.id>
<@document kind="letter" title=pageTitle description=pageTitle shortTitle="Letter" letter=true companyFooter=true>
<main>
<@letterhead/>
<div class="recipient" id="ff_recipient"><p>${party.name}</p><p>${party.role}</p><p>Agreement ${contract.id}</p><p>Product ${product.name}</p><p>Party ${party.id}</p></div>
<p class="date">${placeDate}</p>
<p class="subject">Personal loan agreement ${contract.id}</p>
<p class="salutation">Dear ${party.name},</p>
<@body "This letter confirms agreement " + contract.id + " for " + party.name + ", issued on " + issuedOn + "."/>
<@body "The product is " + product.name + ", identifier " + product.id + ", in the " + product.family + " family. The agreement is denominated in " + currency + " and its status is " + contract.status + ". It is " + regulatedLabel?lower_case + "."/>
<@body "The agreement takes effect on " + effectiveOn + " and ends on " + endsOn + ". Please keep this letter with the agreement identifier. Questions go to " + email + " before " + effectiveOn + "."/>
<@signature/>
</main>
</@document>
