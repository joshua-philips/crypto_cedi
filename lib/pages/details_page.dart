import 'package:auto_size_text/auto_size_text.dart';
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
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 280,
              elevation: 0,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey[100]
                  : Colors.grey[850],
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: buildNameCard(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: buildPriceCard(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: buildHighLowCard(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: buildSupplyCard(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildNameCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    cryptocurrency.name,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Flexible(
                  child: Text(
                    'ID: ${cryptocurrency.id}',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Symbol: ${cryptocurrency.symbol}',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card buildPriceCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: AutoSizeText(
                    'Updated: ${DateFormat('dd/MMM/yyyy, h:mm').format(DateTime.tryParse(cryptocurrency.lastUpdated))}',
                    style: TextStyle(fontSize: 25),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: AutoSizeText(
                    'Current Price: ¢${NumberFormat(",000.00").format(cryptocurrency.currentPrice * cediExchangeRate)}',
                    style: TextStyle(fontSize: 25),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: AutoSizeText(
                    'Price Change: ¢${NumberFormat(",000.00").format(cryptocurrency.priceChange24h * cediExchangeRate)}',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '${(cryptocurrency.priceChangePercentage24h?.toStringAsFixed(2))}%',
                  style: TextStyle(
                    fontSize: 25,
                    color: (cryptocurrency.priceChangePercentage24h != null &&
                            cryptocurrency.priceChangePercentage24h < 0)
                        ? Colors.red
                        : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                (cryptocurrency.priceChangePercentage24h != null &&
                        cryptocurrency.priceChangePercentage24h < 0)
                    ? Icon(Icons.arrow_drop_down, color: Colors.red, size: 30)
                    : Icon(Icons.arrow_drop_up, color: Colors.green, size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card buildHighLowCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '24 Hour High: ¢${NumberFormat(",000.00").format(cryptocurrency.high24h * cediExchangeRate)}',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            Text(
              '24 Hour Low: ¢${NumberFormat(",000.00").format(cryptocurrency.low24h * cediExchangeRate)}',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }

  Card buildSupplyCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: AutoSizeText(
                    'Circulating Supply: ${cryptocurrency.circulatingSupply != null ? NumberFormat(",000").format(cryptocurrency.circulatingSupply?.floor()) : "not available"}',
                    maxLines: 1,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: AutoSizeText(
                    'Max Supply: ${cryptocurrency.maxSupply != null ? NumberFormat(",000").format(cryptocurrency.maxSupply?.floor()) : "not available"}',
                    maxLines: 1,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: AutoSizeText(
                    'Total Supply: ${cryptocurrency.totalSupply != null ? NumberFormat(",000").format(cryptocurrency.totalSupply?.floor()) : "not available"}',
                    style: TextStyle(fontSize: 25),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
