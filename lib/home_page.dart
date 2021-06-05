import 'package:crypto_cedi/crypto_model.dart';
import 'package:crypto_cedi/homepage_appbar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<Cryptocurrency> cryptos = [];
  List<Cryptocurrency> searchResults = [];
  double cediExchangeRate = 0;
  Future gotData;

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchChanged);
    gotData = loadData();
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  onSearchChanged() {
    searchCryptos();
  }

  searchCryptos() {
    List<Cryptocurrency> showResults = [];
    if (searchController.text.isNotEmpty) {
      cryptos.forEach((element) {
        if (element.name
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            element.symbol.contains(searchController.text.toLowerCase())) {
          showResults.add(element);
        }
      });
    } else {
      showResults = List.from(cryptos);
    }

    setState(() {
      searchResults = showResults;
    });
  }

  getCryptos() async {
    String cryptoUrl =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false';
    Response response = await Dio().get(cryptoUrl);
    List results = response.data;

    results.forEach((element) {
      cryptos.add(Cryptocurrency.fromJson(element));
    });

    searchResults.addAll(cryptos);
  }

  getExchangeRate() async {
    String exchangeUrl =
        'https://api.exchangerate.host/convert?from=USD&to=GHS';
    Response response = await Dio().get(exchangeUrl);
    Map responseData = response.data;
    cediExchangeRate = responseData['info']['rate'].toDouble();
  }

  Future loadData() async {
    await getCryptos();
    await getExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppBar(
        height: 101,
        controller: searchController,
      ),
      body: FutureBuilder(
        future: gotData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: ListView.builder(
                  itemCount: searchResults.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CryptoCard(
                      cediExchangeRate: cediExchangeRate,
                      cryptocurrency: searchResults[index],
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text('Error'));
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

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
