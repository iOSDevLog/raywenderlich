# Introduction to Leaf


Hey what's up everyone, it's Tim here. In the previous section we learnt how to use Fluent and Vapor to create a powerful server application that could act as an API to help me translate all the weird acronyms my sister messages me with! As it got more and more popular we learnt how to leverage Fluent to provide powerful features such as search and relationships.

[Slide 1]

In this section we are going to build upon the application we have made to make it even more powerful. Currently people can use our application via the API with something like an iOS app, but we are getting more and more requests from people who are trying to use it from a browser! So we are going to build a website for our application so that users can view our acronyms and use our application in their browsers. 

[Slide 2]

To do this we are going to learn how to use Leaf to generate HTML from templates and avoid duplicating code. We will also learn how to serve up static files and integrate our application with Bootstrap so that our web application looks nice!

[Slide 3]

Before we get started let's take a quick look at Leaf. Leaf is Vapor's templating language for generating HTML (and any other text based formats). With an application such as ours, we don't know what all the pages are going to look like up front since we don't know what acronyms our users are going to add to it. 

[Slide 4]

Obviously this means that we can't create a static HTML page for each acronym - we want to generate them dynamically and Leaf allows us to do this. So for instance we can have a generic acronym template and Leaf will insert the different parts of an acronym into the template so it appears as each acronym has its own page. 

[Slide 5]

We may also want to be able to only display a certain part of a page if a condition is met - for instance we may not want to display a list of categories on an acronym page if there are no categories for that acronym! Leaf allows us to use expressions and control blocks to be able to do this.

[Slide 6]

Finally it is probable that all of our pages will have similar parts - for instance that header and footer of each page are likely to be the same no matter whether we are viewing acronyms or viewing categories. If we want to change the header we would have to go through each template and change the same bit of code, which isn't a good idea. Leaf allows us to embed templates into other templates so we can have a single 'header' template that is common across all pages - if we want to change the header then we only have to change it in one place. Let's get stuck in.
