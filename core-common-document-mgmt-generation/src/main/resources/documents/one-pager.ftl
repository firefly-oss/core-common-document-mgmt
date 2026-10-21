<#include "_shell.ftl">
<#assign pageTitle = party.name + "'s personal loan in " + currency>
<@document kind="one-pager" title=pageTitle description=pageTitle shortTitle="One-pager" single=true companyFooter=true topRight="One-pager">
<main>
<@label product.name/>
<p class="title" role="heading" aria-level="1">${pageTitle}</p>
<@lead party.name + " holds agreement " + contract.id + " for a " + product.name + ". It is denominated in " + currency + ", takes effect on " + effectiveOn + ", and ends on " + endsOn + "."/>
<div class="cols"><div>
<@h1 "s1" "The challenge"/>
<@body "Agreement " + contract.id + " is " + contract.status + ". " + party.name + ", party " + party.id + ", needs the record of product " + product.id + " in one place."/>
<@h1 "s2" "Our approach"/>
<ol>
<li><strong>Record.</strong> The agreement was issued on ${issuedOn}.</li>
<li><strong>Effective date.</strong> ${product.name} in ${currency} takes effect on ${effectiveOn}.</li>
<li><strong>End date.</strong> The agreement ends on ${endsOn}.</li>
</ol>
</div><div>
<@h1 "s3" "What you get"/>
<ul>
<li>Agreement ${contract.id} for ${party.name}.</li>
<li>Product ${product.name}, identifier ${product.id}, family ${product.family}.</li>
<li>Currency ${currency}. ${regulatedLabel}.</li>
</ul>
<@h1 "s4" "How we work"/>
<@body "Questions about agreement " + contract.id + " go to " + email + " and name the party identifier " + party.id + "."/>
</div></div>
<@h1 "s5" "What an engagement looks like"/>
<table>
<colgroup><col style="width: 20%"><col style="width: 18%"><col style="width: 62%"></colgroup>
<thead><tr><th>Phase</th><th>Duration</th><th>What ${party.name} has at the end</th></tr></thead>
<tbody>
<tr><td>Issued</td><td>${issuedOn}</td><td>Agreement ${contract.id} recorded as ${contract.status}</td></tr>
<tr><td>Effective</td><td>${effectiveOn}</td><td>${product.name} in ${currency} takes effect</td></tr>
<tr><td>Ends</td><td>${endsOn}</td><td>The end date on the agreement record</td></tr>
</tbody>
</table>
<blockquote><p>${slogan}</p></blockquote>
<p class="q-src">${company}</p>
<div class="fields">
<div class="row"><span class="k">Contact</span><span class="v">${company}</span></div>
<div class="row"><span class="k">Email</span><span class="v">${email}</span></div>
<div class="row"><span class="k">Web</span><span class="v">${domain}</span></div>
</div>
</main>
</@document>
