import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/pages/auth/controller/auth_controller.dart';
import 'package:lojateamodas/src/pages/widgets/custom_text_field.dart';
import 'package:lojateamodas/src/services/validators/validator.dart';
// ignore: library_prefixes

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              Get.back();
            });
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            children: [
              CustomTextField(
                readOnly: true,
                initialValue: authController.user.email,
                icon: Icons.email,
                label: 'Email',
              ),

              //nome
              CustomTextField(
                readOnly: true,
                initialValue: authController.user.name,
                icon: Icons.person,
                label: 'Nome',
              ),
              //celular
              CustomTextField(
                readOnly: true,
                initialValue: authController.user.phone,
                icon: Icons.phone,
                label: 'Celular',
              ),
              //cpf
              CustomTextField(
                readOnly: true,
                initialValue: authController.user.cpf,
                icon: Icons.file_copy,
                label: 'CPF',
                isSecret: true,
              ),

              //botao atualizar a senha
              SizedBox(
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.pink,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () async {
                    await updatePassword();
                  },
                  child: const Text(
                    'Atualizar senha',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> updatePassword() {
    final newPasswordController = TextEditingController();
    final currentPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: Text(
                          'Atualização de Senha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //senha atual
                      CustomTextField(
                        controller: currentPasswordController,
                        isSecret: true,
                        icon: Icons.lock,
                        label: 'Senha Atual',
                        validator: passwordValidator,
                      ),
                      //nova senha
                      CustomTextField(
                        controller: newPasswordController,
                        isSecret: true,
                        icon: Icons.lock_outline,
                        label: 'Nova Senha',
                        validator: passwordValidator,
                      ),
                      //atualização nova senha
                      CustomTextField(
                        isSecret: true,
                        icon: Icons.lock_outline,
                        label: ' Confirmar Nova Senha',
                        validator: (password) {
                          final result = passwordValidator(password);
                          if (result != null) {
                            return result;
                          }
                          if (password != newPasswordController.text) {
                            return 'As senhas não sao equivalentes';
                          }
                          return null;
                        },
                      ),
                      //botao confirmação
                      SizedBox(
                        height: 45,
                        child: Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        authController.changePassword(
                                          currentPassword:
                                              currentPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                        );
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Atualizar',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
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
