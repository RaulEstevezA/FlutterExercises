# Widget App

A Flutter practice application created to explore many of the widgets, patterns, and tools commonly used in Flutter. The project works as a small interactive gallery: from the home screen you can open different sections that demonstrate buttons, cards, progress indicators, snackbars, dialogs, animations, form controls, tutorials, infinite scrolling, Riverpod, and theme switching.

The main goal of this project is not to build a production application, but to provide an organized learning playground for understanding how Flutter and Material 3 pieces behave.

## Demo

<p align="center">
  <a href="https://raw.githubusercontent.com/RaulEstevezA/FlutterExercises/main/flutter_first_steps/05_widget_app/demo.mp4">
    <img src="demo.png" alt="Widget App demo preview" width="320">
  </a>
</p>

## Technologies

- Flutter with Material 3.
- Dart.
- `go_router` for declarative navigation.
- `flutter_riverpod` for state management.
- `animate_do` for simple entrance animations.
- Local assets from `assets/images/`.
- Remote sample images from `picsum.photos`.

## Project Structure

```text
lib/
|-- config/
|   |-- menu/
|   |   `-- menu_items.dart
|   |-- router/
|   |   `-- app_router.dart
|   `-- theme/
|       `-- app_theme.dart
|-- presentation/
|   |-- providers/
|   |   |-- counter_provider.dart
|   |   `-- theme_provider.dart
|   |-- screens/
|   |   |-- animated/
|   |   |-- app_tutorial/
|   |   |-- bottons/
|   |   |-- cards/
|   |   |-- counter/
|   |   |-- home/
|   |   |-- infinite_scroll/
|   |   |-- progress/
|   |   |-- snackbar/
|   |   |-- theme_changer/
|   |   |-- ui_controls/
|   |   `-- screens.dart
|   `-- widgets/
|       `-- side_menu.dart
`-- main.dart
```

The app is organized around three main areas:

- `config`: shared configuration for routing, menu items, and theming.
- `presentation`: screens, reusable widgets, and Riverpod providers.
- `main.dart`: the application entry point.

## Entry Point

The application starts in `lib/main.dart`:

```dart
void main() {
  runApp(const ProviderScope(child: MainApp()));
}
```

`ProviderScope` is required so Riverpod providers can be used throughout the app. Inside `MainApp`, the app watches the current theme state:

```dart
final AppTheme appTheme = ref.watch(themeNotifierProvider);
```

Then it builds a `MaterialApp.router` with:

- `routerConfig: appRouter` to connect all app routes.
- `theme: appTheme.getTheme()` to apply the current theme.
- `debugShowCheckedModeBanner: false` to hide the debug banner.

## Navigation With GoRouter

Navigation is defined in `lib/config/router/app_router.dart`.

The app uses `GoRouter` with `/` as the initial route:

```dart
initialLocation: '/'
```

Each screen is registered with a `GoRoute`, for example:

```dart
GoRoute(
  path: "/buttons",
  name: ButtonsScreen.name,
  builder: (context, state) => const ButtonsScreen(),
)
```

This allows navigation with:

```dart
context.push('/buttons');
context.pop();
```

Available routes:

| Route | Screen | Purpose |
| --- | --- | --- |
| `/` | `HomeScreen` | Main screen |
| `/counter-river` | `CounterScreen` | Riverpod counter |
| `/buttons` | `ButtonsScreen` | Material buttons |
| `/cards` | `CardsScreen` | Cards with different styles |
| `/progress` | `ProgressScreen` | Progress indicators |
| `/snackbars` | `SnackbarScreen` | Snackbars, dialogs, and AboutDialog |
| `/animated` | `AnimatedScreen` | AnimatedContainer |
| `/ui-controls` | `UiControlsScreen` | Switches, radios, checkboxes, and tiles |
| `/tutorial` | `AppTutorialScreen` | PageView tutorial |
| `/infinite` | `InfiniteScrollScreen` | Infinite scroll and pull to refresh |
| `/theme-changer` | `ThemeChangerScreen` | Theme color and dark mode |

## App Menu

The file `lib/config/menu/menu_items.dart` defines the `appMenuItems` list.

Each menu item contains:

- `title`: visible title.
- `subTitle`: short description.
- `link`: navigation route.
- `icon`: Material icon.

This list is reused by:

- `HomeScreen`, to render the main list.
- `SideMenu`, to render the navigation drawer.

Because the menu data is centralized, adding a new section usually means registering a route and adding one new `MenuItems` entry.

## Theme System

The theme is defined in `lib/config/theme/app_theme.dart`.

The main class is `AppTheme`:

```dart
class AppTheme {
  final int selectedColor;
  final bool isDarkMode;
}
```

It stores two values:

- `selectedColor`: the active color index inside `colorList`.
- `isDarkMode`: whether the app is using light or dark mode.

`colorList` contains several Material colors:

```dart
const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
  Colors.yellow,
  Colors.yellowAccent,
  Colors.cyanAccent,
];
```

The `getTheme()` method converts the current app theme state into a real `ThemeData` object:

```dart
ThemeData getTheme() => ThemeData(
  useMaterial3: true,
  brightness: isDarkMode ? Brightness.dark : Brightness.light,
  colorSchemeSeed: colorList[selectedColor],
);
```

The app uses Material 3 and generates its color scheme from `colorSchemeSeed`.

`copyWith` creates a new `AppTheme` object while changing only the provided values:

```dart
AppTheme copyWith({
  int? selectedColor,
  bool? isDarkMode,
})
```

This is useful because the theme state is updated by replacing the object, not by mutating the existing one directly.

## Riverpod Providers

Providers are located in `lib/presentation/providers/`.

### Counter Provider

`counter_provider.dart` defines a simple integer counter:

```dart
final counterProvider = StateProvider<int>((ref) => 0);
```

This provider is used by `CounterScreen`.

### Theme Provider

`theme_provider.dart` contains several theme-related providers:

```dart
final isDarkModeProvider = StateProvider<bool>((ref) => false);
final colorListProvider = Provider((ref) => colorList);
final selectedColorProvider = StateProvider<int>((ref) => 0);
```

It also defines the main theme provider:

```dart
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);
```

`ThemeNotifier` controls a complete `AppTheme` object:

```dart
class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier(): super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
  }
}
```

This approach keeps the app theme as one state object that contains both the selected color and the dark mode flag.

## Main Screen

`HomeScreen` is located in `lib/presentation/screens/home/home_screen.dart`.

It is the visual entry point of the app. It uses:

- `Scaffold`.
- `AppBar`.
- `ListView.builder`.
- `ListTile`.
- `SideMenu`.

The screen reads `appMenuItems` and builds a list of options. When an option is tapped, it navigates with:

```dart
context.push(menuItem.link);
```

It also defines a `GlobalKey<ScaffoldState>` to control the navigation drawer.

## Side Menu

`SideMenu` is located in `lib/presentation/widgets/side_menu.dart`.

It is a `NavigationDrawer` that displays the same options as the main menu. It keeps the selected index locally with a `StatefulWidget`:

```dart
int navDraweIndex = 0;
```

When the user selects an option:

1. The selected index is updated.
2. The corresponding item is read from `appMenuItems`.
3. The app navigates with `context.push(menuItem.link)`.
4. The drawer is closed.

It also uses `MediaQuery` to adjust the top padding when the device has a notch.

## Screens

### CounterScreen

File: `lib/presentation/screens/counter/counter_screen.dart`.

This screen demonstrates Riverpod with a counter.

It watches the current counter value:

```dart
final clickCounter = ref.watch(counterProvider);
```

It increments the counter from the `FloatingActionButton`:

```dart
ref.read(counterProvider.notifier).state++;
```

It also has an `AppBar` button that toggles a boolean dark mode provider:

```dart
ref.read(isDarkModeProvider.notifier).update((state) => !state);
```

This screen is useful for practicing `ConsumerWidget`, `WidgetRef`, `watch`, `read`, and `StateProvider`.

### ButtonsScreen

File: `lib/presentation/screens/bottons/buttons_screen.dart`.

This screen displays different Material button types:

- `ElevatedButton`.
- `ElevatedButton.icon`.
- `FilledButton`.
- `FilledButton.icon`.
- `OutlinedButton`.
- `OutlinedButton.icon`.
- `TextButton`.
- `TextButton.icon`.
- `IconButton`.
- `FloatingActionButton`.
- A custom button built with `Material` and `InkWell`.

The screen uses `Wrap` so buttons automatically flow to the next line when they do not fit.

The custom `CustomButton` combines:

- `ClipRRect` for rounded corners.
- `Material` for the background color.
- `InkWell` for the ripple effect.
- `Padding` for internal spacing.

### CardsScreen

File: `lib/presentation/screens/cards/cards_screen.dart`.

This screen demonstrates different `Card` styles and elevation values.

The `cards` constant defines several elevation levels:

```dart
const cards = <Map<String,dynamic>>[
  {'elevation': 0.0, 'label': 'Elevation 0'},
  ...
];
```

The screen generates several groups of cards:

- `_CardType1`: basic card with elevation.
- `_CardType2`: card with border and rounded corners.
- `_CardType3`: filled card using colors from the current theme.
- `_CardType4`: image card using `Stack` for overlayed content.

It uses `SingleChildScrollView` to allow vertical scrolling.

### ProgressScreen

File: `lib/presentation/screens/progress/progress_screen.dart`.

This screen demonstrates progress indicators:

- Indeterminate `CircularProgressIndicator`.
- Controlled `CircularProgressIndicator`.
- Controlled `LinearProgressIndicator`.

The controlled progress example uses a `StreamBuilder` with `Stream.periodic`:

```dart
Stream.periodic(const Duration(milliseconds: 300), (value) {
  return (value * 2) / 100;
})
```

This simulates a progress value changing over time.

### SnackbarScreen

File: `lib/presentation/screens/snackbar/snackbar_screen.dart`.

This screen demonstrates user feedback components:

- `SnackBar`.
- `SnackBarAction`.
- `ScaffoldMessenger`.
- `AlertDialog`.
- `showDialog`.
- `showAboutDialog`.
- `FloatingActionButton.extended`.

Before showing a snackbar, the screen clears any previous snackbars:

```dart
ScaffoldMessenger.of(context).clearSnackBars();
```

Then it shows the new one:

```dart
ScaffoldMessenger.of(context).showSnackBar(snackBar);
```

The dialog is opened with `showDialog` and closed with `context.pop()`.

### AnimatedScreen

File: `lib/presentation/screens/animated/animated_screen.dart`.

This screen demonstrates `AnimatedContainer`.

The local state stores:

- `width`.
- `height`.
- `color`.
- `borderRadius`.

When the floating action button is pressed, `changeShape()` generates random values and calls `setState`.

`AnimatedContainer` detects those property changes and automatically animates between the old state and the new state:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 400),
  curve: Curves.elasticOut,
)
```

