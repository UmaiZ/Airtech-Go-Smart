part of '../pages.dart';


class ProfileAddAddressPage extends StatefulWidget {
  @override
  _ProfileAddAddressPageState createState() => _ProfileAddAddressPageState();
}

class _ProfileAddAddressPageState extends State<ProfileAddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  var _Name = '';
  var _Address = '';
  var _City = '';
  var _Zip = '';
  var _Number = '';

  @override
  Widget build(BuildContext context) {
    Future<http.Response> _trySubmit() async {
      final isValid = _formKey.currentState.validate();

      if (isValid) {
        _formKey.currentState.save();

        //print(_Name.trim());
        //print(_Address.trim());
        //print(_City.trim());
        //print(_Zip.trim());
        //print(_Number.trim());
        final storage = new FlutterSecureStorage();

        String _userID = await storage.read(key: "_userID");
        //print(_userID);

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                  child: const SpinKitWave(color: kPrimaryColor, type: SpinKitWaveType.center));
            });




        Map<String, dynamic> body = {
          "CustomerAddressID": 0,
          "Address": _Address.trim().toString(),
          "NickName": _Name.trim().toString(),
          "Latitude": "sample string 4",
          "Longitude": "sample string 5",
          "StatusID": 1,
          "StreetName": _Zip.trim().toString(),
          "CustomerID": int.parse(_userID),
          "Country": _City.trim().toString(),
          "ContactNo": _Number.trim().toString()
        };
        String jsonBody = json.encode(body);
        final headers = {'Content-Type': 'application/json'};

        //print(jsonBody);
        http.Response  res = await http.post(
          'http://retailapi.airtechsolutions.pk/api/customer/address/addorupdate',
          headers: headers,

          body: jsonBody,
        );
        var data = json.decode(res.body.toString());
        //print(data);

        if (data['description'] == "Your addresses updated successfully.") {
          Navigator.pop(context);
          Get.to(ProfileAddressPage());

        } else {
          Navigator.pop(context);
        }
      }
    }

    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideInAnimation(
                        1,
                        child: Text(
                          'product.fullname',
                          style: Theme.of(context).textTheme.headline4,
                        ).tr(),
                      ),
                      SizedBox(height: 15.0),
                      SideInAnimation(
                        1,
                        child: TextFormField(
                          key: ValueKey('name'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Name.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _Name = value;
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.bodyText2,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: tr('product.hinttextfullname'),
                            hintStyle: Theme.of(context).textTheme.subtitle2,
                            prefixIcon: Icon(FlutterIcons.user_fea),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color:
                                Theme.of(context).accentColor.withOpacity(.4),
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideInAnimation(
                        2,
                        child: Text('product.streetaddress',
                            style: Theme.of(context).textTheme.headline4)
                            .tr(),
                      ),
                      SizedBox(height: 15.0),
                      SideInAnimation(
                        2,
                        child: TextFormField(
                          key: ValueKey('address'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Address.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _Address = value;
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.bodyText2,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: tr('product.hinttextfullname'),
                            hintStyle: Theme.of(context).textTheme.subtitle2,
                            prefixIcon: Icon(FlutterIcons.location_pin_sli),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color:
                                Theme.of(context).accentColor.withOpacity(.4),
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideInAnimation(
                        3,
                        child: Text(
                          'product.city',
                          style: Theme.of(context).textTheme.headline4,
                        ).tr(),
                      ),
                      SizedBox(height: 15.0),
                      SideInAnimation(
                        3,
                        child: TextFormField(
                          key: ValueKey('city'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter City.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _City = value;
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.bodyText2,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: tr('product.hinttextcity'),
                            hintStyle: Theme.of(context).textTheme.subtitle2,
                            prefixIcon: Icon(FlutterIcons.city_variant_mco),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color:
                                Theme.of(context).accentColor.withOpacity(.4),
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideInAnimation(
                        4,
                        child: Text(
                          'product.zipcode',
                          style: Theme.of(context).textTheme.headline4,
                        ).tr(),
                      ),
                      SizedBox(height: 15.0),
                      SideInAnimation(
                        4,
                        child: TextFormField(
                          key: ValueKey('zip'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Zip.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _Zip = value;
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.bodyText2,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: tr('product.hinttextzipcode'),
                            hintStyle: Theme.of(context).textTheme.subtitle2,
                            prefixIcon: Icon(FlutterIcons.zip_box_mco),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color:
                                Theme.of(context).accentColor.withOpacity(.4),
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideInAnimation(
                        5,
                        child: Text(
                          'product.phone',
                          style: Theme.of(context).textTheme.headline4,
                        ).tr(),
                      ),
                      SizedBox(height: 15.0),
                      SideInAnimation(
                        5,
                        child: TextFormField(
                          key: ValueKey('number'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Number.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _Number = value;
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.bodyText2,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: tr('product.hinttextphone'),
                            hintStyle: Theme.of(context).textTheme.subtitle2,
                            prefixIcon: Icon(FlutterIcons.phone_fea),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color:
                                Theme.of(context).accentColor.withOpacity(.4),
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  FadeInAnimation(
                    6,
                    child: RaisedButtonWidget(
                      title: 'product.done',
                      onPressed: () {
                        _trySubmit();
                      },
                    ),
                  ),
                  SizedBox(height: 25.0),
                ],
              ),
            ),
          )),
    );
  }

  // FadeInAnimation buildAddButton() {
  //   return FadeInAnimation(
  //     6,
  //     child: RaisedButtonWidget(
  //       title: 'product.done',
  //       onPressed: () {
  //         _trySubmit();
  //         // Get.back();
  //       },
  //     ),
  //   );
  // }

  Column buildPhone(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SideInAnimation(
          5,
          child: Text(
            'product.phone',
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
        ),
        SizedBox(height: 15.0),
        SideInAnimation(
          5,
          child: TextFormFieldWidget(
            hintText: tr('product.hinttextphone'),
            keyboardType: TextInputType.text,
            obscureText: false,
            prefixIcon: Icon(FlutterIcons.phone_fea),
          ),
        ),
      ],
    );
  }

  Column buildZipcode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SideInAnimation(
          4,
          child: Text(
            'product.zipcode',
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
        ),
        SizedBox(height: 15.0),
        SideInAnimation(
          4,
          child: TextFormFieldWidget(
            hintText: tr('product.hinttextzipcode'),
            keyboardType: TextInputType.text,
            obscureText: false,
            prefixIcon: Icon(FlutterIcons.zip_box_mco),
          ),
        ),
      ],
    );
  }

  Column buildCity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SideInAnimation(
          3,
          child: Text(
            'product.city',
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
        ),
        SizedBox(height: 15.0),
        SideInAnimation(
          3,
          child: TextFormFieldWidget(
            hintText: tr('product.hinttextcity'),
            keyboardType: TextInputType.text,
            obscureText: false,
            prefixIcon: Icon(FlutterIcons.city_variant_mco),
          ),
        ),
      ],
    );
  }

  Column buildAddress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SideInAnimation(
          2,
          child: Text('product.streetaddress',
              style: Theme.of(context).textTheme.headline4)
              .tr(),
        ),
        SizedBox(height: 15.0),
        SideInAnimation(
          2,
          child: TextFormFieldWidget(
            hintText: tr('product.hinttextfullname'),
            keyboardType: TextInputType.text,
            obscureText: false,
            prefixIcon: Icon(FlutterIcons.location_pin_sli),
          ),
        ),
      ],
    );
  }

  Column buildFullName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SideInAnimation(
          1,
          child: Text(
            'product.fullname',
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
        ),
        SizedBox(height: 15.0),
        SideInAnimation(
          1,
          child: TextFormFieldWidget(
            hintText: tr('product.hinttextfullname'),
            keyboardType: TextInputType.text,
            obscureText: false,
            prefixIcon: Icon(FlutterIcons.user_fea),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'product.addaddress',
        style: Theme.of(context).textTheme.headline4,
      ).tr(),
    );
  }
}
