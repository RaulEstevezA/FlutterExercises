# Forms App

A Flutter practice application built to compare two state management approaches, `Cubit` and `BLoC`, using the same counter example implemented twice, and then to apply that knowledge to a real-world scenario: a registration form validated with `Cubit` and `formz`.

The main goal of this project is not to build a production application, but to understand how Cubit and BLoC differ in practice, and how form validation can be modeled as state instead of being scattered across widget callbacks.

## Demo

<p align="center">
  <img src="images/forms_app.png" alt="Forms App demo preview" width="320">
  <img src="images/add_user.png" alt="Add User demo preview" width="320">
</p>

<p align="center">
  <a href="https://youtube.com/shorts/Ny5g1VSRP3w?feature=share">Demo video link</a>
</p>

## Technologies

- Flutter with Material 3.
- Dart.
- `flutter_bloc` for state management (`Cubit` and `Bloc`).
- `formz` for input validation modeling.
- `equatable` for value comparison in states.
- `go_router` for declarative navigation.

## Project Structure

```text
lib/
|-- config/
|   |-- router/
|   |   `-- app_router.dart
|   `-- theme/
|       `-- app_theme.dart
|-- infrastructure/
|   `-- inputs/
|       |-- email.dart
|       |-- inputs.dart
|       |-- password.dart
|       `-- username.dart
|-- presentation/
|   |-- blocs/
|   |   |-- counter_bloc/
|   |   |   |-- counter_bloc.dart
|   |   |   |-- counter_event.dart
|   |   |   `-- counter_state.dart
|   |   |-- counter_cubit/
|   |   |   |-- counter_cubit.dart
|   |   |   `-- counter_state.dart
|   |   `-- register/
|   |       |-- register_cubit.dart
|   |       `-- register_state.dart
|   |-- screens/
|   |   |-- block_counter_screen.dart
|   |   |-- cubit_counter_screen.dart
|   |   |-- home_screen.dart
|   |   |-- register_screen.dart
|   |   `-- screens.dart
|   `-- widgets/
|       |-- inputs/
|       |   `-- custom_text_form_field.dart
|       `-- widgets.dart
`-- main.dart
```

The app is organized around three main areas:

- `config`: shared configuration for routing and theming.
- `infrastructure/inputs`: `formz` input classes that encapsulate validation rules.
- `presentation`: blocs/cubits, screens, and reusable widgets.

## Entry Point

The application starts in `lib/main.dart`:

```dart
void main() {
  runApp(const MainApp());
}
```

`MainApp` builds a `MaterialApp.router` with:

- `routerConfig: appRouter` to connect all app routes.
- `theme: AppTheme().getTheme()` to apply the app theme.
- `debugShowCheckedModeBanner: false` to hide the debug banner.

## Navigation With GoRouter

Navigation is defined in `lib/config/router/app_router.dart` using `GoRouter`:

```dart
GoRoute(
  path: "/new-user",
  builder: (context, state) => const RegisterScreen()
)
```

Available routes:

| Route | Screen | Purpose |
| --- | --- | --- |
| `/` | `HomeScreen` | Main screen |
| `/cubits` | `CubitCounterScreen` | Counter managed with `Cubit` |
| `/counter-bloc` | `BlocCounterScreen` | Counter managed with `BLoC` |
| `/new-user` | `RegisterScreen` | Registration form validated with `Cubit` and `formz` |

## Theme

The theme is defined in `lib/config/theme/app_theme.dart`. `AppTheme.getTheme()` returns a Material 3 `ThemeData` generated from a single seed color:

```dart
ThemeData getTheme() {
  const seedColor = Colors.deepPurple;

  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seedColor,
    listTileTheme: const ListTileThemeData(iconColor: seedColor),
  );
}
```

## Main Screen

`HomeScreen` (`lib/presentation/screens/home_screen.dart`) is a `ListView` with three entries that push the other routes with `context.push(...)`: `Cubits`, `BLoC`, and `Nuevo usuario`, the last one separated from the counter examples with a `Divider`.

## Cubit vs BLoC: The Same Counter Twice

Both counter screens track two values: the current `counter` and a `transactionCount` that increases on every button press but is not reset when the counter is reset. Comparing the two implementations side by side is the core exercise of this part of the app.

### Counter With Cubit

Files: `lib/presentation/blocs/counter_cubit/` and `lib/presentation/screens/cubit_counter_screen.dart`.

`CounterCubit` exposes plain methods that emit a new state directly:

```dart
class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(counter: 0, transactionCount: 0));

  void intcreaseBy(int value) {
    emit(state.copyWith(
      counter: state.counter + value,
      transactionCount: state.transactionCount + 1,
    ));
  }

  void reset() {
    emit(state.copyWith(counter: 0));
  }
}
```

The UI calls these methods directly with `context.read<CounterCubit>().intcreaseBy(value)`. The `AppBar` title uses `context.select` so only that widget rebuilds when `transactionCount` changes:

```dart
title: context.select((CounterCubit value) {
  return Text('Cubit Counter: ${value.state.transactionCount}');
}),
```

The counter value itself is displayed with a `BlocBuilder<CounterCubit, CounterState>`.

### Counter With BLoC

Files: `lib/presentation/blocs/counter_bloc/` and `lib/presentation/screens/block_counter_screen.dart`.

`CounterBloc` reacts to events instead of exposing methods that mutate the state directly:

