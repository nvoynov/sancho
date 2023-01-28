---
title: Punch Story
date: 2023-01-26
...

Punch story began somewhere in September 2022. I left my employer with the feeling that playing Business Analyst last ten years, I lost the reality of modern software design and construction. I wanted to dispel that feeling so took some time off to refresh my expertise in the subject.

I wanted distributed systems, message brokers, event-sourcing, CQRS, etc. So I decided to go straight for distributed back-end and microservices. But before touching techs, I intended to have _"clean" and "screaming"_ microservices, so I started with business logic in the first place.

Enforced with The Clean Architecture I build _Cleon Gem_, which gave me the basic frame of services, entities, and gateways. Tired of manually copying sources for the next app, I added a simple CLI to clone the frame into a new gem where I was supposed to design the business logic of the app further.

Further being curious about the idea of code generation, I created a simple DSL for describing domains in terms of services and entities. This idea was shaped into Dogen Gem (domain generator.) and my new flow became 1) describe the domain, 2) generate domain skeleton sources, and finally 3) design business logic manually inside created and required sources. So at this stage, Cleon provided me with core concepts of services and entities, whereas Dogen provided me with domain DSL and code generation. I was pretty happy with that two.

I got a probation period in a development company and one of the reasons why they looked to my side was my Cleon gem. The company team worked with bare applications and the idea of packing business logic into gems seemed just extraneous to them. But I am still curious why I added this constraint at all.

This probation period was quite an exciting time where I finally saw a few real microservices codebases, played a bit with Docker, developed in containers, and met RabbitMQ... but it was not the right place for me.

And by the impact of this time, I designed [Punch](https://github.com/nvoynov/punch) that merged Cleon with Dogen and eliminate extraneous constraints. So my next app will start from `$ punch new` and the following step will be designing the domain with Punch::DSL.
