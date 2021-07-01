part of '../pages.dart';


class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool showC = false;
  bool showD = false;
  bool showE = false;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('About', style: Theme.of(context).textTheme.headline4),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,

            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Height * 0.03,),

                  RichText(
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: kPrimaryColor,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text: 'About us',
                            style: new TextStyle(
                                fontSize: 22, fontFamily: 'UbuntuBold')),

                      ],
                    ),
                  ),
                  SizedBox(height: Height * 0.03,),

                  Text('Go smart is an eCommerce solution app that gives ease to shop owners who want to open their e-shop.  ', textAlign: TextAlign.left,style: TextStyle(color: Color(0xff7c7c7c), fontFamily: 'UbuntuRegulae', fontSize: 15),)
                  ,
                  SizedBox(height: Height * 0.01,),
                  Text('so Go smart is the best option for a ready-made eCommerce app you just create an account login add your product and your shop will run.', style: TextStyle(color: Color(0xff7c7c7c), fontFamily: 'UbuntuRegulae', fontSize: 15),)
                  ,
                  SizedBox(height: Height * 0.01,),
                ],
              ),
            ),
          ),
          SizedBox(height: Height * 0.02,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: RichText(
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: kPrimaryColor,

                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text: 'FAQ',
                            style: new TextStyle(
                                fontSize: 22, fontFamily: 'UbuntuBold')),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 13, top: 13),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: showC ? Height * 0.15 : Height * 0.04,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'How can i open account',
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: 'UbuntuMedium',
                                          fontSize: 14),
                                    ),
                                    showC
                                        ? GestureDetector(
                                        onTap: () {
                                          print('false');
                                          setState(() {
                                            showC = false;
                                          });
                                        },
                                        child: Icon(
                                            Icons.keyboard_arrow_up_outlined))
                                        : GestureDetector(
                                        onTap: () {
                                          print('true');
                                          setState(() {
                                            showC = true;
                                          });
                                        },
                                        child: Icon(
                                            Icons.keyboard_arrow_down_outlined))
                                  ],
                                ),
                              ),
                              showC
                                  ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      width: Width * 0.9,
                                      child: Divider(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, bottom: 8, top: 2),
                                    child: Text(
                                      'Go to accounts it will redirect you to signup page.',
                                      style: TextStyle(
                                          color: Color(0xffbdbdbd),
                                          fontFamily: 'UbuntuRegular',
                                          fontSize: 12),
                                    ),
                                  )
                                ],
                              )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 13, top: 13),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: showD ? Height * 0.15 : Height * 0.04,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Where i can see orders ? ',
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: 'UbuntuMedium',
                                          fontSize: 14),
                                    ),
                                    showD
                                        ? GestureDetector(
                                        onTap: () {
                                          print('false');
                                          setState(() {
                                            showD = false;
                                          });
                                        },
                                        child: Icon(
                                            Icons.keyboard_arrow_up_outlined))
                                        : GestureDetector(
                                        onTap: () {
                                          print('true');
                                          setState(() {
                                            showD = true;
                                          });
                                        },
                                        child: Icon(
                                            Icons.keyboard_arrow_down_outlined))
                                  ],
                                ),
                              ),
                              showD
                                  ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      width: Width * 0.9,
                                      child: Divider(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, bottom: 8, top: 2),
                                    child: Text(
                                      'go to profile page then go to orders. You can see all orders there.',
                                      style: TextStyle(
                                          color: Color(0xffbdbdbd),
                                          fontFamily: 'UbuntuRegular',
                                          fontSize: 12),
                                    ),
                                  )
                                ],
                              )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 13, top: 13),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: showE ? Height * 0.15 : Height * 0.04,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'How to filter ? ',
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: 'UbuntuMedium',
                                          fontSize: 14),
                                    ),
                                    showE
                                        ? GestureDetector(
                                        onTap: () {
                                          print('false');
                                          setState(() {
                                            showE = false;
                                          });
                                        },
                                        child: Icon(
                                            Icons.keyboard_arrow_up_outlined))
                                        : GestureDetector(
                                        onTap: () {
                                          print('true');
                                          setState(() {
                                            showE = true;
                                          });
                                        },
                                        child: Icon(
                                            Icons.keyboard_arrow_down_outlined))
                                  ],
                                ),
                              ),
                              showE
                                  ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      width: Width * 0.9,
                                      child: Divider(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, bottom: 8, top: 2),
                                    child: Text(
                                      'Go to categories there is filter icon you can filter and sort from there and select sub categories.',
                                      style: TextStyle(
                                          color: Color(0xffbdbdbd),
                                          fontFamily: 'UbuntuRegular',
                                          fontSize: 12),
                                    ),
                                  )
                                ],
                              )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      )
    );
  }
}
