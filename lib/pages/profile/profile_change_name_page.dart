part of '../pages.dart';

class ChangeNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: ListView(
                  children: [
                    SizedBox(height: 20.0),
                    buildFirstName(context),
                    SizedBox(height: 15.0),
                    buildLastName(context),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                18.0,
                0.0,
                18.0,
                20.0,
              ),
              child: FadeInAnimation(
                3,
                child: RaisedButtonWidget(
                  title: 'profile.save',
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildLastName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SideInAnimation(
          2,
          child: Text(
            'profile.lastname',
            style: Theme.of(context).textTheme.subtitle2,
          ).tr(),
        ),
        SizedBox(height: 12.0),
        SideInAnimation(
          2,
          child: TextFieldWidget(
            hintText: tr('profile.lastname'),
            value: 'Veranda',
            keyboardType: TextInputType.text,
            obscureText: false,
          ),
        ),
      ],
    );
  }

  Column buildFirstName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SideInAnimation(
          1,
          child: Text(
            'profile.firstname',
            style: Theme.of(context).textTheme.subtitle2,
          ).tr(),
        ),
        SizedBox(height: 12.0),
        SideInAnimation(
          1,
          child: TextFieldWidget(
            hintText: tr('profile.firstname'),
            value: 'Jessica',
            obscureText: false,
            keyboardType: TextInputType.text,
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('profile.profilename',
              style: Theme.of(context).textTheme.headline4)
          .tr(),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }
}
