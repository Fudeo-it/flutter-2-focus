import 'package:crypto_app/blocs/coin/coin_bloc.dart';
import 'package:crypto_app/models/coin.dart';
import 'package:crypto_app/repositories/coin_repository.dart';
import 'package:crypto_app/widgets/coin_widget.dart';
import 'package:crypto_app/widgets/shimmed_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Crypto App'),
          centerTitle: true,
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            context,
            connectivity,
            child,
          ) =>
              connectivity == ConnectivityResult.none
                  ? _notConnectedBody(context)
                  : child,
          child: _connectedBody(),
        ),
      );

  Widget _notConnectedBody(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off,
              color: Colors.grey,
              size: 128,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text(
                'Sei offline',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      );

  Widget _connectedBody() => BlocProvider(
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
      );

  Widget _coinsWidget({required List<Coin> coins}) => ListView.builder(
        itemBuilder: (context, index) => CoinWidget(coin: coins[index]),
        itemCount: coins.length,
      );

  Widget _noCoinsWidget() =>
      const Center(child: Text('Nessuna coin disponibile'));

  Widget _errorCoinsWidget() =>
      const Center(child: Text('Errore nell\'ottenere l\'elenco delle crypto'));

  Widget _fetchingCoinsWidget() => ShimmedList(child: CoinWidget.shimmed());
}
