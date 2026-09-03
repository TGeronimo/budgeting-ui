import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/dio/dio_client.dart';
import 'package:flutter_app_test/features/auth/dto/user_register_dto.dart';
import 'package:flutter_app_test/features/auth/services/auth_service.dart';

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
  
  late DioClient dioClient;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    dioClient = DioClient();
    authService = AuthService(dioClient.dio);
  }

  @override
  Widget build(BuildContext context) {

  return Scaffold(
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            child: AnimatedContainer(
              color: const Color.fromARGB(255, 161, 195, 246).withValues(alpha: 0.8),
              duration: const Duration(milliseconds: 200),
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Cadastro",
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
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
                              return 'A senha deve ter pelo menos 12 caracteres.';
                            }
                            if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                              return 'A senha deve ter pelo menos um símbolo.';
                            }
                            if (!RegExp(r'[0-9]').hasMatch(value)) {
                              return 'A senha deve ter pelo menos um número.';
                            }
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return 'A senha deve ter pelo menos uma letra maiúscula.';
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

                              final dto = UserRegisterDto(
                                email: email,
                                password: password
                              );

                              try {
                                // TODO storage of user data to future login
                                final user = await authService.register(dto);
                                Navigator.pushNamed(context, '/menu_page');
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content:
                                    Text('Erro ao registrar: $e')
                                    )
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: Colors.blueAccent,
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
                          child: const Text('Já tenho conta. Fazer log-in.'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
  }
}