This is a clear example of implicit animation in Flutter.

### UiControlsScreen

File: `lib/presentation/screens/ui_controls/ui_controls_screen.dart`.

This screen demonstrates common form and selection controls:

- `SwitchListTile`.
- `ExpansionTile`.
- `RadioGroup`.
- `RadioListTile`.
- `CheckboxListTile`.
- `ListView`.
- `ClampingScrollPhysics`.

It also defines an enum:

```dart
enum Transportation { car, plane, boat, submarine }
```

The local state stores:

- Whether developer mode is enabled.
- The selected transportation option.
- Whether breakfast, lunch, or dinner is selected.

Each control updates the local state with `setState`.

### AppTutorialScreen

File: `lib/presentation/screens/app_tutorial/app_tutorial_screen.dart`.

This screen implements a small onboarding tutorial with multiple pages.

Each page is represented by `SlideInfo`:

```dart
class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;
}
```

The slides use local images:

- `assets/images/1.png`.
- `assets/images/2.png`.
- `assets/images/3.png`.

The screen uses:

- `PageView`.
- `PageController`.
- `BouncingScrollPhysics`.
- `Stack`.
- `Positioned`.
- `FadeInRight` from `animate_do`.

The `PageController` listens to the current page. When the user gets close to the end, it enables `endReached`, and the `Volver` button appears with an animation.

