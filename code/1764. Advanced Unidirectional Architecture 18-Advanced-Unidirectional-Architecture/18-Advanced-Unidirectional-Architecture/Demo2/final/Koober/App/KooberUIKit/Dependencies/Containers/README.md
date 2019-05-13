#  Dependency Injection

Koober's dependency containers are handwritten and do not depend on any third party library. While this means there is more boiler plate code, it also means that the dependency resolutions are type safe and do not require any force unwraps. Also by handwriting the registrations, any missing dependencies will be caught at compile time rather than runtime.

Koober uses a hierarchy of containers to resolve dependencies. Each container is scoped, that is, each container has a different lifespan. For example, the root container named 'EntryPointAppDependencyContainer', lives as long as the application's process is running. A counter example, the 'SignedInAppDependencyContainer' only lives as long as a user is signed in. Once a user signs out, the current signed in container gets deallocated.

The rules for building a hierarchy of containers are:

- A child container must live no longer than it's parent, the root container lives the longest
- A child container can look up a dependency from it's parent, but a parent container cannot resolve depdencies registered in a child container (because the child has a shorter lifespan and may not be in memory)

Koober has three containers, 'EntryPointAppDependencyContainer', 'OnboardingAppDependencyContainer', and 'SignedInAppDependencyContainer'. The entry point container is always alive. The onboarding container is alive when a user is signed out, and the signed in container lives while a user is signed in.

If you look at the class definitions of these containers you'll notice two things. One, the containers conform to a provider prototcol. And two, the containers inherit from another container class. The protocol is there so you can switch out the implementation of the container for example when running unit tests (and you want to use fake implementations for dependencies like networking).




