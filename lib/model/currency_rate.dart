class CurrencyRate {
  String? title;
  String? code;
  String? cb_price;
  String? nbu_buy_price;
  String? nbu_cell_price;
  String? date;

  CurrencyRate(this.nbu_buy_price, this.cb_price, this.nbu_cell_price,
      this.code, this.date, this.title);

  CurrencyRate.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    code = json["code"];
    cb_price = json["cb_price"];
    nbu_buy_price = json["nbu_buy_price"];
    nbu_cell_price = json["nbu_cell_price"];
    date = json["date"];
  }
}