### InfiniteScrollScreen

File: `lib/presentation/screens/infinite_scroll/infinite_scroll_screen.dart`.

This screen demonstrates infinite scrolling, simulated loading, and pull to refresh.

The screen keeps:

- `imagesIds`: the list of image ids.
- `ScrollController`: the scroll controller.
- `isLoading`: whether a load operation is active.
- `isMounted`: used to avoid calling `setState` after leaving the screen.

In `initState`, the `ScrollController` listens to the current scroll position:

```dart
if ((scrollController.position.pixels + 500) >= scrollController.position.maxScrollExtent) {
  loadNextPage();
}
```

When the user gets close to the bottom, five more images are loaded after a simulated delay.

The screen also uses `RefreshIndicator` to refresh the list by pulling down.

Images are loaded with `FadeInImage`:

```dart
FadeInImage(
  placeholder: const AssetImage('assets/images/jar-loading.gif'),
  image: NetworkImage('https://picsum.photos/id/...'),
)
```

This displays a local loading GIF while the remote image is being fetched.

### ThemeChangerScreen

File: `lib/presentation/screens/theme_changer/theme_changer_screen.dart`.

This screen changes the global app theme.

It reads the current theme state with:

```dart
final isDark = ref.watch(themeNotifierProvider).isDarkMode;
```

