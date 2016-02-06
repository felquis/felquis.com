---
layout: post
title: "Upgraded My Blog and I'm Using SMACSS"
date: 2015-04-06
tags: [css, smacss]
---

Last week I updated the layout of my blog and I'm using SMACSS. On top of that, I prepared some topics that describe the structure I'm using!

<!--more-->

First of all, the SMACSS it's not the best methodology in the world. He helped me a lot to organize my CSS and maybe he can help you :) AND...

<p class="pull-quote">
    SMACSS IT'S NOT A FRAMEWORK
</p>

SMACSS it's not like a [Twitter Bootstrap](http://getbootstrap.com), [Pure CSS](http://purecss.io/) and many others. It does not come with a set of classes for you to use. It's just a set of ideias for you to organize your CSS in the best way. You're not required to use SMACSS the way he is.

There is a [document](https://smacss.com/files/2012-03-15-workshop-essen.pdf) on the web about SMACSS workshop. Where the author explains what SMACSS and some points to you use it. On this basics, we can take 5 principles of SMACSS, they are:

* [Categorization](#categorization)
* [Naming Convention](#naming-convention)
* [Uncouple](#uncouple)
* [Increase Semantics](#increase-semantics)
* [State Based Design](#state-based-design)

All you read about SMACSS here, it's not a rule. Only ideas of how to organize the CSS of your project. I learned a lot about SMACSS reading posts and articles out of the document cited above.

Now, I'll introduce you below 5 principles of SMACSS. Have fun!

## Categorization

Every project needs some organization. And SMACSS will help you to to organize your project. He describe some points to separate your CSS. The points below was removed from the [docs](https://smacss.com/book/categorizing) on website. Let's see:

1. Base
2. Layout
3. Module
4. State
5. Theme

**Base rules** are the defaults. They are almost exclusively single element selectors but it could include attribute selectors, pseudo-class selectors, child selectors or sibling selectors. Essentially, a base style says that wherever this element is on the page, it should look like _this_.

{% highlight css %}
html, body, form { margin: 0; padding: 0; }
input[type=text] { border: 1px solid #999; }
a { color: #039; }
a:hover { color: #03C; }
{% endhighlight %}

**Layout rules** divide the page into sections. Layouts hold one or more modules together.

**Modules** are the reusable, modular parts of our design. They are the callouts, the sidebar sections, the product lists and so on.

**State rules** are ways to describe how our modules or layouts will look when in a particular state. Is it hidden or expanded? Is it active or inactive? They are about describing how a module or layout looks on screens that are smaller or bigger. See these CSS classes to understand:

{% highlight css %}
.is-active { display: block; }
.is-hidden { display: none; }
{% endhighlight %}

Finally, **Theme rules** are similar to state rules in that they describe how modules or layouts might look. Most sites don’t require a layer of theming but it is good to be aware of it.

## Naming Convention

Naming conventions clarify intents. We see an example of how to define a nomenclature for their classes. Where you set the whole class from the layout of start with the `-l` prefix.

{% highlight css %}
.l-header { width: 100%; }
.l-sidebar { float: left; width: 20%; }
.l-content { float: right; width: 80%; }
{% endhighlight %}

Specificity is dangerous. Always give preference to classes instead of ID's.

## Uncouple

We must be abuse of reuse of code. Causing any style disturb a module or any other thing you want to style again. Theoretically, it should be "reset", ie the default browser in order to apply our style.

Thinking about it, we should not base our selectors in ID's. Since we want our code to be reused by another element. We must use class instead of ID's or HTML Elements.

Use ID's with grave caution.

## Increase Semantics

We can have a button element to the designer his behavior is a link. Or we can have an `a` element to the designer his behavior is a button. So our classes must have names that are linked to it's function. See an example below a link and button:

{% highlight html %}
<style type="text/css">
    .link { text-decoration: underline; }
    .button { padding: 2px; }
</style>

<a href="http://randsonjs.com" class="link">Link</a>
<a href="http://randsonjs.com" class="button">Button</a>
{% endhighlight %}

We can also have `div` that behave like lists and items lists:

{% highlight html %}
<style type="text/css">
    .list { padding: 4px; }
    .list .item-list { display: inline-block; }
</style>

<div class="list">
    <div class="item-list">Lorem1</div>
    <div class="item-list">Lorem2</div>
</div>
{% endhighlight %}

The ideia here is to keep the semantics. Many carousel jQuery plugins use `div` or `p` to declare their items. Thus we maintain our semantics and use the plugin insted of simply leaves you to use it for that.

## State Based Design

The last is State Based Design. He proposes that we use classes to declare states of elements. Classes as `.is-active` and `.is-hidden` can be used to improve the semantics. Also instead of you use a jQuery selector to remove the DOM element. You cut and adds class from element.

See an example about state classes:

{% highlight css %}
.is-active { display: block; }
.is-hidden { display: none; }
.is-disable { opacity: .5; }
{% endhighlight %}

And abuse of reuse.

## Considerations

All these thoughts about SMACSS is good to keep in mind. You're not obliged to follow them. In fact, SMACSS is free for you to do it your way. See what's best of you and use.

SMACSS is free, be you too :)
