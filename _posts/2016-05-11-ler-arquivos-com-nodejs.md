---
layout: post
title: Como ler arquivos com NodeJS
date: 2016-05-11
description: Sem usar packages do `npm`, iremos ler e analisar as linhas de um arquivo com NodeJS
language: pt
tags:
- nodejs
- file system
---

A cerca de três maneiras de ler arquivos no NodeJS, o que irei mostrar aqui, é uma maneira que funcionará bem mesmo se o arquivo for bem grande, como 10gb.

Consiste no uso dos módulos [`readline`](https://nodejs.org/dist/latest-v4.x/docs/api/readline.html), [`stream`](https://nodejs.org/dist/latest-v4.x/docs/api/stream.html),
 [`fs`](https://nodejs.org/dist/latest-v4.x/docs/api/fs.html) e [`path`](https://nodejs.org/dist/latest-v4.x/docs/api/path.html)
 todos são módulos do próprio NodeJS, e não é necessário usar packages do [`npm`](http://npmjs.com/).
 Do [`util`](https://nodejs.org/dist/latest-v4.x/docs/api/util.html#util_util_log_string) vou usar apenas a função `util.log`

{% highlight js %}
var fs = require('fs')
var readline = require('readline')
var stream = require('stream')
var util = require('util')
var path = require('path')
{% endhighlight %}

A estrutura de pastas do projeto é
{% highlight text %}
- src
    file.log
    read-file.js
- package.json
{% endhighlight %}

Assim, vamos usar o `path` para ter exatamente o path do arquivo que queremos ler

{% highlight js %}
// arquivo que será lido
var logFile = path.resolve(__dirname, 'file.log')
{% endhighlight %}

O `__dirname` contem o path em que está sendo executado o arquivo `read-file.js`, se o `file.log` estiver numa pasta diferente, fora do diretório `src`, por exemplo em `./files/logs/file.log` podemos seleciona-lo da seguinte maneira
{% highlight js %}
// arquivo que será lido
var logFile = path.resolve(__dirname, '../files/logs', 'file.log')
{% endhighlight %}

Já temos o arquivo que queremos ler, agora precisamos de fato, criar um readStream com o `fs`
{% highlight js %}
// stream do arquivo de log
var instream = fs.createReadStream(logFile);
{% endhighlight %}

O instream é o input de dados, e para ler este stream precisamos de um output também.
{% highlight js %}
// output stream das linhas lidas
var outstream = new stream;

// junto o instream com o outstream usando o readline
var fileStream = readline.createInterface(instream, outstream);
{% endhighlight %}

A variável `fileStream` emite alguns eventos, como `line` quando uma linha está sendo lida, ou `close` quando o arquivo foi lido completamente.

Vamos adicionar o evento `line`.

{% highlight js %}
// o evento line é emitido para cada linha do arquivo
fileStream.on('line', function(linhaDoArquivo) {
  // aqui você pode fazer o que quiser com
  // a linha do aqui
  console.log( linhaDoArquivo )
});
{% endhighlight %}

Já podemos executar `node src/read-file.js` e ver que cada linha do arquivo `file.log` é exibida no `console`.

![print screen do terminal, onde mostra o console.log de cada linha do arquivo](/images/posts/nodejs-readline-001.png)

Vamos usar também o evento `close` agora

{% highlight js %}
// evento disparado quando geralmente
// depois que a ultima linha do arquivo
// é lida
fileStream.on('close', function() {
  util.log('file.log lido')
});
{% endhighlight %}

![print screen do terminal, mostrando o console.log de cada linha do arquivo, e por fim a indicação que o arquivo foi lido](/images/posts/nodejs-readline-002.png)

Este módulo readline tem uma API muito interessante, as demonstrações na documentação vão muito além de simplesmente ler um arquivo do inicio ao fim

Gostaria de em um momento oportuno falar sobre o readline, porém no momento este tutorial chegou ao fim.
Ler arquivos com NodeJS definitivamente é muito simples, enquanto eu testei aprendi algumas coisas como...

## Mensurar quanto tempo demora para ler um arquivo

Quanto maior o arquivo mais tempo irá demorar para ler, em um arquivo com 700 mil linhas, aproximadamente 200 megas, meu computador demorava 11 segundos para ler

Para mensurar usei o console.time e console.timeEnd, veja o código comentado mais a baixo, para ler o arquivo desta demonstração aqui demorou 10ms, e no seu computador? Mande um printscreen

![Print screen do log das linhas do arquivo, no final mostrando 10ms, tempo usado para ler o arquivo](/images/posts/nodejs-readline-003.png)

## Verificar se um linha da match em uma expressão regular

Por exemplos, vamos apenar exibir as linhas que contem a letra M ou E minuscula ou maiuscula

{% highlight js %}
// o evento line é emitido para cada linha do arquivo
fileStream.on('line', function(linhaDoArquivo) {
  // Apenas segue, se a linha tiver a letra E
  if ( !/([e])/i.test(linhaDoArquivo) ) { return }

  console.log( linhaDoArquivo )

  // incrementa o número de linhas
  totalLines++;
});
{% endhighlight %}

![print screen do terminal, exibindo: Meu, Nome, Felquis. Palavras com ocorrência da letra E](/images/posts/nodejs-readline-004.png)

Vemos que há três linhas com ocorrência da letra E

## Ler arquivos de log do servidor HTTP

Quando surgiu a necessidade de ler arquivos, eu queria justamente ler arquivos de log do servidor,
onde cada linha é um log HTTP, fiz um método de parsing, que retornava um objeto de uma String de log,
retornando o status, path, query, referrer etc... depois que o arquivo era lido, e mantido em memória
eu fazia alguns maps, para filtros, para responder perguntas como:

- "Quais rotas retornaram 500 na madrugada de ontem?"
- "Quantas vezes os usuários curtidas/descurtiram um determinado post? Logs HTTP da API"
- "Quantos IPs únicos acessaram determina rota da API?"

## Conclusão

Foi um aprendizado bem interessante, por isso estou compartilhando. Não entendo muito de NodeJS, por isso ler
um arquivo com sucesso e analisar o seu conteudo, foi algo que me deixou bem contente.

## Resultado

`read-file.js`: confira o [repositório deste tutorial no GitHub](https://github.com/felquis/tutorial-nodejs-readline)

{% highlight js %}
var fs = require('fs')
var readline = require('readline')
var stream = require('stream')
var util = require('util')
var path = require('path')

// arquivo que será lido
var logFile = path.resolve(__dirname, 'file.log')
// stream do arquivo de log
var instream = fs.createReadStream(logFile);
// stream das linhas lidas
var outstream = new stream;
var fileStream = readline.createInterface(instream, outstream);

// A cada linha do arquivo, incrementamos essa variável
var totalLines = 0

util.log('Começa a ler', logFile.split('/').pop())

console.time('reading log file')

// o evento line é emitido para cada linha do arquivo
fileStream.on('line', function(linhaDoArquivo) {
     // Apenas segue, se a linha tiver a letra E
  if ( !/([e])/i.test(linhaDoArquivo) ) { return }

  // aqui você pode fazer o que quiser com
  // a linha do aqui
  console.log( linhaDoArquivo )

  // incrementa o número de linhas
  totalLines++;
});

// evento disparado quando geralmente
// depois que a ultima linha do arquivo
// é lida
fileStream.on('close', function() {
  util.log('closed')
  util.log('lines: ', totalLines)
  console.log('- '.repeat(10))
  util.log('file.log lido')

  // Para o timer aqui, para ver quanto tempo
  // demorou a ação
  console.timeEnd('reading log file')
});
{% endhighlight %}

Obrigado por ler
