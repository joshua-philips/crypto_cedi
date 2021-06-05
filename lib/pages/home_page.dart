import 'package:crypto_cedi/components/crypto_card.dart';
import 'package:crypto_cedi/models/cryptocurrency.dart';
import 'package:crypto_cedi/components/homepage_appbar.dart';
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
  bool dataError = false;

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchCryptos);
    loadData();
  }

  @override
  void dispose() {
    searchController.removeListener(searchCryptos);
    searchController.dispose();
    super.dispose();
  }

  void searchCryptos() {
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

  /// Load the cryptos from api
  Future getCryptos() async {
    // TODO: Get more pages from api
    String cryptoUrl =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false';
    Response response = await Dio().get(cryptoUrl);
    List results = response.data;

    setState(() {
      results.forEach((element) {
        cryptos.add(Cryptocurrency.fromJson(element));
      });

      searchResults.addAll(cryptos);
    });
  }

  /// Load cedi exchange rate from api
  Future getExchangeRate() async {
    String exchangeUrl =
        'https://api.exchangerate.host/convert?from=USD&to=GHS';
    Response response = await Dio().get(exchangeUrl);
    Map responseData = response.data;
    setState(() {
      cediExchangeRate = responseData['info']['rate'].toDouble();
    });
  }

  /// Load all data or catch error
  Future loadData() async {
    try {
      await getExchangeRate();
      await getCryptos();
    } catch (e) {
      setState(() {
        dataError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppBar(
        height: 101,
        controller: searchController,
      ),
      body: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: setBody()),
    );
  }

  Widget setBody() {
    if (cryptos.length > 0) {
      return RefreshIndicator(
        onRefresh: loadData,
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
    } else if (dataError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor),
              child: Text(
                'Reload',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              onPressed: () {
                loadData();
              },
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
