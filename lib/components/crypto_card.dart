import 'dart:math';

import 'package:crypto_cedi/models/cryptocurrency.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final Cryptocurrency cryptocurrency;
  final double cediExchangeRate;

  CryptoCard({Key key, this.cryptocurrency, this.cediExchangeRate})
      : super(key: key);

  final List<Color> colors = [
    Colors.yellow,
    Colors.blue,
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    Random random = Random.secure();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 8, right: 16),
          leading: CircleAvatar(
            backgroundColor: colors[random.nextInt(colors.length)],
            foregroundImage: NetworkImage(cryptocurrency.image),
            radius: 35,
          ),
          title: Text(
            cryptocurrency.name,
          ),
          subtitle: Text(
            cryptocurrency.symbol.toUpperCase(),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¢${(cryptocurrency.currentPrice * cediExchangeRate).toStringAsFixed(2)}',
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(cryptocurrency.priceChangePercentage24h?.toStringAsFixed(2))} %',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
