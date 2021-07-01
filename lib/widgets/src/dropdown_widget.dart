part of '../widgets.dart';

class DropdownWidget extends StatefulWidget {
  final String txTitle;

  const DropdownWidget({Key key, this.txTitle}) : super(key: key);

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String initialValue;

  @override
  void initState() {
    super.initState();
    initialValue = 'Female';
  }

  void onDropdownChanged(val) {
    setState(() {
      initialValue = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.txTitle,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(
            height: 10,
          ),
          DropdownButtonFormField<String>(
            value: initialValue,
            isExpanded: true,
            items: ['Male', 'Female', 'Other']
                .map(
                  (item) => DropdownMenuItem(
                    child: Text(item,
                        style: Theme.of(context).textTheme.subtitle1),
                    value: item,
                  ),
                )
                .toList(),
            onChanged: (val) => onDropdownChanged(val),
            decoration: kInputDecorationBox(context),
          )
        ],
      ),
    );
  }
}
