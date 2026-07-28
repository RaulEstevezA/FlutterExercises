import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child:  _RegisterView(),
        ),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const FlutterLogo(size: 100),

              const _RegisterFormn(),
      
            ],
          ),
        ),
      ),
    );
  }
}


class _RegisterFormn extends StatefulWidget {
  const _RegisterFormn();

  @override
  State<_RegisterFormn> createState() => _RegisterFormnState();
}

class _RegisterFormnState extends State<_RegisterFormn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;


    return Form(
      child: Column(
        children: [
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Nombre de usuario',
            onChanged: registerCubit.usernameChanged,
            errorMessage: username.errorMessage,
            // errorMessage: username.isPure || username.isValid
            //   ? null
            //   : 'Usuario no válido',
          ),

          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Correo electrónico',
            onChanged: (value) {
              _formKey.currentState?.validate();
            },
            validator: (value){
              if (value == null || value.trim().isEmpty) return 'Campo requerido';
              final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',);
              if (!emailRegExp.hasMatch(value)) return 'No tiene formato requerido';
              return null;
            },
          ),

          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: registerCubit.passwordChanged,
            errorMessage: password.errorMessage,
            // onChanged: (value) {
            //   _formKey.currentState?.validate();
            // },
            
            // validator: (value){
            //   if (value == null || value.trim().isEmpty) return 'Campo requerido';
            //   if (value.length < 6) return 'Mas de 6 caracteres';
            //   return null;
            // },
          ),


          FilledButton.tonalIcon(
            onPressed: (){
              registerCubit.onSubmit();
            }, 
            icon: const Icon(Icons.save),
            label: const Text('Crear usuario'),
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}