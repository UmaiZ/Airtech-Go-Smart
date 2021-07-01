part of '../widgets.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 3.0),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.remove,
              color: Colors.white,
              size: 20.0,
            ),
          ),
          SizedBox(width: 3.0),
          CircleAvatar(
            radius: 15.0,
            backgroundColor: Theme.of(context).backgroundColor,
            child: Text(
              '4',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(width: 3.0),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 20.0,
            ),
          ),
          SizedBox(width: 3.0),
        ],
      ),
    );
  }
}
