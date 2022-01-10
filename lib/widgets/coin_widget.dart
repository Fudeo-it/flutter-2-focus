import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_app/formatters/price_format.dart';
import 'package:crypto_app/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinWidget extends StatelessWidget {
  final Coin? coin;

  const CoinWidget({Key? key, this.coin}) : super(key: key);

  factory CoinWidget.shimmed({Key? key}) => CoinWidget(coin: null, key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        dense: true,
        title: coin != null
            ? Text('${coin!.name} (${coin!.symbol.toUpperCase()})')
            : Container(
                height: 10,
                color: Colors.grey,
              ),
        subtitle: coin != null
            ? Text(PriceFormat()(coin!.marketCap))
            : Container(
                height: 10,
                color: Colors.grey,
              ),
        leading: coin != null
            ? CachedNetworkImage(
                imageUrl: coin!.image,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : Container(
                height: 50,
                width: 50,
                color: Colors.grey,
              ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            coin != null
                ? Text(PriceFormat()(coin!.currentPrice))
                : Container(
                    height: 10,
                    width: 50,
                    color: Colors.grey,
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: coin != null
                  ? Text(
                      NumberFormat.decimalPercentPattern(decimalDigits: 2)
                          .format(coin!.priceChangePercentage24h! / 100),
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color: coin!.priceChangePercentage24h! > 0
                              ? Colors.green[800]
                              : coin!.priceChangePercentage24h! < 0
                                  ? Colors.red[800]
                                  : null))
                  : Container(
                      height: 8,
                      width: 20,
                      color: Colors.grey,
                    ),
            ),
          ],
        ),
      );
}
