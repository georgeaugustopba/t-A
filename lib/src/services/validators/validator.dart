import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu email!';
  }
  if (!email.isEmail) {
    return 'Digite um email valido';
  }
  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Digite sua senha';
  }
  if (password.length < 6) {
    return 'Digite uma senha maior que 6 dígitos';
  }
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite seu nome';
  }

  final names = name.split(' ');
  if (names.length == 1) return 'Digite um nome e sobrenome';
  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite um número de Celular';
  }
  if (phone.length < 14 || !phone.isPhoneNumber) {
    return 'Digite um número válido!';
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite um número de Cpf';
  }
  if (!cpf.isCpf) return 'Digite um cpf válido!';
  return null;
}
