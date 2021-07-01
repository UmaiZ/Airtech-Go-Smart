part of '../pages.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _pageIndex = 0;
  PageController _pageController;

  @override
  Future<void> initState()  {
    super.initState();
    checkBoard();
    _pageController = PageController();


  }

  checkBoard() async {
    final _storage = FlutterSecureStorage();

    await _storage.write(key: 'board', value: 'yes');
  }

  List<OnBoardingModel> _onboardingPageList = [
    OnBoardingModel(
        title: "onboarding.onboarding1title",
        subtitle: "onboarding.onboarding1subtitle",
        image: "assets/images/onboarding/1.png"),
    OnBoardingModel(
        title: "onboarding.onboarding2title",
        subtitle: "onboarding.onboarding2subtitle",
        image: "assets/images/onboarding/2.png"),
    OnBoardingModel(
        title: "onboarding.onboarding3title",
        subtitle: "onboarding.onboarding3subtitle",
        image: "assets/images/onboarding/3.png"),
  ];

  void nextPageClicked() {
    if (_pageIndex == 2) {
      Get.offAll(BottomNavigationBarPage());
    } else {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void navigateToSignIn() {
    Get.offAll(BottomNavigationBarPage());
  }



  @override
  Widget build(BuildContext context) {

    navigateToHomePage(BuildContext context) {
      Get.offAll(BottomNavigationBarPage());
    }

    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: PageView.builder(
              itemCount: _onboardingPageList.length,
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _pageIndex = value;
                });
              },
              itemBuilder: (context, index) {
                var item = _onboardingPageList[index];
                return Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5,
                  ),
                  width: double.infinity,
                  height: 250.0,
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      Image.asset(
                        item.image,
                        width: MediaQuery.of(context).size.height / 2,
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        item.title,
                        style:
                            theme.textTheme.headline3.copyWith(fontSize: 30.0),
                        textAlign: TextAlign.center,
                      ).tr(),
                      SizedBox(height: 15.0),
                      Text(
                        item.subtitle,
                        style:
                            theme.textTheme.subtitle1.copyWith(fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ).tr(),
                    ],
                  ),
                );
              },
            ),
          ),
          buildBottomIndicator(theme),
        ],
      ),
    );
  }

  Positioned buildBottomIndicator(ThemeData theme) {
    return Positioned(
      bottom: 18.0,
      left: 18.0,
      right: 18.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Get.offAll(BottomNavigationBarPage());

            },
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              width: 70.0,
              height:45.0,
              alignment: Alignment.center,
              child: Text(_pageIndex == 2 ? '' : 'onboarding.skip',
                      style: theme.textTheme.headline4)
                  .tr(),
            ),
          ),
          Expanded(
            child: Center(
              child: DotsIndicator(
                dotsCount: _onboardingPageList.length,
                position: _pageIndex.toDouble(),
                decorator: DotsDecorator(
                  activeColor: theme.primaryColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(35.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: nextPageClicked,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              width: 70.0,
              height:40.0,
              alignment: Alignment.center,
              child: Text(
                _pageIndex == 2 ? 'onboarding.next' : 'onboarding.done',
                style: theme.textTheme.headline4,
              ).tr(),
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardingModel {
  final String title;
  final String subtitle;
  final String image;

  OnBoardingModel({this.title, this.subtitle, this.image});
}
