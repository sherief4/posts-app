<h1>Posts App</h1>

> This project is a simple application for the clean architecture in flutter as explained in this [playlist](https://www.youtube.com/playlist?list=PLwJ4sQ79Ehm69Bmed-XrRCc-_H1R3nWhd)

> This project is powered by FLutter **3.0.5** and dart **2.17.6**. And is built using [{JSON} Placeholder Api](https://jsonplaceholder.typicode.com/).

To select and install a specific version of flutter, I recommend using FVM: [fvm.app](https://fvm.app)

Bloc ( [ flutter_bloc ](https://pub.dev/packages/flutter_bloc) ) is used as an approach to state management. Bloc handles `Events` and changes `States`. Screens and Widgtes subscribe to Bloc changes and send events (for Cubit, this is a direct method call).



The main packages used in the project:

```yaml
  bloc: ^8.1.0 # for state management
  flutter_bloc: ^8.1.1 # for state management
  shared_preferences: ^2.0.15 # for caching data
  http: ^0.13.5 # for making http requests
  get_it: ^7.2.0 # for dependency injection
  internet_connection_checker: ^0.0.1+4 # for network avialability checking
  equatable: ^2.0.5  # for comparing  objects
  dartz: ^0.10.1 # for functional programming methods
```

### Table of Contents
1. [How to build & run](#build&run)
2. [Screenshots](#screenshots)


The minimum required set of commands

```bash
- flutter pub get # to get dependencies
- flutter pub run intl_utils:generate # to generate l10n.dart file from .arb localization files 
- flutter pub run build_runner build --delete-conflicting-outputs # to generate JsonSerializable models
```

To build and run the project, you can use `Android Studio` or `Visual Studio Code` with Flutter/Dart plugins (`Flutter Intl`, `Dart`, `Flutter`), then the commands above will be executed automatically when building and running.


To build from console:

```bash
 flutter build ios --release --no-codesign --flavor dev
 # or
 flutter build android --release --flavor dev
```

You can assemble the flutter part separately and run the application from native projects

To run from console:

```bash
flutter run ios -t lib/main.dart --no-codesign --flavor dev
# or
flutter run android -t lib/main.dart --flavor dev
```

``lib/main.dart`` - this is the main launch point of the project

``--flavor dev `` - this is the environment specification for dart + `flavor` in Android and `scheme` in iOS native projects


## Screenshots
<details>
<summary> See screenshots </summary>
<table>
  <tr>
    <td><img src = "https://github.com/sherief4/posts-app/blob/main/screenshots/1.jpg" width=202 height=405> </td>
    <td><img src = "https://github.com/sherief4/posts-app/blob/main/screenshots/2.jpg" width=202 height=405> </td>
    <td><img src = "https://github.com/sherief4/posts-app/blob/main/screenshots/3.jpg" width=202 height=405> </td>
    <td><img src = "https://github.com/sherief4/posts-app/blob/main/screenshots/7.jpg" width=202 height=405> </td>
 </tr>
 </table>
<table>
  <tr> 
    <td><img src = "https://github.com/sherief4/posts-app/blob/main/screenshots/4.jpg" width=202 height=405> </td>
    <td><img src = "https://github.com/sherief4/posts-app/blob/main/screenshots/5.jpg" width=202 height=405> </td>
    <td><img src = "https://github.com/sherief4/posts-app/blob/main/screenshots/6.jpg" width=202 height=405> </td>
    <td><img src = "https://github.com/sherief4/posts-app/blob/main/screenshots/8.jpg" width=202 height=405> </td>
 </tr>
 </table>
 <table>
  <tr> 
 
  </tr>
 </table>
</details>
