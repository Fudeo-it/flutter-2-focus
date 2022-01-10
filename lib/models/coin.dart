import 'package:json_annotation/json_annotation.dart';

part 'coin.g.dart';

@JsonSerializable(createToJson: false)
class Coin {
  final String id;
  final String symbol;
  final String name;
  final String image;

  @JsonKey(name: 'current_price')
  final double currentPrice;

  @JsonKey(name: 'market_cap')
  final int marketCap;

  @JsonKey(name: 'price_change_percentage_24h')
  final double? priceChangePercentage24h;

  Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    this.priceChangePercentage24h,
  });

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);
}
