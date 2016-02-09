---
layout: post
title: "A Quickly Dive In To Regular Expressions"
date: 2016-01-29
---

Hello, how about forgetting a little routine and reality and take a trip to the interior of your mind? Discover new, different concepts. When go back, things will not be as normal as before because strangest symbols will be part of your day-to-day life.

<!--more-->

Inspired by operating their own neurons, discover the fascinating world of Regular Expressions.

## Preseting the Regular Expression

So, in order to start our trip, nothing like a presentation of the subject, because, after all, what's Regular Expression?

Well sumerized, regular expression is a formal method to specify a text pattern.

More detailed, is a composition of symbols, characters with a special function, which grouped among themselves and with literal characters form a sequence, a expression. This is expression is interpreted as a rule that indicates a success or failure depending on the input. It's exactly all the conditions of the expression.

Or as accepted variations also can be said that is:

- a way to find a text that you do not remember exactly how, but have no idea of possible variations;
- a way for a programmer to specify complex patterns that can be searched and married in a string;

Or formally speaking is:

- as a game, in the begining it's difficult, but after knowing all the rules, just play and enjoy;
- as a recipe with ingredients and a proper order to add them to the mixture;

Above all, a Regular Expression is **fun**.

## Learn more about history of (re|regex)

Regular expressions are originated in 1956, when mathematician [Stephen Cole Kleene](https://en.wikipedia.org/wiki/Stephen_Cole_Kleene) described [regular languages](https://en.wikipedia.org/wiki/Regular_language) using his mathematical notation called _regular sets_. These arose in [theorical computer science](https://en.wikipedia.org/wiki/Theoretical_computer_science), in the subfields of [automata theory](https://en.wikipedia.org/wiki/Automata_theory)(models of computation) and the description and classification of [formal languages](https://en.wikipedia.org/wiki/Formal_language). Other early implementations of [pattern matching](https://en.wikipedia.org/wiki/Pattern_matching) include the [SNOBOL](https://en.wikipedia.org/wiki/SNOBOL) language, which did not use regular expressions, but instead its own pattern matching constructs.

> Quickly introduction from [Wikipedia's](https://en.wikipedia.org/wiki/Regular_expression).

<img src="/images/posts/history.png" style="margin: 0 auto;" alt="persons who brought regex|re">

In 1968, the UNIX pioneer _Ken Thompson_ published the article [Regular Expression Search Algorithm](http://www.fing.edu.uy/inco/cursos/intropln/material/p419-thompson.pdf) in Communications of the ACM (CACM), Volume 11. With code and prose he described a Regular Expression compiler that creates a IBM 7094 Object code. Thompson's effort did not end there. He also implemented Kleene’s notation in the editor `QED`. The aim was that the user could do advanced pattern matching in the files. The same feature appeared on the editor `ed`.

To search for a Regular Expression in `ed` you wrote `g/<regular expression>/p`. The letter `g` means global search and `p` are print the result. The command - `g/re/p` resulted in the standalone program `grep`, released in the fourth edition of UNIX 1973. However, `grep` didn't have a complete implementation of regular expressions, and it was no until 1979, in the seventh edition of UNIX the we were blessed with Alfred Aho's `egrep` - _extended grep_. Now the circle was closed. The `egrep` program translated any regular expression to a corresponding DFA.

<img src="/images/posts/perl_problems.png" style="margin: 0 auto;" alt="wtf is regular expression?">

<div class="alt">
    Some people, when confronted with a problem, think I know, I’ll use regular expressions. Now they have two problems. <i>Jamie Zawinski</i>
</div>

It's totally true if you do not pratice regex. In a very short period of time you'll forget many of things to use. However, it's totally understandable if you not use it everyday. Most of us do not use.

<hr>

Regular Expressions are both terribly awkward and extremely useful. But they are a powerful tool for inspecting and processing strings. Properly understanding regular expressions will make you a more effective programmer.

## The Notation

If you are using regex on a programming language. In JavaScript for example a regular expression is a type of an Object. In many cases, you can create a new regex by simple put slash `/<regex>/` to start write.

{% highlight bash %}
/abc/
{% endhighlight %}

Where the pattern appears between slash characters, treats backslashes somewhat differently. First, since a forward slash ends the pattern, we need to put a backslash before any forward slash that we want to be part of the pattern. In addition, backslashes that aren’t part of special character codes (like `\n`) will be _preserved_, rather than ignored as they are in strings, and change the meaning of the pattern. Some characters, such as question marks and plus signs, have special meanings in regular expressions and must be preceded by a backslash if they are meant to represent the character itself.

{% highlight bash %}
/eighteen\+/
{% endhighlight %}

Knowing precisely what characters to backslash-escape when writing regular expressions requires you to know every character with a special meaning. For the time being, this may not be realistic, so when in doubt, just put a backslash before any character that is not a letter, number, or whitespace.

## Testing By Matches

It's more easily to find your pattern testing by a match. When you want one word, first take your firsts characters and improve you pattern to find what you want.

{% highlight bash %}
\d+ #=> 123456789
{% endhighlight %}

The website I recommend to use is [regex101.com](http://regex101.com/). You can put a string by example and test your pattern through test string below.

{% highlight linenos %}
/[123456789]+/ # "In 1992" #=> 1992
/[0-9]+/ # "In 1992" #=> 1992
/\d+/ # "In 1992" #=> 1992
{% endhighlight %}

Within square brackets, a dash (`-`) between two characters can be used to indicate a range of characters, where the ordering is determined by the character’s Unicode number. Characters 0 to 9 sit right next to each other in this ordering (codes 48 to 57), so `[0-9]` covers all of them and matches any digit.

There are a number of common character groups that have their own built-in shortcuts. Digits are one of them: `\d` means the same thing as `[0-9]`.

- `\d` - Any digit character
- `\w` - An alphanumeric character (“word character”)
- `\s` - Any whitespace character (space, tab, newline, and similar)
- `\D` - A character that is not a digit
- `\W` - A nonalphanumeric character
- `\S` - A nonwhitespace character
- `.` - Any character except for newline

So you could match the date format with the following pattern:

{% highlight bash %}
/\d\d-\d\d-\d\d\d\d \d\d:\d\d/ #=> 29-01-2016 15:20
{% endhighlight %}

That's look completely awful, doesn't it? It has way too many backslashes, producing background noise that makes it hard to spot the actual pattern expressed. We'll see a slightly improved version of this pattern using range `{}`.

{% highlight bash %}
/(\d{1,2}-\d{1,2}-\d{4}) (\d{1,2}:\d{2})/ #=> 29-01-2016 15:20
{% endhighlight %}

Don't be scared with the pattern we've used above. Analysing the string by parts, we can understand what she does. First we need find groups `()`, the groups are used to break your pattern in parts. Let's understand the pattern by parts. In pattern above, we have 2 groups, a date and a time `(\d{1,2}-\d{1,2}-\d{4})` - `(\d{1,2}:\d{2})`. By make this we break the pattern in two parts, now take the first part to break in another parts. Let's get the part `\d{1,2}` what do you think it does? It's exactly what you think. He'll take exactly two number of string. Understanding this you can understand others parts.

These backslash codes can also be used inside square brackets. For example, `[\d.]` means any digit or a period character. But note that the period itself, when used between square brackets, loses its special meaning. The same goes for other special characters, such as `+`.

To invert a set of characters—that is, to express that you want to match any character _except_ the ones in the set—you can write a caret (`^`) character after the opening bracket.

{% highlight bash %}
/[^\d]/
{% endhighlight %}

## Repeting Parts of a Pattern

We now know how to match a single digit. What if we want to match a whole number—a sequence of one or more digits?

When you put a plus sign (`+`) after something in a regular expression, it indicates that the element may be repeated more than once. Thus, `/\d+/` matches one or more digit characters.

{% highlight linenos %}
/\d+/ # 123 #=> true
/\d+/ # '' #=> false
/\d*/ # 123 #=> true
/\d*/ # '' #=> true
{% endhighlight %}

The star (`*`) has a similar meaning but also allows the pattern to match zero times. Something with a star after it never prevents a pattern from matching—it’ll just match zero instances if it can’t find any suitable text to match.

## Making characters optional

A question mark makes a part of a pattern "optional", meaning it may occur zero or one time. In the following example, the _u_ character is allowed to occur, but the pattern also matches when it's missing.

{% highlight bash %}
/neighbou?r/ # neighbor #=> true
{% endhighlight %}

## Grouping Subexpression

To use an operator like `*` or `+` on more than one element at a time, you can use parentheses. A part of regular expression that is enclosed in parentheses counts as a single element as far as the operators following it are concerned.

{% highlight bash %}
/boo+(hoo+)+/i #=> Boohoooohoohooo
{% endhighlight %}

The first and second `+` characters apply only to the second `o` in `boo` and `hoo`, respectively. The third `+` applies to the whole group `(hoo+)`, matching one or more sequences like that.

The `i` at the end of the expression in the previous example makes this regular expression case insensitive, allowing it to match the uppercase `B` in the input string, even though the pattern is itself all lowercase.

## Choice Pattern's

So we want to know whether a piece of text contains not only a number but a number followed by one of the words `cow`, `table` or `mail` and any other plural form of this words.

We could write tree regex to find this words, but there's a nicer way. The pipe character (`|`) denotes a choice between the pattern to its left and the pattern to its right. So I can say this:

{% highlight bash %}
/\b\d+ (cow|table|mail)s?\b/
{% endhighlight %}

Parentheses can be used to limit the part of the pattern that the pipe operator applies to, and you can put multiple such operators next to each other to express a choice between more than two patterns.

## The mechanics of matching

Regular expressions can be thought of as flow diagrams. This is the diagram for the livestock expression removed from [Eloquent Javascript Book's](http://eloquentjavascript.net/09_regexp.html). And I recommend you to read the section on book if you want to know how to use regex with JS.

The following example is removed from the book because this is a good example to know about the mechanics of matching.

{% highlight bash %}
/\b\d+ (ping|cow|chicken)s?\b/
"15 pigs" #=> true
"15 pigchickens" #=> false
{% endhighlight %}

<img src="/images/posts/mechanism_of_matching.svg" style="margin: 0 auto;">

Our expression matches a string if we can find a path from the left side of the diagram to the right side. We keep a current position in the string, and every time we move through a box, we verify that the part of the string after our current position matches that box.

So if we try to match "the 3 pigs" with our regular expression, our progress through the flow chart would look like this:

- At position 4, there is a word boundary, so we can move past the first box.
- Still at position 4, we find a digit, so we can also move past the second box.
- At position 5, one path loops back to before the second (digit) box, while the other moves forward through the box that holds a single space character. There is a space here, not a digit, so we must take the second path.
- We are now at position 6 (the start of “pigs”) and at the three-way branch in the diagram. We don’t see “cow” or “chicken” here, but we do see “pig”, so we take that branch.
- At position 9, after the three-way branch, one path skips the s box and goes straight to the final word boundary, while the other path matches an s. There is an s character here, not a word boundary, so we go through the s box.
- We’re at position 10 (the end of the string) and can match only a word boundary. The end of a string counts as a word boundary, so we go through the last box and have successfully matched this string.

Conceptually, a regular expression engine looks for a match in a string as follows: it starts at the start of the string and tries a match there. In this case, there is a word boundary there, so it’d get past the first box—but there is no digit, so it’d fail at the second box. Then it moves on to the second character in the string and tries to begin a new match there... and so on, until it finds a match or reaches the end of the string and decides that there really is no match.

## Summary

Regular expressions are objects that represent patterns in strings. They use their own syntax to express these patterns.

- `/abc/` - A sequence of characters
- `/[abc]/` - Any character from a set of characters
- `/[^abc]/` - Any character not in a set of characters
- `/[0-9]/` - Any character in a range of characters
- `/x+/` - One or more occurrences of the pattern x
- `/x+?/` - One or more occurrences, nongreedy
- `/x*/` - Zero or more occurrences
- `/x?/` - Zero or one occurrence
- `/x{2,4}/` - Between two and four occurrences
- `/(abc)/` - A group
- `/a|b|c/` - Any one of several patterns
- `/\d/` - Any digit character
- `/\w/` - An alphanumeric character (“word character”)
- `/\s/` - Any whitespace character
- `/./` - Any character except newlines
- `/\b/` - A word boundary
- `/^/` - Start of input
- `/$/` - End of input

## Conclusion

This is a quickly introduction about Regular Expressions. Still has much to learn about and discover new things to use in your day-to-day life. I hope you enjoy this post and we'll see in the next's posts about regex.
