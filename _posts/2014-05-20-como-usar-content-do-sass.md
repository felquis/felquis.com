---
title: 'Como usar @content do Sass'
layout: post
date: 2014-05-20
language: pt
tags:
- sass
description: Com a diretiva @content podemos aumentar a utilidade dos mixins de uma forma que eu não sei explicar em um resumo de post, então leia o post inteiro para entender, é bem simples eu prometo!
---

<img src="/images/posts/sass.png" alt="" style="width: 100%">

Neste post vou mostrar como a diretiva @content do Sass pode ser útil.. Para aprender sobre como usar o @content é bom ter uma experiência prévia com mixins. Mas vamos por parte, você vai conseguir.

Para criar um mixin que crie por exemplo um quadrado, o mixin seria mais ou menos como este:
{% highlight css %}
@mixin quadrado () {
  width: 100px;
  height: 100px;
  display: block;
  background: red;
}
{% endhighlight %}

E bom, para você usar este mixin é só fazer isso:
{% highlight css %}
.meu-quadrado {
  @include quadrado();
}
{% endhighlight %}

Agora, digamos que você queira passar qual cor você quer seu quadrado, seu mixin ficaria assim:
{% highlight css %}
@mixin quadrado ($color: red) {
  width: 100px;
  height: 100px;
  display: block;
  background: $color;
}
{% endhighlight %}

Certo? E se você não passar nenhuma cor, a cor padrão será red.

Vamos supor agora, que você precise criar um botão, mas este botão precise de bordas arredondadas. Como você faria isso?

Bom, você poderia criar algo como este mixin:
{% highlight css %}
@mixin quadrado ($color: red, $radius: 0) {
  width: 100px;
  height: 100px;
  display: block;
  background: $color;
  border-radius: $radius
}
{% endhighlight %}

Mas, no seu Sass, em alguns quadrados você usa bordas arredondadas, mas em outros não. Usando o mixin acima, você iria deixar uma propriedade "ociosa", que não precisa estar no seu CSS final, alias, você não precisa do border-radius.

Uma forma de resolver isso, seria usando o @content dessa forma.
{% highlight css %}
@mixin quadrado ($color: red) {
  width: 100px;
  height: 100px;
  display: block;
  background: $color;
  @content;
}
{% endhighlight %}

O que isso significa? Significa que agora podemos chamar nosso mixin dessa forma:
{% highlight css %}
.meu-quadrado {
  @include quadrado (blue) {
    border-radius: 10px;
  }
}
{% endhighlight %}

Certo? O CSS final seria isso:
{% highlight css %}
.meu-quadrado {
  width: 100px;
  height: 100px;
  display: block;
  background: blue;
  border-radius: 10px;
}
{% endhighlight %}

Bom, funciona muito bem. Mas este é um exemplo muito ruim. Vamos tentar um exemplo em que a diretiva @content realmente seja útil, vamos criar um mixin para criar o nosso querido @keyframe, você conhece essa propriedade do CSS3 né? Então, vamos lidar com todos aqueles vendors.

Para começar, um mixin que crie a regra @keyframes com alguns vendors:
{% highlight css %}
@mixin keyframes ($nome) {
    @-webkit-keyframes $nome {
        @content;
    }
    @-moz-keyframes $nome {
        @content;
    }
    @keyframes $nome {
        @content;
    }
}
{% endhighlight %}

Repare, só tem um parâmetro que é o nome da animação, e o conteúdo do mixin é colocado dentro de cada container do seu devido vendor, bem simples né?

Para usar o que é declarado na regra @keyframes, precisamos usar a propriedade animation, que também tem alguns vendors então vamos criar um mixin para a propriedade animation também.
{% highlight css %}
@mixin animation ($args) {
  -webkit-animation: $args;
  -moz-animation: $args;
  animation: $args;
}
{% endhighlight %}

Agora, quando eu precisar usar @keyframes, basta fazer assim:
{% highlight css %}
@include keyframes (nomeDaMinhaAnimação) {
  // Todo o conteúdo aqui
}
{% endhighlight %}

Isso torna nosso código muito mais simples, na pratica, para dar um pouco de animacão para nosso quadrado do primeiro exemplo, podemos fazer assim:
{% highlight css %}
@include keyframes (nomeBonito) {
  0% {
    border-radius: 0;
  }

  100% {
    border-radius: 50%;
  }
}

.meu-quadrado {
  @include quadrado();
  @include animation(nomeBonito 400ms alternate infinite);
}
{% endhighlight %}

O resultado disso funcionando você pode conferir neste Pen

<p data-height="157" data-theme-id="0" data-slug-hash="smEeA" data-default-tab="result" class="codepen">See the Pen <a href="http://codepen.io/felquis/pen/smEeA/">Exemplos do @content do Sass</a> by Felquis (<a href="http://codepen.io/felquis">@felquis</a>) on <a href="http://codepen.io">CodePen</a>.</p>

## Moral da história
Com @content, você pode passar para seu mixin um bloco de código, nos exemplos acima, usamos para passar propriedades no caso do border-radius, e também para passar um bloco de CSS da regra @keyframes com 0% e 100%..

Tem muitas possibilidades de uso do @content, algumas bonitas como nos exemplos acima e outras possibilidades feias como a [citada na documentação do Sass](http://sass-lang.com/documentation/file.SASS_REFERENCE.html#mixin-content).

Espero que você tenha entendido, qualquer dúvida deixe a pergunta nos comentários. Att
