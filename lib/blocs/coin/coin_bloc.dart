import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app/models/coin.dart';
import 'package:crypto_app/repositories/coin_repository.dart';
import 'package:equatable/equatable.dart';

part 'coin_event.dart';
part 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {

  final CoinRepository coinRepository;

  CoinBloc({required this.coinRepository}) : super(FetchingCoinsState()) {
    on<FetchCoinEvent>((event, emit) async {
      emit(FetchingCoinsState());

      try {
        final coins = await coinRepository.coins;

        emit(coins.isEmpty ? NoCoinsState() : FetchedCoinsState(coins));
      } catch (e) {
        emit(ErrorCoinsState());
      }
    });
  }

  void fetchCoins() => add(FetchCoinEvent());
}
