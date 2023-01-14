import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/pages/auth/controller/auth_controller.dart';
import 'package:lojateamodas/src/pages/widgets/custom_text_field.dart';
import 'package:lojateamodas/src/services/validators/validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final cpfFormater = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  final phoneFormater = MaskTextInputFormatter(
    mask: '## # #### ####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  final _formkey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

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
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  //formulário
                  Align(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 800,
                      ),
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
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextField(
                                icon: Icons.email,
                                label: 'Email',
                                textInputType: TextInputType.emailAddress,
                                validator: emailValidator,
                                onSaved: (value) {
                                  authController.user.email = value;
                                },
                              ),
                              CustomTextField(
                                icon: Icons.lock,
                                label: 'Senha',
                                isSecret: true,
                                validator: passwordValidator,
                                onSaved: (value) {
                                  authController.user.password = value;
                                },
                              ),
                              CustomTextField(
                                icon: Icons.person,
                                label: 'Nome',
                                validator: nameValidator,
                                onSaved: (value) {
                                  authController.user.name = value;
                                },
                              ),
                              CustomTextField(
                                icon: Icons.phone,
                                label: 'Celular',
                                inputFormatters: [phoneFormater],
                                textInputType: TextInputType.phone,
                                validator: phoneValidator,
                                onSaved: (value) {
                                  authController.user.phone = value;
                                },
                              ),
                              CustomTextField(
                                icon: Icons.file_copy,
                                label: 'CPF',
                                inputFormatters: [cpfFormater],
                                textInputType: TextInputType.number,
                                validator: cpfValidator,
                                onSaved: (value) {
                                  authController.user.cpf = value;
                                },
                              ),
                              //botao cadastrar usuario
                              SizedBox(
                                height: 50,
                                child: Obx(() {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          18,
                                        ),
                                      ),
                                    ),
                                    onPressed: authController.isLoading.value
                                        ? null
                                        : () {
                                            FocusScope.of(context).unfocus();

                                            if (_formkey.currentState!
                                                .validate()) {
                                              _formkey.currentState!.save();
                                              //  print(authController.user);

                                              authController.signUp();
                                            }
                                          },
                                    child: authController.isLoading.value
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                            'Cadastrar Usuário',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
