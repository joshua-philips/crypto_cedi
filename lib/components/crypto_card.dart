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
      elevation: 0,
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '¢${(cryptocurrency.currentPrice * cediExchangeRate).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${(cryptocurrency.priceChangePercentage24h?.toStringAsFixed(2))} %',
                    style: TextStyle(
                      color: cryptocurrency.priceChangePercentage24h < 0
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  cryptocurrency.priceChangePercentage24h < 0
                      ? Icon(Icons.arrow_drop_down, color: Colors.red, size: 30)
                      : Icon(Icons.arrow_drop_up,
                          color: Colors.green, size: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
