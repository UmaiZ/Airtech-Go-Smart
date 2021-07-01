part of '../pages.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RangeValues _currentRangeValues = const RangeValues(0, 10000);

  void applyChangesPressed() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        children: [
          buildPriceRange(context),
          SubCategoryFilterSearch(
            title: 'filter.condition',
            items: ['filter.new', 'filter.used', 'filter.notspesified'],
          ),
          SubCategoryFilterSearch(
            title: 'filter.buyingformat',
            items: [
              'filter.listing',
              'filter.acceptoffers',
              'filter.auction',
              'filter.buyitnow',
              'filter.classifiedads'
            ],
          ),
          SubCategoryFilterSearch(
            title: 'filter.itemlocation',
            items: ['filter.us', 'filter.na', 'filter.eu', 'filter.as'],
          ),
          SubCategoryFilterSearch(
            title: 'filter.showonly',
            items: [
              'filter.freereturns',
              'filter.returnsaccepted',
              'filter.authorizedseller',
              'filter.completeditem',
              'filter.solditem',
              'filter.listedaslots',
              'filter.searchindescription',
              'filter.authemticityverified',
              'Authemticity Verified'
            ],
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 25.0),
            child: RaisedButtonWidget(
              title: 'filter.apply',
              onPressed: applyChangesPressed,
            ),
          )
        ],
      ),
    );
  }

  Column buildPriceRange(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 18.0),
          child: Text(
            'filter.pricerange',
            style: Theme.of(context).textTheme.bodyText1,
          ).tr(),
        ),

        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 10000,
          divisions: 10,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
              //print(_currentRangeValues);

            });
            var data = searchArray.searchArrayData;
            for (int i = 0; i < data.length; i++) {
              var current = data[i];

              if(current['Price'] >= _currentRangeValues.start && current['Price'] <= _currentRangeValues.end){
                print(data);
                FilterArray.FilterArrayData.add(data);

              }
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'filter.min',
                style: Theme.of(context).textTheme.subtitle2,
              ).tr(),
              Text(
                'filter.max',
                style: Theme.of(context).textTheme.subtitle2,
              ).tr(),
            ],
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'filter.filtersearch',
        style: Theme.of(context).textTheme.headline4,
      ).tr(),
    );
  }
}

///---------------------------------------------------------------------------------------------Widget-----------------------------------
class SubCategoryFilterSearch extends StatelessWidget {
  final String title;
  final List<String> items;

  const SubCategoryFilterSearch({Key key, this.title, this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ).tr(),
          SizedBox(height: 12.0),
          Wrap(
            spacing: 10,
            children: items
                .map((item) => ItemBoxFilterSearch(
                      label: item,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

///----------------------------------------------------------------------------------------------Widget--------------------------------------
class ItemBoxFilterSearch extends StatefulWidget {
  final String label;

  const ItemBoxFilterSearch({Key key, this.label}) : super(key: key);

  @override
  _ItemBoxFilterSearchState createState() => _ItemBoxFilterSearchState();
}

class _ItemBoxFilterSearchState extends State<ItemBoxFilterSearch> {
  bool _isSelected = false;

  void onSelected() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(),
      child: ClipRRect(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              color: _isSelected ? Colors.blue[100] : Colors.white,
              border: Border.all(width: 1, color: Colors.grey[200]),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            padding: EdgeInsets.all(8),
            child: Text(widget.label,
                    softWrap: true,
                    textWidthBasis: TextWidthBasis.parent,
                    style: Theme.of(context).textTheme.subtitle2)
                .tr(),
          ),
        ),
      ),
    );
  }
}
