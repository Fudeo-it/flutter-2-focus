import 'package:crypto_app/models/coin.dart';
import 'package:crypto_app/network/rest_client.dart';

class CoinRepository {
  final RestClient restClient;

  CoinRepository({required this.restClient});

  Future<List<Coin>> get coins => restClient.coins();
}