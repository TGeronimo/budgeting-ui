import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/dio/dio_client.dart';
import 'package:flutter_app_test/features/auth/dto/login_dto.dart';
import 'package:flutter_app_test/features/auth/services/auth_service.dart';
import 'package:flutter_app_test/features/auth/services/token_storage.dart';

class LogInPage extends StatefulWidget {

  const LogInPage({super.key});

  @override
  State<StatefulWidget> createState() => _LogInPageState();

}

class _LogInPageState extends State<LogInPage> {
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
                          "Login",
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
                              return 'Informe seu e-mail.';
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
                          autofillHints: const [AutofillHints.password],
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe sua senha.';
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

                              final loginDto = LoginDto(
                                email: email,
                                password: password);

                              try {
                                final loginResponse = await authService.login(loginDto);
                                await _tokenStorage.saveToken(loginResponse.accessToken);
                                await _tokenStorage.saveRefreshToken(loginResponse.refreshToken);
                                Navigator.pushNamed(context, '/menu_page');
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Erro no log-in: $e'),
                                    duration: Duration(milliseconds: 2000),
                                    )
                                );                                
                              }

                              // TODO send user data to the back-end.
                              
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: const Text(
                            'Entrar',
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
                            Navigator.pushNamed(context, '/sign_up_page');
                          },
                          child: const Text('Não tem conta? Cadastrar.'),
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