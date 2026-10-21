<#include "_shell.ftl">
<#assign pageTitle = "Welcome to Firefly, " + party.givenName>
<@document kind="welcome" title=pageTitle single=true footer="company">
<main>
<p class="label">Welcome</p>
<p class="title">Welcome to Firefly, ${party.givenName}</p>
<p class="lead">Your ${product.name} agreement ${contract.id} is recorded with Firefly Software Solutions Inc. This page states who it is for, when it runs, and where to send a question.</p>
<@facts/>
<div class="cols">
<div>
<@h1 "ff_first_week" "Your first date"/>
<ol>
<li>The agreement was issued on ${issuedOn}.</li>
<li>It takes effect on ${effectiveOn}.</li>
<li>It ends on ${endsOn}.</li>
<li>Keep agreement ${contract.id} with this page.</li>
</ol>
</div>
<div>
<@h1 "ff_practice" "The lending agreement"/>
<p>The product is ${product.name}, identifier ${product.id}, in the ${product.family} family. It is denominated in ${currency}. The agreement status is ${contract.status}.</p>
<@h1 "ff_how" "How a question is handled"/>
<ul>
<li>Write to ${email} and include agreement ${contract.id}.</li>
<li>${party.name} is the ${party.role} on the agreement.</li>
<li>${company} keeps the agreement record.</li>
</ul>
</div>
</div>
<@h1 "ff_who" "Who to ask"/>
<table>
<colgroup><col style="width: 34%"><col style="width: 33%"><col style="width: 33%"></colgroup>
<thead><tr><th>Topic</th><th>Who</th><th>How</th></tr></thead>
<tbody>
<tr><td>The agreement record</td><td>${company}</td><td>${email}</td></tr>
<tr><td>The ${party.role}</td><td>${party.name}</td><td>Party ${party.id}</td></tr>
<tr><td>The effective date</td><td>${effectiveOn}</td><td>Agreement ${contract.id}</td></tr>
</tbody>
</table>
<p class="caption">Agreement ${contract.id}. Product ${product.name}. Currency ${currency}.</p>
<blockquote><p>${slogan}</p></blockquote>
<p class="q-src">${company}</p>
</main>
</@document>
