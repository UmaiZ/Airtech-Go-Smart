part of '../pages.dart';




class _ChangePasswordPage extends StatefulWidget {
  const _ChangePasswordPage(
      {Key key,
        @required this.email,
        @required this.phone,
        @required this.passwrd})
      : super(key: key);
  final email;
  final phone;
  final passwrd;

  @override
  __ChangePasswordPageState createState() => __ChangePasswordPageState();
}

class __ChangePasswordPageState extends State<_ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  var _Password = '';

  @override
  Widget build(BuildContext context) {

    //print(widget.phone);
    Future<http.Response> _trySubmit() async {
      final isValid = _formKey.currentState.validate();

      if (isValid) {
        _formKey.currentState.save();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                  child: const SpinKitWave(color: kPrimaryColor, type: SpinKitWaveType.center));
            });



        final storage = new FlutterSecureStorage();

        Map<String, dynamic> body = {
          "CustomerID": await storage.read(key: "_userID"),
          "FullName": await storage.read(key: "_userName"),
          "Mobile": widget.phone,
          "Password": _Password.trim(),
          "Email": widget.email
        };

        String jsonBody = json.encode(body);
        final headers = {'Content-Type': 'application/json'};

        //print(jsonBody);
        http.Response res = await http.post(
          'http://retailapi.airtechsolutions.pk/api/customer/signup',
          headers: headers,

          body: jsonBody,
        );
        var data = json.decode(res.body.toString());
        //print(data);

        if (data['description'] == "Your profile has been updated successfully.") {
          final _storage = FlutterSecureStorage();

          await _storage.write(
              key: '_userPassword', value: _Password.trim());
          Navigator.pop(context);
          Get.back();

        } else {
          Navigator.pop(context);
        }
      }
    }


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            FlutterIcons.left_ant,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text('Passsword',
            style: Theme.of(context).textTheme.headline4)
            .tr(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              SideInAnimation(
                1,
                child: Text(
                  'Change Your Password',
                  style: Theme.of(context).textTheme.subtitle2,
                ).tr(),
              ),
              SizedBox(height: 15.0),
              SideInAnimation(2,
                  child: TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Password.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _Password = value;
                    },
                    cursorColor: Theme.of(context).primaryColor,
                    obscureText: false,
                    initialValue: widget.passwrd,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.bodyText2,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                      prefixIcon: Icon(Icons.vpn_key_outlined),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor.withOpacity(.4),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                          )),
                    ),
                  )),
              Spacer(),
              FadeInAnimation(
                3,
                child: RaisedButtonWidget(
                  title: 'profile.save',
                  onPressed: () {
                    _trySubmit();
                  },
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
