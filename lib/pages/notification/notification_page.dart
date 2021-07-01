part of '../pages.dart';

class NotificationPage extends StatelessWidget {
  navigateToActivityPage() {
    Get.to(ActivityPage());
  }

  navigateToFeedPage() {
    Get.to(FeedPage());
  }

  navigateToOfferPage() {
    Get.to(OfferPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'notification.notifications',
          style: Theme.of(context).textTheme.headline4,
        ).tr(),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 15.0),
            SideInAnimation(
              1,
              child: customListTile(
                context,
                icon: 'assets/icons/offer.svg',
                title: 'notification.offers',
                count: '10',
                onTap: navigateToOfferPage,
              ),
            ),
            SideInAnimation(
              2,
              child: customListTile(
                context,
                icon: 'assets/icons/feed.svg',
                title: 'notification.feeds',
                count: '17',
                onTap: navigateToFeedPage,
              ),
            ),
            SideInAnimation(
              3,
              child: customListTile(
                context,
                icon: 'assets/icons/notification.svg',
                title: 'notification.activities',
                count: '100',
                onTap: navigateToActivityPage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile customListTile(
    BuildContext context, {
    void Function() onTap,
    String title,
    String icon,
    String count,
  }) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(icon),
      title: Text(title, style: Theme.of(context).textTheme.headline4).tr(),
      trailing: CircleAvatar(
        radius: 15.0,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          count,
          style: Theme.of(context).textTheme.subtitle2.apply(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
