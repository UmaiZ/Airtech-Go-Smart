part of '../pages.dart';

class OfferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notification.offers',
                style: Theme.of(context).textTheme.headline4)
            .tr(),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: offerList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          itemBuilder: (context, index) {
            var offer = offerList[index];
            return SideInAnimation(
              index,
              child: OfferCard(activity: offer),
            );
          },
        ),
      ),
    );
  }
}
