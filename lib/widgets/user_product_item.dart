import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Are you sure??'),
                    content: Text('You want to delete this product!!'),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text('No')),
                      FlatButton(
                          onPressed: () async {
                            Navigator.of(ctx).pop();
                            try {
                              await Provider.of<Products>(context,
                                      listen: false)
                                  .deleteProduct(id);
                            } catch (error) {
                              scaffold.showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text(
                                    'Can not delete item at the moment',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.purple,
                                ),
                              );
                            }
                            scaffold.showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text(
                                  'Deleted Succesfully',
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.purple,
                              ),
                            );
                          },
                          child: Text('Yes')),
                    ],
                  ),
                );
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
