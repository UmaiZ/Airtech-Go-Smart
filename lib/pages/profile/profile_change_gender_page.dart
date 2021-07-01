part of '../pages.dart';

class ChangeGenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: () => Get.back()),
        title:
            Text('profile.gender', style: Theme.of(context).textTheme.headline4)
                .tr(),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            SideInAnimation(
              1,
              child: DropdownWidget(
                txTitle: tr('profile.choosegender'),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: FadeInAnimation(
                2,
                child: RaisedButtonWidget(
                  title: 'profile.save',
                  onPressed: () {
                    Get.back();
                    showToast(msg: 'Save Profile Gender clicked!');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
