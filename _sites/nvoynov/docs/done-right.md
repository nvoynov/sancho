---
title: Done Right
date: 2023-01-27
...

What do you usually start designing a new app from? Will you start by generating a skeleton with your lovely framework, creating an application interface, or maybe designing a data model? Will it differ when you start just from scratch and when you have clear requirements?

## Business Logic

I tend to start from Value, and for me it is inside the business-logic layer (domain). This layer consists of use cases (interactors, features, etc.), entities, and plugins. Where every use case brings value to some actor, processes some data structures (entities, values, aggregates), and calls some services outside the domain (data storage, third-party API, etc.)

I work with Ruby so my domain will be a set of clean PORO classes with no dependencies from outside the domain. My domain plugin interfaces will be designed from the point of how it suits for the domain to call something from outside.

All the domain services will be thoroughly tested by using mocks and stubs. My choice there is Minitest, unit- and spec mixed style, depending on the test subject.

I've embraced The Clean Architecture and understand its benefits and related expenses, have done some preparations and automated all the boring work related to creating and requiring source files.

Today, when I have [Punch](TODO) I will express my domain through DSL pointing all the domain services and entities and then generating a source skeleton of the whole domain. You can find some examples of the DSL [here](.punch/domain/sample.rb) and [there](.punch/domain/domain.rb). My provisional assessment shows that skeleton code might be up to 50% LOC of finished domain (code and tests.) This code is quite simple, usually it just one `call` method per one service and  `initialize` per one entity.

> It might seem sort of extra fancy work, but it is the only point of freedom from extraneous dependencies, and any leaked-out tech at this point will only contort your app intent. Techs come and go, domains evolve together with user value not with "techs".

## Domain Face

To interact with the domain from outside it must be equipped with a "face" (user interface) that serves as a bridge between the domain and the user environment.

> When one starts from sort of `rails new app` and then `rails some controller` - one actually starts with "face". But it tends to slide into the wrong problem further, like "thick controller / thick model".

So my next step will be providing users with a first "face" (the right scope for a software development project usually is  a particular "face" technology like a web app, desktop app, HTTP/JSON API, etc.)

Basically one can see a face as a controller with the following request handling cycle (assume HTTP as an example):

1. Receive user requests in user language (HTTP);
2. Translate user request to domain language (-> Ruby);
3. Make domain request and get domain response (Ruby);
4. Translate the response to user language (-> HTTP);
5. respond to the user with the translated response (HTTP).

Having the domain in the previous step, at this "face layer" one mainly focuses on 1) adopting incoming requests and proxying them to the domain, then 2) presenting the domain responses for the user environment (HTML/JSON/etc.).   

And when you have a separate domain business logic layer, you can equip it with as many faces as you need, and all you should do there - is just adapt the environment to the domain and present the response back to the environment.

I'm back-end oriented so I leave MVC and rich web/desktop views aside for this time (just haven't made any.) But when we speak of simple controller interface described above like API, having a domain described in `Punch::DSL` most of the source code of this layer could be just generated ("punched"). The only thing that deserves attention here - presenters.

So for this layer I usually do the following:

1. design a new general controller interface which locate domain service, adapt request to the domain, and present the domain service response;
2. design set of presenters, one presenter per one entity;
3. design a basic action proxy interface for calling domain service from "face" environment;
4. generate set of proxies, one proxy per one domain service;
5. design tests for general controller interface and presenters.

At this moment I have designed faces for the following tech (they all share the same presenter that presents responses as Hash and wrapped in JSON)

- `dRuby`, just proxy parameters as they are;
- `Rack`, adapt `Request#params` and `Request#body`;
- `RabbitMQ` (Bunny), adapt JSON payload.

So when my new app will require one of those above, I will just copy my previous code for this "tech", all concepts except of particular presenters. For a new one I will "punch" the face skeleton and work on adopting the "tech" and proxying request to the domain.

## Plugins

It's important to highlight here that up to this moment the development process was actually free from heavy dependencies like third-party servers, "Sun are shinning and the cotton is high"

All plugin interfaces are designed at the business logic layer, and its implementation was mocked and stubbed for test purpose. Now it is right time to implement required plugins.

For most of apps maybe the first plugin will be the data store. It might be plain files, SQL/NoSQL, Redis, etc.

> When one develops some sort of MVP, one should rather go for the simples possible plugin implementation that and serves the purpose and skimp resources. In the case of the data store it might be just in-memory store, maybe even with just few collections preloaded

For this stage I'll implement and test required plugins. Again when one have plugin interface first, one can develop shared tests based on the interface that will serves for all possible plugin implementation. And again, when you have implemented some "tech" plugin implementation once, you can use it for other apps.

> If you start from "tech" data layer like particular SQL/NoSQL solution, it will enslave your domain by particular data store tech and spoil design. But the much worse thing is to play on both "face" and data store "tech" at a time - it straight way to "thick controller vs thick model" and "N+1  query" problems.

## Integration

When all plugins implemented your app is almost done but yet requires integration testing... At this stage I usually design some simple client script that plays domain actor connecting to the app and requesting its services.

## Links

- [A Little Architecture](https://blog.cleancoder.com/uncle-bob/2016/01/04/ALittleArchitecture.html)
- [The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
