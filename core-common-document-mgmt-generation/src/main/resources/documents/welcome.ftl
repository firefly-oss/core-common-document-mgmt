<#include "_shell.ftl">
<#assign pageTitle = "Welcome to Firefly, " + party.givenName>
<@document kind="welcome" title=pageTitle description=pageTitle shortTitle="Welcome" single=true companyFooter=true topRight="Welcome">
<main>
<@label "Welcome"/>
<p class="title" role="heading" aria-level="1">${pageTitle}</p>
<@lead "Agreement " + contract.id + " records a " + product.name + " for " + party.name + ". This page states the role, the dates, and where to send a question."/>
<div class="fields">
<div class="row"><span class="k">Role</span><span class="v">${party.role}</span></div>
<div class="row"><span class="k">Email</span><span class="v">${email}</span></div>
<div class="row"><span class="k">Start date</span><span class="v">${effectiveOn}</span></div>
<div class="row"><span class="k">Manager</span><span class="v">${company}</span></div>
<div class="row"><span class="k">Buddy</span><span class="v">${company}</span></div>
</div>
<div class="cols"><div>
<@h1 "s1" "Your first week"/>
<ol>
<li>The agreement was issued on ${issuedOn}.</li>
<li>It takes effect on ${effectiveOn} and is denominated in ${currency}.</li>
<li>Product ${product.name}, identifier ${product.id}, family ${product.family}.</li>
<li>Keep agreement ${contract.id} with party ${party.id}.</li>
</ol>
</div><div>
<@h1 "s2" "Your practice: Banking"/>
<@body "The agreement is a " + product.name + " in the " + product.family + " family. It is " + regulatedLabel?lower_case + ". It runs from " + effectiveOn + " through " + endsOn + "."/>
<@h1 "s3" "How we work"/>
<ul>
<li>The agreement identifier is ${contract.id}.</li>
<li>${party.name} is the ${party.role}.</li>
<li>Questions go to ${email}.</li>
</ul>
</div></div>
<@h1 "s4" "Who to ask"/>
<table>
<colgroup><col style="width: 30%"><col style="width: 30%"><col style="width: 40%"></colgroup>
<thead><tr><th>Topic</th><th>Who</th><th>How</th></tr></thead>
<tbody>
<tr><td>The agreement record</td><td>${company}</td><td>${email}</td></tr>
<tr><td>The ${party.role}</td><td>${party.name}</td><td>Party ${party.id}</td></tr>
<tr><td>The effective date</td><td>${effectiveOn}</td><td>Agreement ${contract.id}</td></tr>
</tbody>
</table>
<blockquote><p>${slogan}</p></blockquote>
<p class="q-src">${company}</p>
</main>
</@document>
