part of 'coin_bloc.dart';

abstract class CoinState extends Equatable {
  const CoinState();

  @override
  List<Object> get props => [];
}

class FetchingCoinsState extends CoinState {
  
}

class NoCoinsState extends CoinState {}

class ErrorCoinsState extends CoinState {}

class FetchedCoinsState extends CoinState {
  final List<Coin> coins;

  const FetchedCoinsState(this.coins);

  @override
  List<Object> get props => [coins];
}
