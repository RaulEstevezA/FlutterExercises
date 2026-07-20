import 'package:flutter/material.dart';
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
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Nombre de usuario',
            onChanged: (value) => username = value,
          ),

          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Correo electrónico',
            onChanged: (value) => email = value,
          ),

          SizedBox(height: 10),
          CustomTextFormField(
            label: 'Contraseña',
            onChanged: (value) => password = value,
            obscureText: true,
          ),


          FilledButton.tonalIcon(
            onPressed: (){}, 
            icon: const Icon(Icons.save),
            label: const Text('Crear usuario'),
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}