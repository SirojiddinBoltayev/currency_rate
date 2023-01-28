import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_api_test/model/currency_rate.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CurrencyRate> currencyList = [];

  Future<List<CurrencyRate>> getCurrencyRate() async {
    String url = "https://nbu.uz/uz/exchange-rates/json/";

    Uri myUrl = Uri.parse(url);

    var response = await http.get(myUrl);

    var data = jsonDecode(response.body);
    data.forEach((element) {
      currencyList.add(CurrencyRate.fromJson(element));
    });
    return currencyList;
  }

  @override
  void initState() {
    getCurrencyRate();

    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade300,
        title: const Text("Valyuta kurslari"),
      ),
      body: StreamBuilder(
          stream: getCurrencyRate().asStream(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index){
                  if(snapshot.data![index].code.toString() != "RUB" && snapshot.data![index].code.toString() != "USD" && snapshot.data![index].code.toString() != "EUR"){
                    return Container();
                  }
return Padding(
  padding: const EdgeInsets.all(3.0),
  child: Container(
    height: size.height * 0.133,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: Colors.indigo.shade100,
    ),
    child: InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

           SizedBox(
            width: size.width * 0.05,
          ),

          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                      snapshot.data![index].date ?? "..",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),
                    ),
                 SizedBox(
                  height: size.height * 0.009,
                ),
               Text(
                    snapshot.data![index].code ?? "",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                ),
                 SizedBox(
                  height: size.height * 0.009,
                ),
               Text(
                        snapshot.data![index].title ?? ".."),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Text("Narxi:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(
                        "${snapshot.data![index].cb_price ?? ".."} UZS"),
                  ],
                ),
                 SizedBox(
                  height: size.height * 0.009,
                ),
                snapshot.data![index].nbu_cell_price != "" ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Text("Sotish:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(
                        "${snapshot.data![index].nbu_cell_price ?? ".."} UZS"),
                  ],
                ) : Row(children: [],),
                 SizedBox(
                  height: size.height * 0.009,
                ),
                snapshot.data![index].nbu_buy_price != "" ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Text("Olish:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(
                        "${snapshot.data![index].nbu_buy_price ?? ".."} UZS"),
                  ],
                ) : Row(children: [],),
              ],
            ),
          ),

        ],
      ),
    ),
  ),
);
                })),
Divider(thickness: 2,color: Colors.indigo.shade50,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: ListView.builder(
                    itemCount: snapshot.requireData.length,
                    itemBuilder: (BuildContext context, int index) {
                      if(snapshot.data![index].code.toString() != "EUR" && snapshot.data![index].code.toString() != "RUB" && snapshot.data![index].code.toString() != "USD"){
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            height:    size.height * 0.133,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.indigo.shade100,
                            ),
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  const SizedBox(
                                    width: 24,
                                  ),

                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].date ?? "..",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black45),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          snapshot.data![index].code ?? "",
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            snapshot.data![index].title ?? ".."),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children: [
                                            Text("Narxi:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(
                                                "${snapshot.data![index].cb_price ?? ".."} UZS"),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        snapshot.data![index].nbu_cell_price != "" ? Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children: [
                                            Text("Sotish:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(
                                                "${snapshot.data![index].nbu_cell_price ?? ".."} UZS"),
                                          ],
                                        ) : Row(children: [],),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        snapshot.data![index].nbu_buy_price != "" ? Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children: [
                                            Text("Olish:  ",style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(
                                                "${snapshot.data![index].nbu_buy_price ?? ".."} UZS"),
                                          ],
                                        ) : Row(children: [],),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}
