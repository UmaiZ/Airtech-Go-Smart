part of '../pages.dart';

class SortPage extends StatefulWidget {
  @override
  _SortPageState createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
  final List<SortModel> _sortBy = [
    SortModel(label: 'sort.timeending', isSelected: true),
    SortModel(label: 'sort.timenewly', isSelected: false),
    SortModel(label: 'sort.pricelow', isSelected: false),
    SortModel(label: 'sort.pricehigh', isSelected: false),
    SortModel(label: 'sort.distance', isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.0),
            buildTitle(context),
            SizedBox(height: 25.0),
            buildListOfSort(),
          ],
        ),
      ),
    );
  }

  ListView buildListOfSort() {
    return ListView.builder(
      itemCount: _sortBy.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        var sort = _sortBy[index];
        return Container(
          height: 45.0,
          child: InkWell(
            borderRadius: BorderRadius.circular(15.0),
            onTap: () {
              setState(() {
                _sortBy.forEach((e) => e.isSelected = false);
                sort.isSelected = true;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sort.label,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: sort.isSelected
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                  ).tr(),
                  sort.isSelected
                      ? Icon(Icons.done, color: Theme.of(context).primaryColor)
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Text(
        'sort.bestmatch',
        style: Theme.of(context).textTheme.headline1,
      ).tr(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('sort.sortby', style: Theme.of(context).textTheme.headline4)
          .tr(),
    );
  }
}

class SortModel {
  final String label;
  bool isSelected;

  SortModel({this.label, this.isSelected});
}
