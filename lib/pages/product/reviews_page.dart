part of '../pages.dart';

class ReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: DefaultTabController(
        length: 6,
        child: Column(
          children: [
            buildFilter(context),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  buildRatingContent(),
                  buildNoRating(context),
                  buildNoRating(context),
                  buildNoRating(context),
                  buildNoRating(context),
                  buildNoRating(context),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(WriteReview());
        },
        label: Text('product.writereview',
                style: Theme.of(context).textTheme.button)
            .tr(),
        backgroundColor: kPrimaryColor,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title:
          Text('product.reviews', style: Theme.of(context).textTheme.headline4)
              .tr(),
      elevation: 1.0,
    );
  }

  Center buildNoRating(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_reviews.png'),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text(
              'product.subtitle',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ).tr(),
          )
        ],
      ),
    );
  }

  Container buildRatingContent() {
    return Container(
      child: ListView.builder(
        itemCount: 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ReviewCardWidget();
        },
      ),
    );
  }

  Padding buildFilter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      child: ButtonsTabBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedBackgroundColor: Theme.of(context).cardColor,
        unselectedLabelStyle: Theme.of(context).textTheme.subtitle1,
        labelStyle: Theme.of(context).textTheme.button,
        unselectedBorderColor: Theme.of(context).accentColor,
        borderColor: Theme.of(context).primaryColor,
        borderWidth: 2.0,
        buttonMargin: EdgeInsets.only(left: 12.0),
        tabs: [
          Tab(
            text: tr("product.allreview"),
          ),
          Tab(
            icon: Icon(Icons.star, color: kYellowColor),
            text: "1",
          ),
          Tab(
            icon: Icon(Icons.star, color: kYellowColor),
            text: "2",
          ),
          Tab(
            icon: Icon(Icons.star, color: kYellowColor),
            text: "3",
          ),
          Tab(
            icon: Icon(Icons.star, color: kYellowColor),
            text: "4",
          ),
          Tab(
            icon: Icon(Icons.star, color: kYellowColor),
            text: "5",
          ),
        ],
      ),
    );
  }
}
