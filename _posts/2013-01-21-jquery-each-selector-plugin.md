---
title: 'jQuery EachSelector Plugin'
layout: post
date: 2013-01-21
language: pt
tags:
- jQuery
description: A intenção deste plugin é tornar fácil selecionar com seletores complexos, vários elementos com jQuery de uma só vez. Surgiu a necessidade de ter algo assim, por que eu precisava dar display none em vários elementos cujo a única maneira de chegar até esses elementos era usando métodos do jQuery como parents ai ficaria difícil, e este plugin foi a solução para dar todos os display:none de uma só vez.
---

A intenção deste plugin é tornar fácil selecionar com seletores complexos, vários elementos com jQuery de uma só vez.

Surgiu a necessidade de ter algo assim, por que eu precisava dar display none em vários elementos cujo a única maneira de chegar até esses elementos era usando métodos do jQuery como **parents** ai ficaria difícil, e este plugin foi a solução para dar todos os display:none de uma só vez.

Basicamente o modo de se usar o plugin é separar seletores de elementos por virgula na chamada do método $.eachSelector:
{% highlight javascript %}
$.eachSelector(
    '#id .class',
    $('#otherID').find('.class').parents('.parent')
).css({display : 'none'});
{% endhighlight %}

O Diego Lopes me ajudou na criação do plugin que é muito simples, e estamos planejando uma nova versão com algumas coisas mais completas, conforme necessidade que senti usando no dia-a-dia.

Esta disponível no [Github](https://github.com/felquis/jQueryEachSelector "Github"), se tiver alguma contribuição a fazer fique a vontade :)
