---
layout: post
title: 'Dever de Casa Manipulação do HTML/DOM com JavaScript'
date: 2015-11-16
description: Aprenda como manipular o DOM, inserir elementos, modificar e buscar elementos alterar estilos
language: pt
tags:
- dever-de-casa
- javascript
- dom
---

Escrevo este artigo para iniciantes que já tem alguma experiência com JavaScript ou algo do tipo... qualquer dúvida escreva um comentário que irei atualizar o post para lhe ajudar, iremos aprender a como manipular o DOM(HTML) dinâmicamente com JavaScript.

Aqui uso o ECMAScript5, que é a versão do JavaScript mais suportada entre os navegadores atuais, isso significa que tudo o que você aprender aqui, você pode usar sem medo em seus sites.

Primeiro de tudo, temos que abrir o Developer Tools (Ferramentas do Desenvolvedor) deste navegador, isso muda entre os browsers, porém facilmente você encontra isso no Google. Procure "Como abrir o DevTools do ..." e nome do navegador que você está usando.

Vamos executar algum JavaScript na página do meu blog okay? Então abra o DevTools nesta mesma página.

### Tarefa 1

No console do DevTools, escreva `document`, nele é onde a manipulação do DOM começa

<img src="/images/posts/dever-de-casa-dom-basics/print-1-document.png" alt="">

Veja que ele mostra exatamente tudo o que há na página. Eu considero o `document` como uma representação de todo o documento HTML, a partir dele nós filtramos os elementos (tags HTML), assim selecionando partes especificas da página.

### Tarefa 2

Há duas ferramentas que são cruciais, elas irão libertar você das algemas da incerteza, que é as funções `console.log` e `console.dir`, sempre que você não tem certeza do que algo faz, ou não sabe quais informações ou funções estão disponíveis para uso em um Objeto, você usa essas funções para entender o que está acontecendo.

A função abaixo irá mostrar um resumo do objeto document
{% highlight js %}
console.log(document)
{% endhighlight %}

como neste print
<img src="/images/posts/dever-de-casa-dom-basics/print-2-console-log-document.png" alt="">

Já o `console.dir`
{% highlight js %}
console.dir(document)
{% endhighlight %}

Ele mostra a estrutura da informação, exibindo das as informações que o objeto possui, basta ir fazendo scroll, clicando nas setas para expandir as propriedades e descobrir novas informações. Quando eu descobri isso foi um divisor de águas, pois basta explorar e descobrir, coisas que dificilmente saberiamos o nome para procurar nome Google, e agora com uma referência podemos encontrar documentações e artigos que nos ajudam a entender métodos, informações, e APIs que estão disponíveis em cada objeto do JavaScript.

<img src="/images/posts/dever-de-casa-dom-basics/print-3-console-dir-document.png" alt="">

Para acessar essas informações basta acessar como se fosse de um objeto qualquer, por exemplo URL

{% highlight js %}
console.log(document.URL)
{% endhighlight %}

<img src="/images/posts/dever-de-casa-dom-basics/print-4-console-document-url.png" alt="">

Bom, explore um pouco o `document` com o `console.dir` e veja o que você descobre de novo a respeito deste objeto :)

### Tarefa 3

Para selecionar elementos no DOM, precisamos entender de seletores CSS,
estes seletores são bem simples pois usam os nomes dos elementos no HTML, podendo ficar um pouco confusos quando aplicados pseudo elementos e pseudo seletores.

Para selecionar elementos no DOM, usamos o método `document.querySelectorAll('seletor')`, dentro dos parenteses, no lugar de `selector` informamos o seletor CSS para filtrar elementos no DOM.

Vamos listar todos os elementos `div` que há nesta página
{% highlight js %}
  document.querySelectorAll('div')
{% endhighlight %}

E aqui está a lista de elementos `div` que estão no DOM

<img src="/images/posts/dever-de-casa-dom-basics/print-5-document-queryselectorall.png" alt="">

Podemos usar aqui o console.log e console.dir para ver a diferença no resultado

<img src="/images/posts/dever-de-casa-dom-basics/print-6-console-log-dir-queryselectorall.png" alt="">

Você já deve saber que o `console.dir` é meu favorito.

Depois do `document.querySelectorAll`, tem um método que é o `document.querySelector`, diferente do anterior que tem um ALL (todos) no nome, este ele irá retornar apenas o primeiro elemento, não importa se tiver 8 elementos div, ele irá retornar apenas o primeiro dos 8

{% highlight js %}
document.querySelector('div')
{% endhighlight %}
<img src="/images/posts/dever-de-casa-dom-basics/print-7-document-queryselector.png" alt="">

Legal né? Espera que vai melhorar!

Muitas propriedades se repetem entre os elementos, pois no DOM os elementos são objetos herdados de outro objeto que é herdado de outro objeto... e assim vai.

Vamos para exemplificar, selecionar o elemento com classe `.header`, e vamos alterar o background-color deste elemento.

{% highlight js %}
var header = document.querySelector('.header')
var backgroundColor = '#19cade'