```dart
sealed class CounterEvent extends Equatable {
  const CounterEvent();
  @override
  List<Object> get props => [];
}

class CounterIncresed extends CounterEvent {
  final int value;
  const CounterIncresed({required this.value});
}

class CounterReset extends CounterEvent {}
```

```dart
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<CounterIncresed>(_onCounterIncrease);
    on<CounterReset>(_onCounterReset);
  }

  void _onCounterIncrease(CounterIncresed event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      counter: state.counter + event.value,
      transactionCount: state.transactionCount + 1,
    ));
  }
}
```

The UI dispatches events instead of calling methods:

```dart
context.read<CounterBloc>().add(CounterIncresed(value: value));
```

`CounterBloc` also keeps a pair of convenience methods (`increaseBy`, `resetCounter`) that internally `add` the same events, showing that a `Bloc` can still offer a method-based API on top of its event-driven core if needed.

Both the `AppBar` title and the counter value are read with `context.select`, so each widget only rebuilds when the specific field it depends on changes.

## Form Validation With Cubit and Formz

The registration flow (`/new-user`) shows how to model form validation as state using `formz`, instead of validating fields imperatively inside widget callbacks.

### Input Classes

Files in `lib/infrastructure/inputs/`: `username.dart`, `email.dart`, `password.dart`.

Each input extends `FormzInput<String, ErrorType>` and defines its own error enum and validation rules. For example, `Email`:

```dart
enum EmailError { empty, format }

class Email extends FormzInput<String, EmailError> {
  static final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  const Email.pure() : super.pure('');
  const Email.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == EmailError.empty) return 'El campo es requerido';
    if (displayError == EmailError.format) return 'No tiene formato de correo electrónico';
    return null;
  }

  @override
  EmailError? validator(String value) {
    if (value.trim().isEmpty) return EmailError.empty;
    if (!emailRegExp.hasMatch(value)) return EmailError.format;
    return null;
  }
}
```

`Username` and `Password` follow the same pattern: `.pure()` for the untouched field, `.dirty(value)` for a field the user has interacted with, a `validator` that returns the matching error (or `null`), and an `errorMessage` getter that turns that error into text only when the field is dirty and invalid. `Username` and `Password` both require a minimum of 6 characters; `Password` also masks its text in the UI.

All three classes are re-exported from `lib/infrastructure/inputs/inputs.dart` as a single import point.

### RegisterCubit and RegisterFormState

Files: `lib/presentation/blocs/register/register_cubit.dart` and `register_state.dart`.

`RegisterFormState` holds one `formz` input per field plus a `formStatus` and an `isValid` flag:

```dart
enum FormStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Username username;
  final Email email;
  final Password password;
  ...
}
```

`RegisterCubit` exposes one `Changed` method per field. Each one creates a new `.dirty` input, revalidates every field with `Formz.validate`, and emits the updated state:

```dart
void emailChanged(String value) {
  final email = Email.dirty(value);

  emit(state.copyWith(
    email: email,
    isValid: Formz.validate([email, state.password, state.username]),
  ));
}
```

`onSubmit()` marks every field as dirty (so validation errors show up even for fields the user never touched) and recomputes `isValid` in one step:

```dart
void onSubmit() {
  emit(state.copyWith(
    formStatus: FormStatus.validating,
    username: Username.dirty(state.username.value),
    password: Password.dirty(state.password.value),
    email: Email.dirty(state.email.value),
    isValid: Formz.validate([state.username, state.password, state.email]),
  ));
}
```

### RegisterScreen

File: `lib/presentation/screens/register_screen.dart`.

`RegisterScreen` provides a `RegisterCubit` with `BlocProvider` and reads it with `context.watch<RegisterCubit>()` inside `_RegisterFormnState`. Each `CustomTextFormField` is wired directly to the cubit:

```dart
CustomTextFormField(
  label: 'Correo electrónico',
  onChanged: registerCubit.emailChanged,
  errorMessage: email.errorMessage,
),
```

The `FilledButton.tonalIcon` at the bottom calls `registerCubit.onSubmit()`. Because every field listens to the same cubit, typing in one field can turn error messages on or off in the others as `isValid` is recalculated with the values of all three inputs together.

## Custom Widget: CustomTextFormField

File: `lib/presentation/widgets/inputs/custom_text_form_field.dart`.

A reusable `TextFormField` wrapper used by the registration form. It centralizes the rounded `OutlineInputBorder`, the focus/error border colors taken from the current `ColorScheme`, and exposes `label`, `hint`, `errorMessage`, `onChanged`, `validator`, and `obscureText` as simple parameters so screens do not repeat decoration code.

## Flutter Concepts Practiced

This app is useful for practicing:

- `Cubit` vs `Bloc`: method-based state changes vs event-driven state changes.
- `BlocProvider`, `BlocBuilder`, `context.read`, `context.watch`, and `context.select`.
- Selective widget rebuilds with `context.select` and `BlocBuilder`'s `buildWhen`.
- `Equatable` for value-based state comparison.
- `formz` for modeling form field validation as state (`pure`/`dirty`, custom error enums, `Formz.validate`).
- Composing several validated inputs into a single form state.
- Reusable form widgets with `TextFormField`.
- Navigation with GoRouter.
- Material 3 theming with `colorSchemeSeed`.

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

`Forms App` is a learning application focused on state management and form validation. The counter example is implemented twice, once with `Cubit` and once with `BLoC`, to compare their APIs side by side, while the registration screen builds on the same `Cubit` approach to show how `formz` can turn scattered field validation into a single, testable piece of state.

## Navigation

- [Back to the repository overview](../../README_en.md)
