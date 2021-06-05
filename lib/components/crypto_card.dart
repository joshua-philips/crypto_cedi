import 'dart:math';

import 'package:crypto_cedi/models/cryptocurrency.dart';
import 'package:crypto_cedi/pages/details_page.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final Cryptocurrency cryptocurrency;
  final double cediExchangeRate;

  CryptoCard({Key key, this.cryptocurrency, this.cediExchangeRate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.yellow,
      Colors.blue,
      Colors.black,
      Colors.red,
      Colors.orange,
      Colors.green,
      Colors.white,
      Theme.of(context).accentColor
    ];
    Random random = Random.secure();
    return GestureDetector(
      onTap: () {
        Route route = MaterialPageRoute(
            builder: (context) => DetailsPage(
                  cediExchangeRate: cediExchangeRate,
                  cryptocurrency: cryptocurrency,
                ));
        Navigator.push(context, route);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 8, right: 16),
            leading: Hero(
              tag: cryptocurrency.symbol,
              child: CircleAvatar(
                backgroundColor: colors[random.nextInt(colors.length)],
                foregroundImage: NetworkImage(cryptocurrency.image),
                radius: 35,
              ),
            ),
            title: Text(
              cryptocurrency.name,
            ),
            subtitle: Text(
              cryptocurrency.symbol.toUpperCase(),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 5),
                Text(
                  '¢${(cryptocurrency.currentPrice * cediExchangeRate).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${(cryptocurrency.priceChangePercentage24h?.toStringAsFixed(2))}%',
                      style: TextStyle(
                        color:
                            (cryptocurrency.priceChangePercentage24h != null &&
                                    cryptocurrency.priceChangePercentage24h < 0)
                                ? Colors.red
                                : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    (cryptocurrency.priceChangePercentage24h != null &&
                            cryptocurrency.priceChangePercentage24h < 0)
                        ? Icon(Icons.arrow_drop_down,
                            color: Colors.red, size: 30)
                        : Icon(Icons.arrow_drop_up,
                            color: Colors.green, size: 30),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
