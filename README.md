# Architecture


### Brief description of hexagonal architecture

The project was made using hexagonal architecture, which has the followings characteristics:

- division of responsibilities by layers
- uncoupled layers
- Use Of input ports to connect the UI to output Ports, like a repository to fetch data from a database
 
## UI

Each Screen of the app, is created inside of a module directory, containing its name and inside of a UI folder.

Ex: 

- lib
  -  modules
      -  login
         - ui 
           - login_screen.dart
          

### Navigation

We separate the navigation in 2 parts, the direction and route of that particular screen. Note: If some module has more than a screen, you should create a route and a direction for that one.

### Directions

direction is the file responsible for where the screen are able to go

I'll use the login module we used above for this example:

- login
  - directions
    - login_screen_directions.dart 

So, in login_screen_directions.dart file, we'll have:

```
class LoginScreenDirections extends ScreenDirection {
  LoginScreenDirections(LoginScreen screen) : super(screen);

  void goToHome() {
    AppNavigator.pushReplacement(HomeRoute.of());
  }
}
```
    

 I'll explain what that HomeRoute does later. Pay close attention that LoginScreenDirections is extending of ScreenDirection, which is simply an abstract class to inform the screen to use this direction file, in this case, we are only admiting the login screen to use this LoginScreenDirection file.
 
 inside goToHome method, we are using AppNavigator to navigate to another screen. AppNavigator is our own custom navigator that we can use without passing the context
 
 
 #### How To Use a Screen Direction?
 
 In your UI file (I'll use the Login Screen for this example):
 
 ```
void _goToHome() {
  LoginScreenDirections(this).goToHome();
}
 
```
 When we called LoginScreenDirections, we passed "this" as a parameter. It means that we're passing the LoginScreen.
 
 ### Route
 
 The Route file is responsible for loading what the screen needs to render. Example, the User model data.
 
 Example of where it is located at:
 
 - login
    - route
      - login_route.dart 

login_route.dart file will look like:

```
import 'package:flutter/widgets.dart';
import 'package:taplingo_matrix/core/routes/navigation_route.dart';
import 'package:taplingo_matrix/core/routes/route_transition.dart';
import 'package:taplingo_matrix/modules/login/ui/login_screen.dart';

class LoginRoute extends NavigationRoute {
  static String path = "/login";

  LoginRoute._(Route<Object> route)
      : super(
          path,
          route,
          fullScreen: true,
        );

  static LoginRoute of({
    Duration? transitionDuration,
    RouteTransitionsBuilder? transitionsBuilder,
    bool animated = true,
  }) {
  // If LoginScreen needed something to load, it would be passed right here
    const LoginScreen _screen = LoginScreen();

    if (animated) {
      return LoginRoute._(
        PageRouteBuilder(
          settings: RouteSettings(name: path),
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              _screen,
          transitionDuration:
              transitionDuration ?? RouteTransitions.DEFAULT_DURATION,
          transitionsBuilder:
              transitionsBuilder ?? RouteTransitions.DEFAULT_TRANSITION,
        ),
      );
    }

    return LoginRoute._(
      PageRouteBuilder(
        settings: RouteSettings(name: path),
        pageBuilder: (
          context,
          animation,
          secondaryAnimation,
        ) =>
            _screen,
      ),
    );
  }
}

 
```
 
 ### How to use a route?
 
 Remember the LoginScreenDirection code that we saw earlier?

```
class LoginScreenDirections extends ScreenDirection {
  LoginScreenDirections(LoginScreen screen) : super(screen);

  void goToHome() {
    AppNavigator.pushReplacement(HomeRoute.of());
  }
}
```

This is how we use a route... in this case, we are in the login screen and we're going to home, so we're using HomeRoute.of().

On this static "of" method of HomeRoute, it is initializing the LoginScreen before it is rendered


## Output Ports

Output Ports works as an abstract class to tell a repository which method it has to implement to.

The repository will implement as many output port as it needs

## Input Ports
 
 The idea of a input port is to make a bridge into layer A to layer B. For instance:
 
 Layer A is a screen that wants to know the current user information.
 
 Layer B is the UserRepository that will have a method to fetch current user data.
 
 Note that a screen doesn't call directly a Repository.
 
 ## Use Case
 
 UseCase will work as a business logic layer before passing the data to a repository.
 
 a UseCase implements an input port, so when we are calling an input port in a screen, we could say that represents a useCase.
 
 a useCase will probably looks like:
 
 
 ```
class FetchCurrentUserUseCase implements FetchCurrentUserInputPort {
  const FetchCurrentUserUseCase(this._outputPort);

  final FetchCurrentUserOutputPort _outputPort;

  @override
  Stream<List<Onboarding>> fetchOnboarding() {
    return _outputPort.fetchOnboarding();
  }
}
```
 
 
 it has an outputPort property inside, which represents a repository that is implementing that particular outputPort.
 
 
 ## How Can I Load An Input Port In a Screen?
 
 Since we use dependency injection, we must use get it to help us locating it.
 
 So, let's say we are in Home Screen and we have the FetchCurrentUserInputPort. In the HomeRoute, we would get this information doing it:
 
 ```
 final screen = HomeScreen(
  fetchCurrentUserInputPort: ServiceLocatorConfig.provide(),
 );
 ```
 this ServiceLocatorConfig.provide() returns for us a GetIt instance. And getting the information that we need.
 
 
 ## Ok, I Understand that... but how can a input port represents an usecase?
 
 well, we have a Module File  on this project that binds an input port with a use case and an output port with a repository.
 
 It looks like this:
 
 ```
 @module
abstract class OnboardingCoreModule {
  @singleton
  FetchOnboardingInputPort fetchOnboardingInputPort(
    FetchOnboardingUseCase useCase,
  ) =>
      useCase;

  @singleton
  FetchOnboardingOutputPort fetchOnboardingOutputPort(
    OnboardingRepository repository,
  ) =>
      repository;
}
 ```
 
 doing it and after you generate the command to generate .g, it will modify the service_locator_config.config.dart file. This file binds every port in the project automatically

 ## Good To Know
 - Always use Stream instead a Future
 - To convert a Stream into a Future, use Stream.fromFuture() instead of "as stream"
 
 