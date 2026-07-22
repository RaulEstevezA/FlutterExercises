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
      body: _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

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

    final registerCubit = context.watch<RegisterCubit>;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Nombre de usuario',
            onChanged: (value) => username = value,
            validator: (value){
              if (value == null || value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Mas de 6 letras';
              return null;
            },
          ),

          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Correo electrónico',
            onChanged: (value) => email = value,
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
            onChanged: (value) => password = value,
            obscureText: true,
            validator: (value){
              if (value == null || value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Mas de 6 caracteres';
              return null;
            },
          ),


          FilledButton.tonalIcon(
            onPressed: (){
              final isValid = _formKey.currentState!.validate();
              if (isValid) return;
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