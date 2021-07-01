part of '../pages.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Icon(
                        Icons.done,
                        size: 50,
                        color: Colors.white,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'order.success',
                      style: Theme.of(context).textTheme.headline1,
                    ).tr(),
                    SizedBox(height: 12.0),
                    Text(
                      'order.subtitlesuccess',
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ).tr(),
                    SizedBox(height: 20),
                    RaisedButtonWidget(
                      title: 'Back to Home',
                      onPressed: () => Get.offAll(BottomNavigationBarPage()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
