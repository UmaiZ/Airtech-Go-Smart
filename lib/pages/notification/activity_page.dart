part of '../pages.dart';

class ActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notification.activities',
                style: Theme.of(context).textTheme.headline4)
            .tr(),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: activityList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          itemBuilder: (context, index) {
            var activity = activityList[index];
            return SideInAnimation(
              index,
              child: ActivityCard(activity: activity),
            );
          },
        ),
      ),
    );
  }
}
