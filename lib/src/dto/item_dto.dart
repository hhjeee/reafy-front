class ItemDto {
  final int itemId;
  bool activation;

  ItemDto({
    required this.itemId,
    required this.activation,
  });

  factory ItemDto.fromJson(Map<String, dynamic> json) {
    return ItemDto(
      itemId: json['itemId'] as int,
      activation: json['activation'] as bool,
    );
  }
}
