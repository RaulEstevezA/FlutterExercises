# forms_app

Flutter practice project that gathers different ways of managing application state, comparing **Cubit** and **BLoC**. Navigation between screens is handled with `go_router`.

## Screens

### Home
Main screen with access to the different examples:
- **Cubits**: simple state manager.
- **BLoC**: composite, event-based state manager.

### Counter with Cubit
Counter example using `CounterCubit`:
- Floating buttons (`+1`, `+2`, `+3`) that increase the counter by calling a Cubit method directly.
- The `AppBar` shows the number of transactions (increments) performed, using `context.select` to rebuild only that part of the UI.
- A refresh button in the `AppBar` resets the counter value (without resetting the transaction count).

### Counter with BLoC
Same example as above but implemented with `CounterBloc`, dispatching events (`CounterIncresed`, `CounterReset`) instead of calling methods directly on the state manager.

## Pending

- **Form with Cubit**: to be implemented.
- **Form with BLoC**: to be implemented.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
