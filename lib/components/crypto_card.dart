import 'package:crypto_cedi/models/cryptocurrency.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final Cryptocurrency cryptocurrency;
  final double cediExchangeRate;

  const CryptoCard({Key key, this.cryptocurrency, this.cediExchangeRate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 8, right: 16),
          leading: CircleAvatar(
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
