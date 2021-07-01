part of '../widgets.dart';

class ReviewCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: CachedNetworkImageProvider(
                'https://via.placeholder.com/1000',
              ),
            ),
            title: Text(
              'Jessica Veranda',
              style: Theme.of(context).textTheme.headline4,
            ),
            subtitle: SmoothStarRating(
              color: kYellowColor,
              size: 18.0,
              isReadOnly: true,
              spacing: 2.0,
              starCount: 5,
              rating: 3.5,
              allowHalfRating: true,
              borderColor: Theme.of(context).accentColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ReadMoreText(
              'est rerum tempore vitae sequi sint nihil reprehenderit dolor beatae ea dolores neque fugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis qui aperiam non debitis possimus qui neque nisi nulla',
              trimLines: 2,
              colorClickableText: Theme.of(context).primaryColor,
              trimMode: TrimMode.Line,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            width: double.infinity,
            height: 50.0,
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 18.0),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(right: 18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://i.pinimg.com/564x/fd/f3/43/fdf343d1ac9a8187818765d4592846f5.jpg',
                      width: 80.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
            child: Text(
              '5 Desember 2020',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }
}
