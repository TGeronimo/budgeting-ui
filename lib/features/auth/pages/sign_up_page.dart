import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/dio/dio_client.dart';
import 'package:flutter_app_test/features/auth/dto/user_register_dto.dart';
import 'package:flutter_app_test/features/auth/services/auth_service.dart';
import 'package:flutter_app_test/features/auth/services/token_storage.dart';
import 'package:flutter_app_test/shared/widgets/auth_form_header.dart';
import 'package:flutter_app_test/shared/widgets/auth_layout.dart';

class SignUpPage extends StatefulWidget {
  
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true; // define se o campo de senha fica obscurecido

  final _emailController = TextEditingController(); // captura o email
  final _passwordController = TextEditingController(); // captura a senha
  final _tokenStorage = TokenStorage();

  late DioClient dioClient;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    dioClient = DioClient(_tokenStorage);
    authService = AuthService(dioClient.dio);
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

  return AuthLayout(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthFormHeader(
                      infoText: 'Informe suas credenciais',
                      icon: Icons.person_add_alt_1_rounded,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe um e-mail.';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'E-mail inválido!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      labelText: 'Senha',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: _obscurePassword,
                    autofillHints: const [AutofillHints.newPassword],
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (value) {

                      if (value == null || value.isEmpty) {
                        return 'Informe uma senha.';
                      }
                      if (value.length < 12) {
                        return 'Mínimo de 12 caracteres.';
                      }
                      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Inclua um símbolo.';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Inclua um número.';
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'Inclua uma letra maiúscula.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        final registerDto = UserRegisterDto(
                            email: email,
                            password: password);

                        final loginDto = registerDto.toLoginDto();

                        try {
                          //TODO define what to do with id returned from the server.
                          final registerResponse = await authService.register(registerDto);
                          final loginResponse = await authService.login(loginDto);

                          await _tokenStorage.saveAccessToken(loginResponse.accessToken);
                          await _tokenStorage.saveRefreshToken(loginResponse.refreshToken);

                          Navigator.pushNamed(context, '/menu_page');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erro ao registrar: $e'),
                                duration: Duration(milliseconds: 2000),
                              )
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.blueAccent,
                      disabledBackgroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/log_in_page');
                    },
                    child: const Text('Já tem conta? Entre aqui.',
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
                                ),
          );
  }
}