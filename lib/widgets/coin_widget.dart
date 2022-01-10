import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_app/formatters/price_format.dart';
import 'package:crypto_app/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinWidget extends StatelessWidget {
  final Coin coin;

  const CoinWidget(this.coin, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        dense: true,
        title: Text('${coin.name} (${coin.symbol.toUpperCase()})'),
        subtitle: Text(PriceFormat()(coin.marketCap)),
        leading: CachedNetworkImage(
          imageUrl: coin.image,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(PriceFormat()(coin.currentPrice)),
            if (coin.priceChangePercentage24h != null)
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                    NumberFormat.decimalPercentPattern(decimalDigits: 2)
                        .format(coin.priceChangePercentage24h! / 100),
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        color: coin.priceChangePercentage24h! > 0
                            ? Colors.green[800]
                            : coin.priceChangePercentage24h! < 0
                                ? Colors.red[800]
                                : null)),
              ),
          ],
        ),
      );
}