The `AppBar` button toggles light and dark mode:

```dart
ref.read(themeNotifierProvider.notifier).toggleDarkMode();
```

The main view displays a `RadioListTile` for each color in `colorList`.

When a color is selected:

```dart
ref.watch(themeNotifierProvider.notifier).changeColorIndex(index);
```

This updates `selectedColor`, rebuilds the `ThemeData`, and changes the main color of the entire app.

## Screens Barrel File

`lib/presentation/screens/screens.dart` exports all screens:

```dart
export 'package:widget_app/presentation/screens/home/home_screen.dart';
```

This file works as a single import point. Because of it, `app_router.dart` can import all screens from one place:

```dart
import 'package:widget_app/presentation/screens/screens.dart';
```

## Assets

Assets are declared in `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
```

The folder contains:

- Tutorial images.
- The loading GIF used by the infinite scroll screen.

These assets must be declared in `pubspec.yaml` so Flutter can bundle and read them.

## Flutter Concepts Practiced

This app is useful for practicing:

- `StatelessWidget`.
- `StatefulWidget`.
- `ConsumerWidget`.
- `Scaffold`.
- `AppBar`.
- `Drawer` and `NavigationDrawer`.
- `ListView` and `ListView.builder`.
- `ListTile`.
- `Wrap`.
- Material buttons.
- `Card`.
- `Stack` and `Positioned`.
- `Image.network`, `AssetImage`, and `FadeInImage`.
- `SnackBar`, `AlertDialog`, and `AboutDialog`.
- `AnimatedContainer`.
- `PageView` and `PageController`.
- `ScrollController`.
- `RefreshIndicator`.
- `StreamBuilder`.
- `CircularProgressIndicator` and `LinearProgressIndicator`.
- `SwitchListTile`, `RadioListTile`, `CheckboxListTile`, and `ExpansionTile`.
- Themes with `ThemeData`, `ColorScheme`, and Material 3.
- Global state with Riverpod.
- Navigation with GoRouter.

## Running the Project

Install dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

Analyze the code:

```bash
flutter analyze
```

Run tests, if tests are added to the project:

```bash
flutter test
```

## Summary

`Widget App` is a learning application that explores a broad part of the basic Flutter ecosystem: visual widgets, navigation, state management, themes, animations, scrolling, dialogs, input controls, and image loading.

The most important idea in the project is that each screen works as an isolated example. This makes it easy to open one section, study a specific concept, and return to the main menu to try the next one.

## Navigation

- [Back to the repository overview](../../README_en.md)
