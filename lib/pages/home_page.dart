import 'package:crypto_app/blocs/coin/coin_bloc.dart';
import 'package:crypto_app/models/coin.dart';
import 'package:crypto_app/repositories/coin_repository.dart';
import 'package:crypto_app/widgets/coin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Crypto App'),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (BuildContext context) => CoinBloc(
            coinRepository: context.read<CoinRepository>(),
          )..fetchCoins(),
          child: BlocBuilder<CoinBloc, CoinState>(builder: (context, state) {
            if (state is FetchedCoinsState) {
              return _coinsWidget(coins: state.coins);
            } else if (state is NoCoinsState) {
              return _noCoinsWidget();
            } else if (state is ErrorCoinsState) {
              return _errorCoinsWidget();
            } else if (state is FetchingCoinsState) {
              return _fetchingCoinsWidget();
            }

            return Container();
          }),
        ),
      );

  Widget _coinsWidget({required List<Coin> coins}) => ListView.builder(
    itemBuilder: (context, index) => CoinWidget(coins[index]),
    itemCount: coins.length,
  );

  Widget _noCoinsWidget() => const Center(child: Text('Nessuna coin disponibile'));

  Widget _errorCoinsWidget() =>
      const Center(child: Text('Errore nell\'ottenere l\'elenco delle crypto'));

  Widget _fetchingCoinsWidget() =>
      const Center(child: CircularProgressIndicator());
}
