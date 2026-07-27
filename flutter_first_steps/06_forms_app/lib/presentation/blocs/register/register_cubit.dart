import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:forms_app/infrastructure/inputs/inputs.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void usernameChanged (String value){
    emit(
      state.copyWith(
        username:value,
      )
    );
  }

  void emailChanged (String value){
    emit(
      state.copyWith(
        email: value,
      )
    );
  }

  void passwordChanged (String value){
    emit(
      state.copyWith(
        password: value,
      )
    );
  }
  
}
