import 'package:crypto_cedi/models/cryptocurrency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  final Cryptocurrency cryptocurrency;
  final double cediExchangeRate;

  const DetailsPage({Key key, this.cryptocurrency, this.cediExchangeRate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 270,
              elevation: 0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Hero(
                  tag: cryptocurrency.symbol,
                  child: Image.network(
                    cryptocurrency.image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cryptocurrency.name,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        'Updated: ${DateFormat('dd/MMM/yyyy, h:mm').format(DateTime.tryParse(cryptocurrency.lastUpdated))}',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        'Current Price: ¢${(cryptocurrency.currentPrice * cediExchangeRate).toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        'Price Change: ¢${(cryptocurrency.priceChange24h * cediExchangeRate).toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 25),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${(cryptocurrency.priceChangePercentage24h?.toStringAsFixed(2))}%',
                            style: TextStyle(
                              fontSize: 25,
                              color: (cryptocurrency.priceChangePercentage24h !=
                                          null &&
                                      cryptocurrency.priceChangePercentage24h <
                                          0)
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
