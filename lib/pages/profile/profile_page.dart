part of '../pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool checkLogin = false;
  String UserName = "";
  String UserEmail = "";

  @override
  void initState() {
    setState(() {
      this.check();
    });
  }

  check() async {
    final storage = new FlutterSecureStorage();

    String imi = await storage.read(key: "imei");
    //print(imi);

    if (imi == "loginhuavaha") {
      UserEmail = await storage.read(key: "_userEmail");
      UserName = await storage.read(key: "_userName");
      //print(UserEmail);
      //print(UserName);

      setState(() {
        checkLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
        body: checkLogin
            ? Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 325.0,
                        child: Stack(
                          children: [
                            headerContent(
                              context,
                              image:
                                  'assets/images/2ab08d7aa25abbd579f036c3c3acec47.png',
                              username: checkLogin
                                  ? UserName.toString()
                                  : 'Jessica Veranda',
                              email: checkLogin
                                  ? UserEmail.toString()
                                  : 'jscvrnd19@gmail.com',
                            ),
                            primaryCard(context),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        elevation: 8.0,
                        child: Center(
                          child: Column(
                            children: [
                              // buildOrder(context),
                              buildFavorite(context),
                              buildTheme(context, themeProv),
                              buildAbout(context),
                              SideInAnimation(
                                7,
                                child: ListTile(
                                  onTap: () async {
                                    const url =
                                        'https://play.google.com/store/apps/details?id=com.airtechecommerce.AirEcom';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  leading: Icon(
                                    Icons.share_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  title: Text('Share',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(fontSize: 14.0))
                                      .tr(),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                  ),
                                ),
                              ),
                              SideInAnimation(
                                7,
                                child: ListTile(
                                  onTap: () async {
                                    const url =
                                        'whatsapp://send?phone=97333884272';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  leading: Icon(
                                    Icons.support_agent_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  title: Text('Support',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(fontSize: 14.0))
                                      .tr(),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                  ),
                                ),
                              ),
                              buildSignOut(context),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50.0),
                    ],
                  ),
                ),
              )
            : Center(
                child: Container(
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      SizedBox(height: 150.0),
                      Image.asset(
                        'assets/images/undraw_Login_re_4vu2.png',
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'You are not Login ',
                        style: Theme.of(context).textTheme.headline1,
                      ).tr(),
                      SizedBox(height: 15.0),
                      Text(
                        'Please Login to proceed more. Happy Shopping  :)',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ).tr(),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 85.0,
                        height: 50.0,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.button,
                          ).tr(),
                          onPressed: () {
                            Get.offAll(SignInPage());
                          },
                        ),
                      ),
                    ])),
              ));
  }

  SideInAnimation buildSignOut(BuildContext context) {
    return SideInAnimation(
      8,
      child: ListTile(
        onTap: () {
          checkLogin ? signOutDialog(context) : null;
        },
        leading: Icon(
          FlutterIcons.exit_to_app_mco,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          checkLogin ? 'profile.signout' : 'Sign In',
          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14.0),
        ).tr(),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }

  SideInAnimation buildAbout(BuildContext context) {
    return SideInAnimation(
      7,
      child: ListTile(
        onTap: () {
          Get.to(AboutUsPage());
        },
        leading: Icon(
          FlutterIcons.information_outline_mco,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('profile.aboutus',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 14.0))
            .tr(),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }

  SideInAnimation buildTheme(
      BuildContext context, ThemeChangerProvider themeProv) {
    return SideInAnimation(
      6,
      child: ListTile(
        onTap: () {
          Get.to(FavoritePage());
        },
        leading: Icon(
          FlutterIcons.sun_fea,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Light Mode',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 14.0))
            .tr(),
        trailing: Switch(
          value: themeProv.isLightTheme,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (value) {
            themeProv.changeTheme();
          },
        ),
      ),
    );
  }

  SideInAnimation buildFavorite(BuildContext context) {
    return SideInAnimation(
      6,
      child: ListTile(
        onTap: () {
          Get.to(FavoritePage());
        },
        leading: Icon(
          FlutterIcons.favorite_border_mdi,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('profile.favorite',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 14.0))
            .tr(),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }

  SideInAnimation buildNotification(BuildContext context) {
    return SideInAnimation(
      5,
      child: ListTile(
        leading: Icon(
          FlutterIcons.notification_ant,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('profile.notification',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 14.0))
            .tr(),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
        onTap: () {
          Get.to(ActivityPage());
        },
      ),
    );
  }

  SideInAnimation buildPayment(BuildContext context) {
    return SideInAnimation(
      4,
      child: ListTile(
        onTap: () {
          Get.to(ProfilePaymentPage());
        },
        leading: Icon(
          FlutterIcons.payment_mdi,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('profile.payment',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 14.0))
            .tr(),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }

  SideInAnimation buildOrder(BuildContext context) {
    return SideInAnimation(
      3,
      child: ListTile(
        onTap: () {
          Get.to(OrderPage());
        },
        leading: Icon(
          FlutterIcons.first_order_alt_faw5d,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('profile.order',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 14.0))
            .tr(),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }

  Future signOutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Center(
            child: Text('profile.signout',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 14.0))
                .tr(),
          ),
          content: Text(
            'profile.signoutsubtitle',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ).tr(),
          actions: [
            SizedBox(
              width: 50.0,
              child: RaisedButtonWidget(
                title: 'profile.yes',
                onPressed: () async {
                  final storage = new FlutterSecureStorage();

                  await storage.deleteAll();
                  Get.offAll(SignInPage());
                },
              ),
            ),
            FlatButton(
              onPressed: () {
                Get.back();
              },
              child: Text('profile.cancel',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 14.0))
                  .tr(),
            )
          ],
        );
      },
    );
  }

  Positioned primaryCard(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: 120,
        margin: EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 8.0,
          child: Center(
            child: Column(
              children: [
                SideInAnimation(
                  1,
                  child: ListTile(
                    onTap: () {
                      Get.to(ProfileDetailPage());
                    },
                    leading: Icon(
                      FlutterIcons.account_circle_mdi,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('profile.account',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 14.0))
                        .tr(),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ),
                SideInAnimation(
                  3,
                  child: ListTile(
                    onTap: () {
                      Get.to(OrderPage());
                    },
                    leading: Icon(
                      FlutterIcons.first_order_alt_faw5d,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('profile.order',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 14.0))
                        .tr(),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                )
                // SideInAnimation(
                //   2,
                //   child: ListTile(
                //     onTap: () {
                //       Get.to(ProfileAddressPage());
                //     },
                //     leading: Icon(
                //       FlutterIcons.address_ent,
                //       color: Theme.of(context).primaryColor,
                //     ),
                //     title: Text('profile.address',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .bodyText2
                //                 .copyWith(fontSize: 14.0))
                //         .tr(),
                //     trailing: Icon(
                //       Icons.arrow_forward_ios,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container headerContent(
    BuildContext context, {
    String image,
    String username,
    String email,
  }) {
    return Container(
      width: double.infinity,
      height: 230.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 85.0),
            // Container(
            //   width: 95.0,
            //   height: 95.0,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     shape: BoxShape.circle,
            //     border: Border.all(
            //       color: Colors.white,
            //       width: 2.0,
            //     ),
            //   ),
            //   child: CircleAvatar(
            //     radius: 40.0,
            //     backgroundColor: Colors.white,
            //     backgroundImage: AssetImage(image),
            //   ),
            // ),
            SizedBox(height: 8.0),
            Text(
              username,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: kBackgroundLightColor),
            ),
            SizedBox(height: 8.0),
            Text(
              email,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: kBackgroundLightColor),
            ),
          ],
        ),
      ),
    );
  }
}
