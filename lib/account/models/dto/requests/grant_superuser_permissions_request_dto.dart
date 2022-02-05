class GrantSuperuserPermissionsRequestDto {
  final String payload;
  final String signature;

  GrantSuperuserPermissionsRequestDto({
    required this.payload,
    required this.signature,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map['payload'] = payload;
    map['signature'] = signature;

    return map;
  }
}