header.style.backgroundColor = backgroundColor
{% endhighlight %}

E pronto, agora verifique a parte la de cima dessa página ficou em uma cor azulada

Aqui temos umas coisas novas, espero que você já conheça as variáveis no JavaScript, elas são muito fáceis, caso não saiba procure por "Como usar variáveis no JavaScript" no Google

Também temos o `header.style.backgroundColor = backgroundColor` a variável backgroundColor poderia ter qualquer nome, porém a propriedade `header.style.backgroundColor` é uma propriedade do CSS.

Para descobrir mais sobre esse `style`, vamos usar nosso console.dir

{% highlight js %}
var header = document.querySelector('.header')

console.dir(header.style)
{% endhighlight %}

<img src="/images/posts/dever-de-casa-dom-basics/print-8-element-style.png" alt="">

Olha só, tivemos acesse a um objeto "CSSStyleDeclation", onde temos acesso a várias propriedades do CSS. E para acessa-las basta colocar um ponto e escrever o nome da propriedade, ali já conseguimos ver que a propriedade `header.style.backgroundColor` está apenas com duas aspas, isso porque no CSS dessa página este elemento não tem nenhuma cor de fundo.

Este foi um exemplo alterando a cor de background, vamos remover todo o conteúdo do elemento header? Vamos! :v

### Tarefa 4

{% highlight js %}
var header = document.querySelector('.header')

header.textContent = ''
{% endhighlight %}

Okay, assim removemos todos os elementos de um elemento... algo que você deve ter em mente, é que no JavaScript as vezes nós temos até umas 4 maneiros de fazer a mesma coisa, há outras APIs para remover elementos filhos, porém este é o que aprenderemos aqui, é o que eu considero o mais simples e eficiente.

Okay, atualize a página para voltar meu header, você já está me hackeando em? Incrível!! Agora que tal remover esse elemento header? Durante o desenvolvimento de um site dinâmico, precisamos adicionar e remover elementos com frequência.

{% highlight js %}
var header = document.querySelector('.header')

header.parentElement.removeChild(header)
{% endhighlight %}

BUUM! Como vc é hacker! Parabéns!

Se tiver dúvidas quando as propriedades parentElement, e removeChild, nnao esqueça de usar o console.log, console.dir para explorar os resultados dessas propriedades. E não esqueça de usar o Google "Como usar removeChild no JavaScript?" :)

Ai vemos que o parentElement, faz com que tenhamos acesso ao elemento de cima no print abaixo... a partir deste elemento podemos remover o elemento que está abaixo na hierarquia de elementos.. A galera chama isso de elementos pais (parent) e elementos filhos (chidren), é uma hierarquia. Pode ser o patrão e o subordinado, no HTML os elementos que estão acima tem algum tipo de autoridade nos que estão abaixo/dentro.

<img src="/images/posts/dever-de-casa-dom-basics/print-9-element-parentelement.png" alt="">

Okay, demos uma pincelada em como mudar o estilo visual de um elemento, como remover os elementos filhos de um elemento e como remover um elemento... Porém.. como que faremos essas ações com vários elementos? Como remover a classe "active" de vários elementos? E fazer outras ações com vários elementos... Vamos aprender isso na próxima parte.

### Tarefa 5

Você já deve ter visto o NodeList em alguns prints aqui.. este tipo de objeto é uma lista de outros objetos que são elementos. A outros tipos de objetos que contem listas no DOM, existe DOMTokenList, HTMLAllCollection, HTMLCollection entre outros, porém vamos focar em NodeList que isso se aplicará para todos os outros tipos de objetos de listas.

Para começar vamos selecionar todos os elementos div novamente para objeter uma NodeList

{% highlight js %}
var divs = document.querySelectorAll('div')

console.log( div.length )
{% endhighlight %}

Okay, a propriedade length nos informa a quantidade de itens que há nessa lista, porém este tipo de objetos são diferentes de Arrays, no JavaScript arrays tem métodos uteis para manipula-las, por exemplo pop(), shift(), concat(), map(), forEach() entre outros. Uma NodeList se parece com um Array mas não tem os mesmos métodos de Arrays.

Há técnicas que convertem NodeList em Arrays, porém não vou ensinar isso a vocês. Procure no Google "How to convert nodeList to Array" há algumas maneiras, então você conseguirá aplicar a uma lista de elementos todos os métodos de Arrays.

Aqui usaremos um for, que irá percorrer toda a lista executando ações em cada elemento da lista, todas as outras técnicas fazem a mesma coisa, então não tenha medo. Vamos em frente.

{% highlight js %}
var divs = document.querySelectorAll('div')

for (var indice = 0, total = divs.length; indice < total; indice++) {
  console.log('Faça algo com ', divs[indice])
}
{% endhighlight %}

Simples assim, agora podemos executar ações em cada `divs[indice]`, porém vamos escrever uma função para nos ajudar nisso nas próximas partes.

