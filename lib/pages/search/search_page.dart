part of '../pages.dart';

class SearchPg extends StatefulWidget {
  @override
  _SearchPgState createState() => _SearchPgState();
}

class _SearchPgState extends State<SearchPg> {
  Future getData() async {


    var result = FilterArray.FilterArrayData;
    if (result.length != 0) {
      return result;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(FilterArray.FilterArrayData);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 50.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Center(
              child: TextField(
                onTap: () => Get.to(SearchPgExtra()),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: tr('search.search'),
                  alignLabelWithHint: true,
                  hintStyle: Theme.of(context).textTheme.subtitle2,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       FlutterIcons.sort_descending_mco,
        //       color: Theme.of(context).accentColor,
        //     ),
        //     onPressed: navigateToSortPage,
        //   ),
        //   IconButton(
        //     icon: Icon(
        //       FlutterIcons.filter_fea,
        //       color: Theme.of(context).primaryColor,
        //     ),
        //     onPressed: navigateToFilterPage,
        //   ),
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/search.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            SizedBox(height: 15.0),
            Text(
              'search.title',
              style: Theme.of(context).textTheme.headline1,
            ).tr(),
            SizedBox(height: 15.0),
            Text(
              'search.subtitle',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ).tr(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
          ],
        ),
      ),
    );
  }

  void navigateToSearchByCategory() {
    Get.to(SearchCategoryPage());
  }

  void navigateToFilterPage() {
    Get.to(FilterPage());
  }

  void navigateToSortPage() {
    Get.to(SortPage());
  }

  void navigateToSearch(BuildContext contexts) {
    showSearch(context: contexts, delegate: Search());
  }
}

class SearchPgExtra extends StatefulWidget {
  @override
  _SearchPgExtraState createState() => _SearchPgExtraState();
}

class _SearchPgExtraState extends State<SearchPgExtra> {
  final queryController = StreamController<String>();
  Stream<List<SearchData>> filteredStream;
  AsyncMemoizer memoizer = AsyncMemoizer();
  String priceGlobal;
  String DeliveryGlobal;
  String TaxGlobal;
  double Tax;
  double Totalamount;
  @override
  void initState() {
    super.initState();
    getDss();
    filteredStream = queryController.stream.asyncMap(_filter);
    queryController.add('');
  }

  getDss() async{
    final storage = new FlutterSecureStorage();

    priceGlobal = await storage.read(key: "_Currency");

    TaxGlobal = await storage.read(key: "_TaxPercentTaxPercent");
    print('asda');
    print(TaxGlobal);
    DeliveryGlobal = await storage.read(key: "_DeliveryCharges");
  }
  @override
  Widget build(BuildContext context) {
    // if(FilterArray.FilterArrayData != null){
    //   //print('Have Filter Data');
    // }
    // else{
    //   //print('no filter data');
    // }

    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: 50.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Center(
                child: TextField(
                  onChanged: queryController.add,
                  decoration: InputDecoration(
                    hintText: tr('search.search'),
                    alignLabelWithHint: true,
                    hintStyle: Theme.of(context).textTheme.subtitle2,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<SearchData>>(
                initialData: [],
                stream: filteredStream,
                builder: (ctx, snapshot) {
                  //print('snap');
                  //print(snapshot);
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, i) => AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      child: ListTile(
                        key: UniqueKey(),
                        title: Text(snapshot.data[i].Name),
                        subtitle: Text(
                            '$priceGlobal ${snapshot.data[i].Price.toString()}', style: TextStyle(
                          color: kPrimaryColor
                        )
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),

                          child: Container(
                            color: kCardImageBCColor,
                            width: 60,
                            height: 60,
                            child: CachedNetworkImage(
                              imageUrl:
                              snapshot.data[i].Image,
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                          )),
                        onTap: () {
                          print(snapshot.data[i].Name);
                          print(snapshot.data[i].ID);
                          print(snapshot.data[i].Image);

                          //print(searchArray.searchArrayData);
                          //
                          var filterData = searchArray.searchArrayData
                              .where((element) =>
                                  element["ID"] == snapshot.data[i].ID)
                              .toList();
                          //print(filterData);
                          //print(filterData[0]);

                          Get.to(ProductDetailPage2(product: filterData[0]));
                          // Get.to(ProductDetailPage2(product: snapshot.data[i]));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Future<List<SearchData>> _filter(String query) async {
    //print('_filter [$query]');
    List<SearchData> data = await memoizer.runOnce(_getAPI);

    if (query.isEmpty) return data;
    final lquery = query.toLowerCase();
    return data.where((e) => e.Name.toLowerCase().contains(lquery)).toList();
  }

  Future<List<SearchData>> _getAPI() async {
    //print('_getAPI');
    // var response =
    //     await http.get('http://retailapi.airtechsolutions.pk/api/menu/2112');
    // Map<String, dynamic> map = json.decode(response.body);
    //
    // List<dynamic> data = map["Categories"];
    // var items = {'Items': []};
    //
    // data.forEach((category) {
    //   if (category['Subcategories'] != null) {
    //     category['Subcategories'].forEach((subcategory) {
    //       items['Items'].addAll(subcategory['Items']);
    //     });
    //   }
    // });
    // //print(items['Items']);

    return searchArray.searchArrayData
        .map<SearchData>((m) => SearchData(m['Name'], m['ID'], m['Price'], m['Image']))
        .toList();
  }
}

// ===============================================

class SearchData {
  final String Name;
  final String Image;

  final int ID;
  final double Price;
  SearchData(this.Name, this.ID, this.Price, this.Image);
}

class Rank {
  final String Name;
  final String Image;

  int rank;
  final double Price;

  Rank(this.Name, this.rank, this.Price, this.Image);

  @override
  String toString() => Name;
}
