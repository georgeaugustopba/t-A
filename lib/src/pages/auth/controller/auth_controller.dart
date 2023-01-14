import 'package:get/get.dart';
import 'package:lojateamodas/src/constants/keys/storage_key.dart';
import 'package:lojateamodas/src/models/user/user_model.dart';
import 'package:lojateamodas/src/pages/auth/repository/auth_repository.dart';
import 'package:lojateamodas/src/pages/auth/result/auth_result.dart';
import 'package:lojateamodas/src/pages_route/app_pages.dart';
import 'package:lojateamodas/src/services/utils/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final utilServices = UtilsServices();
  final authRepository = AuthRepository();

  UserModel user = UserModel();
  // Adress adress = Adress();

  //bool get adminEnable => user.adm = true;

  Future<void> validateToken() async {
    //recurar o token salvo localmente
    String? token = await utilServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }
    //validando
    AuthResult result = await authRepository.validateToken(token);
    result.when(
      success: (user) {
        this.user = user;

        saveTokenProccedTobase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;
    final result = await authRepository.changePassword(
      email: user.email!,
      currentPassword: currentPassword,
      newPassword: newPassword,
      token: user.token!,
    );
    isLoading.value = false;
    if (result) {
      utilServices.showToast(
        message: 'A Senha foi atualizada com sucesso!',
      );
      signOut();
    } else {
      utilServices.showToast(
        message: 'A Senha atual está incorreta',
        isError: true,
      );
    }
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await authRepository.signUp(user);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenProccedTobase();
      },
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result = await authRepository.signIn(
      email: email,
      password: password,
    );
    // print(result.user.cpf);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenProccedTobase();
        //  print(user.cpf);
      },
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true,
        );

        //print(message);
      },
    );
  }

  // void setCpf(String cpf) {
  //   user.cpf = cpf;
  //   update();
  // }

  //método resetar password
  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }

  Future<void> signOut() async {
    //Zerar o user
    user = UserModel();

    //remover o token localmente
    await utilServices.removeLocalData(key: StorageKeys.token);

    //Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  void saveTokenProccedTobase() {
    //salvar o token
    utilServices.saveLocalData(
      key: StorageKeys.token,
      data: user.token!,
    );

    //Ir para a base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }
}
