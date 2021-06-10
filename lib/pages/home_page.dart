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

  ScrollController _scrollController = ScrollController();

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
    _scrollController.dispose();
    super.dispose();
  }

  /// Triggered when user presses back to top button
  void scrollToTop() {
    _scrollController.animateTo(
      1,
      curve: Curves.linear,
      duration: Duration(seconds: 3),
    );
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
    List<Cryptocurrency> loaded = [];
    for (int count = 1; count < 9; count++) {
      String cryptoUrl =
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=$count&sparkline=false';
      Response response = await Dio().get(cryptoUrl);
      List results = response.data;
      results.forEach((element) {
        loaded.add(Cryptocurrency.fromJson(element));
      });
    }

    setState(() {
      cryptos.addAll(loaded);
      searchResults.addAll(loaded);
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
          height: 112,
          controller: searchController,
        ),
        body: setBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: scrollToTop,
          mini: true,
          child: Icon(
            Icons.arrow_upward,
          ),
        ));
  }

  Widget setBody() {
    if (cryptos.length > 0) {
      return RefreshIndicator(
        onRefresh: () async {
          cryptos.clear();
          searchResults.clear();
          await loadData();
        },
        child: Scrollbar(
          controller: _scrollController,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return CryptoCard(
                cediExchangeRate: cediExchangeRate,
                cryptocurrency: searchResults[index],
              );
            },
          ),
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
