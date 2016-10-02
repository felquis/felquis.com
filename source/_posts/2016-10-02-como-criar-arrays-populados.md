---
layout: post
title: Como criar array populados com JavaScript
date: 2016-10-02
description: Como criar um array com 100 indices, populados com numeros de 0 a 99 com JavaScript

language: pt
tags:
- JavaScript
- Desafios
---

Olá, o JavaScript é uma linguagem tão flexivel que geralmente temos N maneiras de resolver o mesmo desafio.

você verá isso na prática no decorrer deste post, pois nossa missão é criar um array como este
{% highlight js %}
var list = [0, 1, 2, 3, 4, ..., 97, 98, 99]
{% endhighlight %}

Você quer chutar quantas maneiras temos de fazer isso com JavaScript tanto no Browser quanto no NodeJS? Pense em um número e depois comente.

## Desafio

Antes de continuar lendo, tente você mesmo resolver este desafio. E coloque no seu comentário sua resolução.

O resultado será valido se passar pelo seguinte teste

{% highlight js %}
import createArray from '/lib/createArray.js'

describe('createArray', function () {
    it ('should return a valid array with 100 indices counting from 0 to 99', function () {
        var list = createArray(100)

        expect(list.length).toBe(100)
        expect(list.lastIndexOf(0)).toBe(0)
        expect(list.lastIndexOf(99)).toBe(99)
    })
})
{% endhighlight %}

## Array(n) é um pouco contra intuitivo

Se você acha que um Array(10) retorna um array com 10 indices, você está meio certo, o problema é que não conseguimos usar funções como [forEach](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach), [map](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/map), [reduce](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/reduce) com este tipo de array.

{% highlight js %}
var arr = Array(10)

arr.forEach((value, index) => {
    console.log(index, value)
})
{% endhighlight %}

Você esperava exibir dez vezes o comando `console.log('indice', 'valor do indice')` mostrando os 10 itens de seu novo array, mas não foi isso que aconteceu.

Vamos ver algumas maneiras de fazer isso, de forma que vamos poder usar um forEach ou map nele.

## Maneira 1

{% highlight js %}
var list = Array(10).fill().map((x, index) => index)
{% endhighlight %}

O [Array.fill](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript/Reference/Global_Objects/Array/fill) coloca em cada indice do array, o valor `undefined` pois não passamos nenhum valor para a função fill, se usar `Array(10).fill('felquis')` ele colocará/preencherá com a string `felquis` cada indice do array.

Em ordem de fazer o array atender aos requisitos do teste, usamos um [Array.map](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/map) que altera cada indice do array com o valor retornado na função passada, neste caso é retornado o index pois `(x, index) => index` é o mesmo que `function (xx, index) { return index }`

O map tem suporte de browsers excelente, você pode ter problemas com ele apenas com o IE8, use o core-js.

Já o fill o suporte é muito ruim, pois você tem que usar um polyfill se quiser usa-lo.

## Maneira 2

{% highlight js %}
var list = [...Array(10).keys()]
{% endhighlight %}

Bom, aqui temos uma pitada de ES6 spread operator, para usar este snippet devemos usar o [babel](http://babeljs.io/) ou [TypeScript](https://www.typescriptlang.org/) juntamente com o core-js, em algum momento irei fazer um artigo sobre as diferenças do output do [Babel e do TypeScript](http://stackoverflow.com/questions/37430608/what-are-the-main-differences-between-babel-and-typescript)

## Maneira 3

{% highlight js %}
var list = Array.from(Array(10)).map((x, index) => index)
{% endhighlight %}

O [Array.from](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Array/from) é uma feature com suporte muito ruim, excluindo plataformas chave como IE Mobile, Safari Mobile, Android, tem que ser usado juntamente com o Polyfill [core-js](https://github.com/zloirock/core-js) para funcionar nessas plataformas.

## Maneira 4

{% highlight js %}
var list = Array.apply(null, Array(10)).map((x, index) => index)
{% endhighlight %}

O uso do [Array.apply](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Function/apply) pode parecer um tanto black magic se você não o entende ele muito bem, infelizmente não tenho uma explicação no momento sobre como o `Array.apply(null, Array(20))` retorna um array populado com `undefined`. Mas ele faz!  O suporte do apply é excelente, no MDN não há informações, mas no MDSN (MicroSoft Developer Network) diz que o [apply existe desde o IE6](https://msdn.microsoft.com/library/s4esdbwz(v=vs.94).aspx).

## Suporte de Browsers

É considerado o suporte ruim, ever green, excelente, ou duvidoso as features que casam com a seguinte definição

**Suporte muito ruim**: o suporte é muito ruim quando ele exclui plataformas inteiras, deve-se usar o core-js.

**Suporte ever green**: o suporte de browser não exclui nenhuma plataforma com navegador padrão em versão mais recente

**Suporte excelente**: apenas não funciona em 1 ou 2 browsers, em versões muito antigas

**Suporte duvidoso**: Não tem dados de suporte de browser ainda ou usa um ? como valor

Para essas conclusões usei a tabela de compatibilidade da MDN

## Abstração

É interessante usar algo que abstraia isso para você, então devemos escolher uma dessa maneiras para usar em nossa abstração, para que o suporte de browsers atenda o maior numero de publico possivel, vou usar a maneira 4 para criar arrays.

{% highlight js %}
var createArrayIndex = function (n) {
    Array.apply(null, Array(n))
}

createArrayIndex(10).map((value, index) => index)
{% endhighlight %}

## Benchmark

No momento não tenho um benchmark sobre qual é melhorar usar no quesito velocidade usando `performance.now()` ou `Date.now()`, talvez eu faça no futuro.

## Conclusão

Espero que você tenha aprendido algo novo aqui, caso você saiba de alguma informação que possa enriquecer mais o conteúdo, me diga usando a sessão de comentários.

Se souber outras maneiras de fazer isso com JavaScript, envie sua sugestão na sessão de comentários.

Abraço!
