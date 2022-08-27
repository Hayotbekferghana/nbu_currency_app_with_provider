import 'package:json_annotation/json_annotation.dart';

part 'nbu_data.g.dart';

@JsonSerializable()
class NbuData {
  @JsonKey(defaultValue: "", name: "title")
  String title;

  @JsonKey(defaultValue: "", name: "code")
  String code;

  @JsonKey(defaultValue: "", name: "cb_price")
  String cbPrice;

  @JsonKey(defaultValue: "", name: "nbu_buy_price")
  String nbuBuyPrice;

  @JsonKey(defaultValue: "", name: "nbu_cell_price")
  String nbuCellPrice;

  @JsonKey(defaultValue: "", name: "date")
  String date;

  NbuData({
    required this.title,
    required this.date,
    required this.cbPrice,
    required this.code,
    required this.nbuBuyPrice,
    required this.nbuCellPrice,
  });

  factory NbuData.fromJson(Map<String, dynamic> json) => _$NbuDataFromJson(json);

  Map<String, dynamic> toJson() => _$NbuDataToJson(this);

  @override
  String toString() => '''
      title: $title,
      code: $code,
      cb_price: $cbPrice,
      nbu_buy_price: $nbuBuyPrice,
      nbu_cell_price: $nbuCellPrice,
      date: $date,
      ''';
}