{% highlight js %}
function each(list, transform) {
  var keys = Object.keys(list)
  var index = 0, total = keys.length

  if (typeof transform !== 'function') {
    throw('segundo parametro tem que ser uma função')
    return
  }

  for (; index < total; index++) {
    transform(list[keys[index]], index)
  }
}
{% endhighlight %}

Agora sim, podemos guardar essa função em um local de nosso projeto, que permita-nos usa-la onde quisermos.

Agora vamos percorrer todas as divs dessa página novamente

{% highlight js %}
var divs = document.querySelectorAll('div')

// Adiciona background color a um elemento
function addBackground(color) {
  // retorna uma função que recebe um elemento como parametro
  // e alteramos o backgroundColor desse elemento
  return function transform(element) {
    element.style.backgroundColor = color
  }
}

each(divs, addBackground('#19cade'))
{% endhighlight %}

O código acima é a mesma coisa que executar o código abaixo
em cada um dos elementos div da página

{% highlight js %}
addBackground('red')(document.querySelector('.header'))
{% endhighlight %}

É bem simples e fácil de entender.

Em caso de dúvida lembre-se de console.dir e console.log são seus melhores amigos.

Vamos fazer um exercicio, que tal reescrever o exemplo da tarefa 4? Vamos remover agora TODOS os elementos da página, primeiro de tudo, coloque a função `each` na página..

{% highlight js %}
var todos = document.querySelectorAll('*')

function removeElement(element) {
  // Se tiver o parentElement existir
  if (element.parentElement) {
    element.parentElement.removeChild(element)
  }
}

function each(list, transform) {
  var keys = Object.keys(list)
  var index = 0, total = keys.length

  if (typeof transform !== 'function') {
    throw('segundo parametro tem que ser uma função')
    return
  }

  for (; index < total; index++) {
    transform(list[keys[index]], index)
  }
}

each(todos, removeElement)
{% endhighlight %}

Uau, então, vimos como é poderoso esse each, realmente a ação é executada em todos os elementos... Lembre-se que com grandes poderemos vem grandes responsabilidades ;)

Adicionar uma cor a um elemento parece algo bem fácil, vamos tornar as coisas no DOM interativas... Que tal conseguir executar uma ação quando o usuário interagir de alguma forma com a página? Agora as coisas estão ficando interessante, vem com o pai.

### Tarefa 6

Se você tem um elemento de um botão, e quando o usuário interagir com este botão seja clicando ou tocando nele você quer alterar o tamanho desse elemento ou executar qualquer outra ação... Para isso precisamos saber como adicionar "Eventos" a um elemento. Para entender como eventos funcionam recomendo [lerem este artigo O que é Event Delegation no JavaScript](http://tutsmais.com.br/blog/javascript-2/o-que-e-event-delegation-no-javascript/).

### Tarefa 7

Algo que temos que ter em mente agora, é que na manipulação do DOM, muitas pequenas ações acontecem, e saber abstrair essas ações em funções menores pode desbloquear uma grande oportunidade de tornar sua aplicação um pedaço de código reusável, isso significa que durante o inicio ao fim de um projeto, você acabará reescrevendo algumas partes do seu projeto para que essas partes reuzem alguma outra parte. Isso é especialmente útil para todo e qualquer projeto em que você queira reusar funções no futuro, seja no mesmo projeto ou em outros projetos, sendo que algumas partes podem até mesmo serem disponibilizadas por meio do GitHub, Gist ou outras ferramentas de compartilhamento de código.

Um exemplo é a função each, essa funão é muito simples e funciona perfeitamente para percorrer lista de elementos, lista de objetos, pode ser seu próprio Array. Dependendo da sua necessidade, este método pode se tornar mais completo ou ainda mais simples. Desenvolvo a 5 anos, e tenho muito aprender, porém você iniciante ou intermediário como eu, tem que ouvir este conselho, pois é o que eu gostaria de ouvir, o conselho é: A partir do momento que seu programa executa a ação que você esperava com sucesso - independente do que alguns chamam de boas práticas - seu programa é perfeito.

A tarefa 7 era apenas isso, intenda como quiser.

### Tarefa 8

Para adicionar e remover elementos do DOM, temos algumas técnicas também, vou sugerir que você leia [este artigo onde mostro como o insertAdjacentHTML funciona](http://tutsmais.com.br/blog/dom4/como-inserir-elementos-html-com-javascript-ou-como-usar-insertadjacenthtml/), é um método bem simples que funciona de forma semelhante ao innerHTML, porém com mais flexibilidade.

### Conclusão...

Espero que aqui eu tenha trazido uma luz para você a manipulação do DOM com JavaScript, o que aprendemos aqui foi, a selecionar elementos, e selecionar listas de elementos, como manipular apenas um elemento ou vários elementos. Também aprendemos um pouco da importante de escrever pequenos pedaços simples de código para serem reutilizados.

Caso você tenha alguma dúvida sobre manipulação do DOM, por favor expresse nos comentários que irei buscar escrever sobre estes assuntos no futuro.

Um grande abraço e um bom estudo para você.
