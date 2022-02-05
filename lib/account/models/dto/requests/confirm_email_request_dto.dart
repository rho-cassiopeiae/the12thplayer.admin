class ConfirmEmailRequestDto {
  final String email;
  final String confirmationCode;

  ConfirmEmailRequestDto({
    required this.email,
    required this.confirmationCode,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map['email'] = email;
    map['confirmationCode'] = confirmationCode;

    return map;
  }
}
