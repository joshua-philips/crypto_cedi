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

  @override
  void initState() {
    super.initState();
    getCryptos();
  }

  getCryptos() async {
    String cryptoUrl =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false';
    Response response = await Dio().get(cryptoUrl);
    List results = response.data;

    results.forEach((element) {
      cryptos.add(Cryptocurrency.fromJson(element));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppBar(
        height: 150,
        controller: searchController,
      ),
    );
  }
}
