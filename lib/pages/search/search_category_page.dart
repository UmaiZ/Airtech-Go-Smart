part of '../pages.dart';

class SearchCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'category.categories',
          style: Theme.of(context).textTheme.headline4,
        ).tr(),
        elevation: 1.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: categoryList
              .map(
                (item) => ListTile(
                  leading: Image.asset(item.icon),
                  title: Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ).tr(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
