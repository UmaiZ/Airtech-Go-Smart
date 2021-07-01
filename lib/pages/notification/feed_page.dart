part of '../pages.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notification.feeds',
                style: Theme.of(context).textTheme.headline4)
            .tr(),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: feedList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          itemBuilder: (context, index) {
            var feed = feedList[index];
            return SideInAnimation(index, child: FeedCard(feed: feed));
          },
        ),
      ),
    );
  }
}
