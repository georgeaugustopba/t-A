import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/pages/auth/components/forgot_password_dialog.dart';
import 'package:lojateamodas/src/pages/auth/controller/auth_controller.dart';
import 'package:lojateamodas/src/pages/widgets/app_name_widget.dart';

import 'package:lojateamodas/src/pages/widgets/custom_text_field.dart';
import 'package:lojateamodas/src/pages_route/app_pages.dart';
import 'package:lojateamodas/src/services/utils/utils_services.dart';
import 'package:lojateamodas/src/services/validators/validator.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  //controlador campo texto

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorTheme = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: colorTheme,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //NOME DO APP
                    const AppNamedWidget(
                      teaTitleColor: Colors.black,
                      modasTitleColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    //categorias
                    SizedBox(
                      height: 40,
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width > 700 ? 30 : 22,
                          fontWeight: FontWeight.bold,
                        ),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Roupas Térmicas'),
                            FadeAnimatedText('Outono/Inverno '),
                            FadeAnimatedText('Blusas Femininas'),
                            FadeAnimatedText('Calças Térmicas'),
                            FadeAnimatedText('Primavera/Verão'),
                            FadeAnimatedText('Conjunto Térmico'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 800,
                  ),
                  //formulário
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //email
                          CustomTextField(
                            controller: emailController,
                            icon: Icons.email,
                            label: 'Email',
                            validator: emailValidator,
                          ),
                          //senha
                          CustomTextField(
                            controller: passwordController,
                            icon: Icons.lock,
                            label: 'Senha',
                            isSecret: true,
                            validator: passwordValidator,
                          ),
                          //botao de entrar
                          SizedBox(
                            height: 50,
                            child: GetX<AuthController>(
                              builder: (authController) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: authController.isLoading.value
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            String email = emailController.text;
                                            String password =
                                                passwordController.text;
                                            authController.signIn(
                                              email: email,
                                              password: password,
                                            );
                                          }
                                        },
                                  child: authController.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Entrar',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                          //esqueceu a senha
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  final bool? result = await showDialog(
                                    context: context,
                                    builder: (_) {
                                      return ForgotPasswordDialog(
                                        email: emailController.text,
                                      );
                                    },
                                  );

                                  if (result ?? false) {
                                    utilsServices.showToast(
                                      message:
                                          'Um link de verificação foi enviado para seu email',
                                    );
                                  }
                                },
                                child: Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                    color: colorTheme,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //divisor
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.withAlpha(90),
                                    thickness: 2,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Text('Ou'),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.withAlpha(90),
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //botao novo usuario
                          SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  side: const BorderSide(
                                    width: 2,
                                    color: Colors.pink,
                                  )),
                              onPressed: () {
                                Get.toNamed(PagesRoutes.signUpRoute);
                              },
                              child: const Text(
                                'Criar conta',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
