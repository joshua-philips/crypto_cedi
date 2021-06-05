class Cryptocurrency {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  double marketCap;
  int marketCapRank;
  double fullyDilutedValuation;
  double totalVolume;
  double high24h;
  double low24h;
  double priceChange24h;
  double priceChangePercentage24h;
  double marketCapChange24h;
  double marketCapChangePercentage24h;
  double circulatingSupply;
  double totalSupply;
  double maxSupply;
  double ath;
  double athChangePercentage;
  String athDate;
  double atl;
  double atlChangePercentage;
  String atlDate;
  Map roi;
  String lastUpdated;

  Cryptocurrency(
      {this.id,
      this.symbol,
      this.name,
      this.image,
      this.currentPrice,
      this.marketCap,
      this.marketCapRank,
      this.fullyDilutedValuation,
      this.totalVolume,
      this.high24h,
      this.low24h,
      this.priceChange24h,
      this.priceChangePercentage24h,
      this.marketCapChange24h,
      this.marketCapChangePercentage24h,
      this.circulatingSupply,
      this.totalSupply,
      this.maxSupply,
      this.ath,
      this.athChangePercentage,
      this.athDate,
      this.atl,
      this.atlChangePercentage,
      this.atlDate,
      this.roi,
      this.lastUpdated});

  Cryptocurrency.nullInstance() {
    id = '0000';
    symbol = '0000';
    name = '0000';
    image = '0000';
    currentPrice = 0;
    marketCap = 0;
    marketCapRank = 0;
    fullyDilutedValuation = 0;
    totalVolume = 0;
    high24h = 0;
    low24h = 0;
    priceChange24h = 0;
    priceChangePercentage24h = 0;
    marketCapChange24h = 0;
    marketCapChangePercentage24h = 0;
    circulatingSupply = 0;
    totalSupply = 0;
    maxSupply = 0;
    ath = 0;
    athChangePercentage = 0;
    athDate = '0000';
    atl = 0;
    atlChangePercentage = 0;
    atlDate = '0000';
    roi = {'0000': 0};
    lastUpdated = '0000';
  }

  Cryptocurrency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = json['current_price']?.toDouble();
    marketCap = json['market_cap']?.toDouble();
    marketCapRank = json['market_cap_rank'];
    fullyDilutedValuation = json['fully_diluted_valuation']?.toDouble();
    totalVolume = json['total_volume']?.toDouble();
    high24h = json['high_24h']?.toDouble();
    low24h = json['low_24h']?.toDouble();
    priceChange24h = json['price_change_24h']?.toDouble();
    priceChangePercentage24h = json['price_change_percentage_24h']?.toDouble();
    marketCapChange24h = json['market_cap_change_24h']?.toDouble();
    marketCapChangePercentage24h =
        json['market_cap_change_percentage_24h']?.toDouble();
    circulatingSupply = json['circulating_supply']?.toDouble();
    totalSupply = json['total_supply']?.toDouble();
    maxSupply = json['max_supply']?.toDouble();
    ath = json['ath']?.toDouble();
    athChangePercentage = json['ath_change_percentage']?.toDouble();
    athDate = json['ath_date'];
    atl = json['atl']?.toDouble();
    atlChangePercentage = json['atl_change_percentage']?.toDouble();
    atlDate = json['atl_date'];
    roi = json['roi'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['image'] = this.image;
    data['current_price'] = this.currentPrice;
    data['market_cap'] = this.marketCap;
    data['market_cap_rank'] = this.marketCapRank;
    data['fully_diluted_valuation'] = this.fullyDilutedValuation;
    data['total_volume'] = this.totalVolume;
    data['high_24h'] = this.high24h;
    data['low_24h'] = this.low24h;
    data['price_change_24h'] = this.priceChange24h;
    data['price_change_percentage_24h'] = this.priceChangePercentage24h;
    data['market_cap_change_24h'] = this.marketCapChange24h;
    data['market_cap_change_percentage_24h'] =
        this.marketCapChangePercentage24h;
    data['circulating_supply'] = this.circulatingSupply;
    data['total_supply'] = this.totalSupply;
    data['max_supply'] = this.maxSupply;
    data['ath'] = this.ath;
    data['ath_change_percentage'] = this.athChangePercentage;
    data['ath_date'] = this.athDate;
    data['atl'] = this.atl;
    data['atl_change_percentage'] = this.atlChangePercentage;
    data['atl_date'] = this.atlDate;
    data['roi'] = this.roi;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}
