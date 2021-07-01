part of '../pages.dart';

class WriteReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              buildHeading(context),
              SizedBox(height: 20.0),
              buildRating(context),
              SizedBox(height: 20.0),
              buildTextField(context),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'product.writereview',
        style: Theme.of(context).textTheme.headline4,
      ).tr(),
      actions: [
        IconButton(
          icon: Icon(
            Icons.done,
          ),
          onPressed: () {
            Get.back();
            showToast(msg: tr('product.toastreview'));
          },
        ),
      ],
    );
  }

  TextField buildTextField(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.headline1,
      enabled: true,
      maxLines: 5,
      autocorrect: false,
      maxLength: 2000,
      decoration: InputDecoration(
        hintText: tr('product.hinttext'),
        hintStyle: Theme.of(context).textTheme.subtitle2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusColor: Theme.of(context).primaryColor,
      ),
    );
  }

  SmoothStarRating buildRating(BuildContext context) {
    return SmoothStarRating(
      borderColor: Theme.of(context).accentColor,
      color: kYellowColor,
      size: 30.0,
      allowHalfRating: true,
      rating: 4.0,
      starCount: 5,
      spacing: 1.5,
      isReadOnly: false,
    );
  }

  Text buildHeading(BuildContext context) {
    return Text(
      'product.titlereview',
      style: Theme.of(context).textTheme.headline4,
    ).tr();
  }
}
