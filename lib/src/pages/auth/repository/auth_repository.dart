import 'package:lojateamodas/src/constants/endpoints/endpoints.dart';
import 'package:lojateamodas/src/models/user/user_model.dart';
import 'package:lojateamodas/src/pages/auth/errors/auth_erros.dart'
    // ignore: library_prefixes
    as authErros;
import 'package:lojateamodas/src/pages/auth/result/auth_result.dart';
import 'package:lojateamodas/src/services/manager/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();
  // final authController = Get.find<AuthController>();

  AuthResult handleUserError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      // print('SigNin funcionou');
      final user = UserModel.fromJson(result['result']);

      return AuthResult.success(user);
    } else {
      return AuthResult.error(
        authErros.authErrorsString(result['error']),
      );
    }
  }

  Future<bool> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.changePassword,
        method: HttpMethods.post,
        body: {
          'email': email,
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
        headers: {
          'X-Parse-Session-Token': token,
        });

    return result['error'] == null;
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.validateToken,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
    );
    return handleUserError(result);
  }

  Future signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager
        .restRequest(url: Endpoints.signIn, method: HttpMethods.post, body: {
      "email": email,
      "password": password,
    });
    return handleUserError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signUp,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    return handleUserError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
      url: Endpoints.resetPassword,
      method: HttpMethods.post,
      body: {
        "email": email,
      },
    );
  }
}
