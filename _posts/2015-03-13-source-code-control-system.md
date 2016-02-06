---
layout: post
title: "Source Code Control System"
date: 2015-03-13
---

One of the most important things we look for in a user interface is the `UNDO` button — a button to redeem us for our mistakes. It's even better when the enviroment gives us a number of support between undo and redo, so we can go back and fix the error.

<!--more-->

But what if the mistake happened last week, and you've turned your computer on and off ten times since then? Well, that's one of many benefits of using a source code control system: it's a giant `UNDO` key — a project-wide time machine that can return you to those halcyon days of last week, when the code actually compile and run.

Source Code Control System, or the more widely scope _configuration management systems_, keep track of every change you make in your source code or documentation. The better ones can keep track of compiler and OS version as well. With a properly configured source code control system, you can _always go back to a previous version of your software_.

But a Source Code Control System([SCSS](https://en.wikipedia.org/wiki/Source_Code_Control_System)) does far more than undo mistakes. A good SCCS will let you track changes, answering question such as: Who made changes in this line of code? What's the difference between the current version and the week's? Which files get changed most often? This kind of information is invaluable for bug-tracking, audit, performance and quality purpose.

An SCSS will also let you identify releases of your software. Once identified, you will always be able to go back and regenarate the release, independent of changes that may have occurred later.

We often to use SCSS to manage branches in the development tree. For example, once you have released some software, you'll normally want to continue developing for the next release. At the same time, you'll need to deal with bugs in the current release, shipping fixed versions to clients. You'll want these bug fixes rolled into the next release(if appropriate), but you don't want ship code under developement to clients.

With an SCSS you can generate branches in the development tree each time you generate a release. You apply bug fixes to code in the branch and continue developing on the main trunk. Since the bug fixes may be relevant to the main trunk as well, some system allow you to merge selected changes from the branch back into the main trunk automatically.

Source Code Control Systems may keep the files they maintain in a central repository — a great candidate for archiving.

Finally, some products may allow two or more users to be working concurrently on the same set of files, even making concurrent changes in the same file. The system then manage the merge of these changes when the files are sent back to the repository. Although seemingly risky, such system work well in pratice on project of all sizes.

> Always Use Source Code Control

Always. Even if you a single-person team in a one-week project. Even if it's a "throw-away" prototype. Even if the stuff you're working on isn't source code. Make sure that _everything_ is under source code control — documentation, phone lists, memos to vendors, the little shell script — everything. We routinely use source code control on just about everything we type(including this text of this post). Even if you're not working on a project, our day-to-day work is a secured in a repository.

## Source Code Control and Builds

There is a tremendous hidden benefit in having an entire project under the umbrella of a source code control system: you can have a product builds that are _automatic_ and _repeatable_.

The project build mechanism can pull the latest source out of repository automatically. It can run in the middle of the night after everyone(hopefully) gone home. You can run automatic regression tests to ensure that day's coding dind't break anything. The automation of the build ensures consistency — there are no manual procedures, and you won't need developers remembering to copy code into some special area.

The build is repeatable because you can always rebuild the source it existed on a given date.

## But My Team Ins't Using Source Code Control

Shame on them! Sounds like an opportunity to do some evangelizing! However, while you wait for them to see the light, perhaps you should implement you own private source code control. Use one of the [free available tools](https://en.wikipedia.org/wiki/List_of_version_control_software) and make a point of keeping your personal work safely tucked into a repository(as well as doing whatever project your project require).

Remembering the SCSS works outside of a workplace.
