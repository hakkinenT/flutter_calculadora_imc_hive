class IMC {
  final int? id;
  final double? peso;
  final double? altura;
  final String? classificacao;

  const IMC({this.id, this.peso, this.altura, this.classificacao});

  factory IMC.fromJson(Map<String, dynamic> json) {
    return IMC(
      id: json['id'],
      peso: json['peso'],
      altura: json['altura'],
      classificacao: json['classificacao'],
    );
  }

  IMC copyWith({int? id, double? peso, double? altura, String? classificacao}) {
    return IMC(
      id: id ?? this.id,
      peso: peso ?? this.peso,
      altura: altura ?? this.altura,
      classificacao: classificacao ?? this.classificacao,
    );
  }
}
