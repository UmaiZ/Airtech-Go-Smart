part of '../widgets.dart';

class AddressCard extends StatefulWidget {
  final Address address;
  final void Function() onPressed;

  const AddressCard({Key key, this.address, this.onPressed}) : super(key: key);

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.only(bottom: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: widget.address.isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
            width: widget.address.isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.address.fullName,
                style: Theme.of(context).textTheme.headline4),
            SizedBox(height: 8.0),
            Text(widget.address.streetAddress,
                style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: 8.0),
            Text(widget.address.phoneNumber,
                style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(
                  width: 80.0,
                  child: RaisedButtonWidget(
                    title: 'product.edit',
                    onPressed: () {
                      Get.to(AddAddressPage());
                    },
                  ),
                ),
                SizedBox(width: 15.0),
                IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    showDeleteConfirmation(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showDeleteConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'product.subtitledelete',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ).tr(),
          actions: [
            FlatButton(
              onPressed: () {
                Get.back();

                showToast(msg: "Cancel delete clicked!");
              },
              child: Text(
                'product.cancel',
                style: Theme.of(context).textTheme.subtitle1,
              ).tr(),
            ),
            FlatButton(
              onPressed: () {
                showToast(msg: "Confirm delete clicked!");
              },
              child: Text(
                'product.yes',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Theme.of(context).primaryColor),
              ).tr(),
            ),
          ],
        );
      },
    );
  }
}
