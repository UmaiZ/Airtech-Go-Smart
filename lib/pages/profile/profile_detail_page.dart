part of '../pages.dart';

class ProfileDetailPage extends StatefulWidget {
  @override
  _ProfileDetailPageState createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  bool showData = true;
  String name = "Loading";
  String email = "Loading";

  String gender = "Loading";
  String _userID;
  String phonenumber = "Loading";

  String password = "Loading";

  @override
  void initState() {
    setState(() {
      getAddress();
    });
  }

  getAddress() async {
    final storage = new FlutterSecureStorage();

    String _userEmail = await storage.read(key: "_userEmail");
    String _userPassword = await storage.read(key: "_userPassword");
    String _userID = await storage.read(key: "_userID");

    String url =
        'http://retailapi.airtechsolutions.pk/api/customer/login/${_userID}';

    print(url);
    http.Response res = await http.get(
      url,
    );
    var data = json.decode(res.body.toString());
    //print(data);

    if (data['description'].toString() == "Success") {
      setState(() {
        showData = true;
        //print(data['customer']);

        name = data['customer']['FullName'];
        //print(name);
        email = data['customer']['Email'];

        gender = "Male";

        phonenumber = data['customer']['Mobile'];

        password = data['customer']['Password'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              SideInAnimation(
                1,
                child: ListTile(
                  leading: SizedBox(width: 7),
                  title: GestureDetector(
                    onTap: () {
                      Get.to(ChangeNamePage());
                    },
                    child: Text(
                      showData ? name.toString() : 'Jessica Veranda',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  subtitle: Text(
                    showData ? email.toString() : 'jscvrnd19@gmail.com',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // buildGender(context),
              buildEmail(context),
              buildPhoneNumber(context),
              buildChangePassword(context),
            ],
          ),
        ),
      ),
    );
  }

  SideInAnimation buildChangePassword(BuildContext context) {
    return SideInAnimation(
      4,
      child: _customListTile(
        context,
        icon: FlutterIcons.lock1_ant,
        title: 'profile.changepassword',
        subtitle: showData ? '•••••••••••••' : '•••••••••••••',
        onTap: () => Get.to(_ChangePasswordPage(
            email: email.toString(),
            phone: phonenumber.toString(),
            passwrd: password.toString())),
      ),
    );
  }

  SideInAnimation buildPhoneNumber(BuildContext context) {
    return SideInAnimation(
      4,
      child: _customListTile(
        context,
        icon: FlutterIcons.smartphone_fea,
        title: 'profile.phonenumber',
        subtitle: showData ? phonenumber.toString() : '+62870717071',
        onTap: () => Get.to(ChangePhonePage(
            email: email.toString(),
            phone: phonenumber.toString(),
            passwrd: password.toString())),
      ),
    );
  }

  SideInAnimation buildEmail(BuildContext context) {
    return SideInAnimation(
      3,
      child: _customListTile(
        context,
        icon: FlutterIcons.mail_ant,
        title: 'profile.emailaddress',
        subtitle: showData ? email.toString() : 'jscvrnd19@gmail.com',
        onTap: () => Get.to(ChangeEmailPage(
            email: email.toString(),
            phone: phonenumber.toString(),
            passwrd: password.toString())),
      ),
    );
  }

  SideInAnimation buildGender(BuildContext context) {
    return SideInAnimation(
      2,
      child: _customListTile(
        context,
        icon: FlutterIcons.gender_female_mco,
        title: 'profile.gender',
        subtitle: showData ? gender.toString() : tr('profile.female'),
        onTap: () => Get.to(ChangePhonePage(
            email: email.toString(),
            phone: phonenumber.toString(),
            passwrd: password.toString())),
      ),
    );
  }

  // SideInAnimation buildUserName(BuildContext context) {
  //   return SideInAnimation(
  //     1,
  //     child: ListTile(
  //       leading: CircleAvatar(
  //         radius: 30,
  //         backgroundImage: NetworkImage(
  //             'https://i.pinimg.com/564x/aa/0b/51/aa0b512753d5a1c9c3c2869b77e0c67b.jpg'),
  //       ),
  //       title: GestureDetector(
  //         onTap: () {
  //           Get.to(ChangeNamePage());
  //         },
  //         child: Text(
  //           showData ? name : 'Jessica Veranda',
  //           style: Theme.of(context).textTheme.headline4,
  //         ),
  //       ),
  //       subtitle: Text(
  //         showData ? email : 'jscvrnd19@gmail.com',
  //         style: Theme.of(context).textTheme.subtitle1,
  //       ),
  //     ),
  //   );
  // }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      title:
          Text('profile.profile', style: Theme.of(context).textTheme.headline4)
              .tr(),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _customListTile(BuildContext context,
      {IconData icon, String title, String subtitle, void Function() onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blue,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
            overflow: TextOverflow.ellipsis,
          ).tr(),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle2,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            ),
          )
        ],
      ),
      trailing: Icon(
        FlutterIcons.right_ant,
      ),
      onTap: onTap,
    );
  }
}
