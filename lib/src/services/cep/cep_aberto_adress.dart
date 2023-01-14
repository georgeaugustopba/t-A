class CepAbertoAddress {
  // final double altitude;
  final String cep;
  // final double latitude;
  // final double longitude;
  final String rua;
  final String bairro;
  final String cidade;
  final String estado;

  CepAbertoAddress.fromMap(Map<String, dynamic> map)
      : //altitude = map['ibge'] as double,
        cep = map['cep'] as String,
        //  latitude = map['gia'] as double,
        //  longitude = map['longitude'] as double,
        rua = map['logradouro'] as String,
        bairro = map['bairro'] as String,
        cidade = map['localidade'] as String,
        estado = map['uf'] as String;

  @override
  String toString() {
    return 'CepAbertoAddress{cep: $cep, logradouro: $rua, localidade: $bairro, localidade: $cidade, uf: $estado}';
  }
}
