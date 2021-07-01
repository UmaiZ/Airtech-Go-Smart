part of '../widgets.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key key,
    @required this.activity,
  }) : super(key: key);

  final Notifications activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/icons/offer.svg'),
          SizedBox(width: 15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title,
                        style: Theme.of(context).textTheme.headline3)
                    .tr(),
                SizedBox(height: 8.0),
                ReadMoreText(
                  tr("notification.mockdesc"),
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.left,
                  trimLines: 3,
                  colorClickableText: Theme.of(context).primaryColor,
                  trimMode: TrimMode.Line,
                ),
                SizedBox(height: 12.0),
                Text('${activity.date} ${activity.time}',
                    style: Theme.of(context).textTheme.subtitle2),
                SizedBox(height: 12.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
