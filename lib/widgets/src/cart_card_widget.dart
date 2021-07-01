part of '../widgets.dart';

class CartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: 120.0,
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl:
                    'https://i.pinimg.com/564x/7f/0f/dc/7f0fdc10a9cb26e78d8e6257e1b06fb6.jpg',
                height: 100.0,
                width: 100.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Nike Air Zoom Pegasus 36 Miami',
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Row(
                          children: [
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Icon(
                            //     FlutterIcons.heart_outline_mco,
                            //     color: Theme.of(context).errorColor,
                            //   ),
                            // ),
                            // SizedBox(width: 8.0),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                FlutterIcons.delete_outline_mco,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '\$50',
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .apply(color: Theme.of(context).primaryColor),
                          ),
                        ),
                        // Counter(),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
