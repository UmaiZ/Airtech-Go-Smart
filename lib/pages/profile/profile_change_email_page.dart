part of '../pages.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage(
      {Key key,
      @required this.email,
      @required this.phone,
      @required this.passwrd})
      : super(key: key);
  final email;
  final phone;
  final passwrd;

  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final _formKey = GlobalKey<FormState>();
  var _Email = '';

  @override
  Widget build(BuildContext context) {

    Future<http.Response> _trySubmit() async {
      final isValid = _formKey.currentState.validate();

      if (isValid) {
        _formKey.currentState.save();
         //print(_Email.trim());
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
          "Password": widget.passwrd,
          "Email": _Email.trim()
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
              key: '_userEmail', value: _Email.trim());
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
        title: Text('profile.emailaddress',
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
                  'profile.changeemail',
                  style: Theme.of(context).textTheme.subtitle2,
                ).tr(),
              ),
              SizedBox(height: 15.0),
              SideInAnimation(2,
                  child: TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Email.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _Email = value;
                    },
                    cursorColor: Theme.of(context).primaryColor,
                    obscureText: false,
                    initialValue: widget.email,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.bodyText2,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                      prefixIcon: Icon(FlutterIcons.mail_ant),
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
