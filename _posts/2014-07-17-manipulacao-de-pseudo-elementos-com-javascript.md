---
title: 'Manipulação de pseudo-elements com JavaScript'
layout: post
date: 2014-07-17
language: pt
tags:
- pseudo-elements
- javascript
- CSS
description: Um overview sobre a manipulação de pseudo-elementos com JavaScript, desde pegar estilos de um pseudo-elemento, até alterar suas propriedades no CSS
---

Isso parece ser algo muito óbvio, mas quando eu precisei manipular um pseudo-elemento via JavaScript, eu me dei conta que não era tão simples assim. Vou compartilhar aqui alguns aprendizados e espero que se você saiba de algo que eu deveria saber, deixa nos comentários ou não volte mais pra este blog! hahaha

Para começar, não existe uma maneira de selecionar um pseudo-elemento no JavaScript assim como fazemos com outros elementos, por exemplo, selecionar o :after e mudar a propriedade color, procurei bastante isso e não encontrei nada relacionado :/ Só se existir algum hack bem escondido, encontrei apenas maneiras muito sujas de se fazer isso, [tão sujas](http://stackoverflow.com/a/7884222) que nem vou mencionar neste post.

## Como alterar a propriedade `content` de um pseudo-elemento

Levando em consideração que não temos como alterar propriedades do CSS de um pseudo-elemento, temos um workaround bem eficiente e que funciona bem, para isso leve em consideração o HTML
{% highlight css %}
<span>Algo está acontecendo</span>
{% endhighlight %}

O CSS
{% highlight css %}
span {
  position: relative;
  display: block;
  padding: 20px 0 0 0;
}

span:before {
  content: attr(data-content);
  position: absolute;
  top: 0;
  left: 0;
  color: gray;
}
{% endhighlight %}
E o JS
{% highlight js %}
var span = document.querySelector('span');

span.dataset.content = 'Muda valor da propriedade, e isso reflete no pseudo-elemento';
{% endhighlight %}

Okay, no CSS repare que a propriedade content está usando a [expressão attr()](https://developer.mozilla.org/en-US/docs/Web/CSS/attr) isso significa que qualquer valor que tiver no atributo `data-content` do elemento selecionado, será adicionado a propriedade content do pseudo-elemento. MAGICAMENTE! Para saber mais sobre o [`dataset`leia este post](http://tutsmais.com.br/blog/html5/atributo-dados-personalizado-html5-custom-data-attributes/)

Com isso, se nós alterarmos o valor do atributo `data-content` isso reflete no CSS.

Também podemos usar o método [.setAttribute](https://developer.mozilla.org/en-US/docs/Web/API/Element.setAttribute) para alterar o valor de uma propriedade, assim:
{% highlight js %}
var span = document.querySelector('span');

span.setAttribute('data-content', 'Muda valor da propriedade, e isso reflete no pseudo-elemento');
{% endhighlight %}

Veja o demo no Codepen

<p data-height="268" data-theme-id="0" data-slug-hash="wHAxe" data-default-tab="result" class='codepen'>See the Pen <a href='http://codepen.io/felquis/pen/wHAxe/'>Changing pseudo-element content using JavaScript</a> by Felquis (<a href='http://codepen.io/felquis'>@felquis</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

Espero que esta dica tenha sido útil :) Por algum motivo, a galera das especificações não deram a minima para a manipulação de pseudo-elementos, seria fantástico se pudessemos fazer algo assim

{% highlight js %}
document.querySelector('span:after').style.content = 'Altera a propriedade content';
{% endhighlight %}

Infelizmente isso não é possível, se você saber o porque, me conte!

## Como pegar alguma propriedade do CSS de um pseudo-elemento

Bom, não é possível alterar propriedades do CSS de pseudo-elementos, mas, é possível saber o valor de uma propriedade de um pseudo-elemento, parece que a galera que criou a especificação do getComputedStyle lembrou que existem os pseudo-elementos (risos).

O [getComputedStyle](https://developer.mozilla.org/en-US/docs/Web/API/Window.getComputedStyle) retorna todos as propriedades do CSS que foram usadas para rederizar um elemento na tela, e seus valores são imutáveis.

Para usar este método basta primeira passar um elemento, e o segundo parametro é opticional e representa um pseudo-elemento :after ou :before.

Então, assim como no nosso exemplo acima, se quisermos saber o que tem no atributo `content` basta usar o seguinte

{% highlight js %}
var styles = window.getComputedStyle(
  document.querySelector('span'),
  ':before'
);
{% endhighlight %}

Este método fantástico retorna pra gente o que eles chamam de [CSSStyleDeclaration](https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration) que de uma forma grosseira nada mais é do que um objeto em que cada propriedade é uma propriedade do CSS (confusamente simples haha)

Então, veja isso:

{% highlight js %}
var styles = window.getComputedStyle(
  document.querySelector('span'),
  ':before'
);

// Agora o que tem na propriedade content?
console.log( styles.content ); // Retorna a propriedade content

// O que tem na propriedade color?
console.log( styles.color );

// Também pode ser usado um método bonito que tem nesse tal de CSSStyleDeclaration
console.log( styles.getPropertyValue('color') );

// E por ai vai, você pode ver o que você quiser
{% endhighlight %}

Bom, talvez você não tenha encontrado a utilidade de pegar os valores computados, mas recentemente vi uma galera testando se um browser suporta CSS Animations em pseudo-elementos usando getComputedStyle, [leia o artigo completo aqui](http://davidwalsh.name/pseudo-element-animation)

Basicamente, o teste é colocar uma animação que acontece super rápida em um elemento coisa de `0.001s` animando a propriedade color de red para green, o computedStyle retorna como o elemento está renderizado na tela (logo depois da animação), e se a propriedade color está com o rgb de verde, isso significa que o browser suporta animações em pseudo-elementos (Isso porque apenas o Chrome e o Firefox suporta esse tipo de animação hoje em dia) e se tiver red significa que o browser ignorou a animation e não oferece suporte a animations em pseudo-elementos.

## Lembre-se o que são pseudo-elementos

Bom, quando se fala em pseudo-elemento a primeira (ou primeira e segunda) coisa que vem na cabeça é `:after` e `:before` pois então, faça seu dever de casa e aprenda os demais [pseudo-elementos disponíveis no CSS](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements).

Todos eles possuem recursos limitados no CSS..

Bom, acho que já passei o que queria passar, então é isso ai galere.

## Links legais que você deveria ler, mas provavelmente não vai
* [Maujor explicando um pouco sobre Pseudo-Elementos](http://www.maujor.com/tutorial/pseetut.php)
* [MDN Window.getComputedStyle](https://developer.mozilla.org/en-US/docs/Web/API/Window.getComputedStyle)
* [MDN CSSStyleDeclaration](https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration)
* [MDN CSS Attr](https://developer.mozilla.org/en-US/docs/Web/CSS/attr)
* [MDN Element.setAttribute](https://developer.mozilla.org/en-US/docs/Web/API/Element.setAttribute)
* [Manipulando o Atributo data-*](http://tutsmais.com.br/blog/html5/atributo-dados-personalizado-html5-custom-data-attributes/)
