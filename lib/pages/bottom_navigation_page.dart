part of 'pages.dart';

class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TabController _tabController;
  AnimationController _animationController;
  DateTime currentBackPressTime;
  int _currentTab = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  var currentTab = [
    HomePage(),
    allProducts(),
    CartPage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: currentTab.length);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () => _willPopCallback(context),
        child: Scaffold(
          key: _scaffoldkey,
          drawerEdgeDragWidth: 0,
          body: Stack(
            children: <Widget>[
              NotificationListener<UserScrollNotification>(
                child: TabBarView(
                    children: currentTab,
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics()),
                onNotification: (UserScrollNotification notification) {
                  if (true) {
                    if (notification.direction == ScrollDirection.reverse &&
                        notification.metrics.extentAfter > kToolbarHeight &&
                        notification.metrics.axis == Axis.vertical) {
                      _animationController.forward();
                    } else if (notification.direction ==
                        ScrollDirection.forward) {
                      _animationController.reverse();
                    }
                  }
                  return true;
                },
              ),
            ],
          ),
          bottomNavigationBar: Container(
            // color: Color(0xfff7f7f7),
            width: size.width,
            height: 80,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BNBCustomPainter(),
                ),
                Container(
                  child: Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                        backgroundColor: kPrimaryColor,
                        child: Icon(FlutterIcons.shopping_cart_fea),
                        elevation: 8,
                        onPressed: () {
                          setState(() {
                            _currentTab = 2;
                            _tabController.animateTo(_currentTab);
                            _animationController.reverse();
                          });
                        }),
                  ),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          FlutterIcons.home_ant,
                          color: _currentTab == 0
                              ? kPrimaryColor
                              : Colors.grey.shade400,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentTab = 0;
                            //print(_currentTab);
                            _tabController.animateTo(_currentTab);
                            _animationController.reverse();
                          });
                        },
                        splashColor: Colors.white,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.dashboard_outlined,
                            color: _currentTab == 1
                                ? kPrimaryColor
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentTab = 1;
                              //print(_currentTab);

                              _tabController.animateTo(_currentTab);
                              _animationController.reverse();
                            });
                          }),
                      Container(
                        width: size.width * 0.20,
                      ),
                      IconButton(
                          icon: Icon(
                            FlutterIcons.favorite_border_mdi,
                            color: _currentTab == 3
                                ? kPrimaryColor
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentTab = 3;
                              _tabController.animateTo(_currentTab);
                              _animationController.reverse();
                            });
                          }),
                      IconButton(
                          icon: Icon(
                            FlutterIcons.account_outline_mco,
                            color: _currentTab == 4
                                ? kPrimaryColor
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentTab = 4;
                              _tabController.animateTo(_currentTab);
                              _animationController.reverse();
                            });
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<bool> _willPopCallback(BuildContext context) async {
    DateTime now = DateTime.now();
    if (_currentTab != 1) {
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(seconds: 4)) {
        currentBackPressTime = now;
        showToast(msg: 'Press Again to Exit');
        return Future.value(false);
      }
    }
    return Future.value(true);
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color(0xfff7f7f7)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
