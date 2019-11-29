import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';

import '../providers/item.dart';
import '../providers/menus.dart';
import '../widgets/comment_add.dart';

class ItemDetailsScreen extends StatefulWidget {
  static const routeName = '/item-details';

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  var id = 0;
  var _isInit = true;
  Item item;

  void _startComment() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => CommentAdd(item.id));
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Menus>(context).fetchAndSetCategories();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context).settings.arguments as int;
    item = Provider.of<Menus>(context).getItem(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromRGBO(100, 100, 100, 0.8),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_comment),
        onPressed: _startComment,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  color: Colors.black38,
                  child: Text(
                    '${item.price.toStringAsFixed(2)}\$',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 5,
              color: Color.fromRGBO(200, 200, 200, 0.9),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '" ${item.description} "',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Comments:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 300,
                child: ListView.builder(
                  itemCount: item.comments.length,
                  itemBuilder: (ctx, idx) => ListTile(
                    title: Text(item.comments[idx].name),
                    subtitle: Text(
                      item.comments[idx].text,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    trailing:
                        Text(timeago.format(item.comments[idx].createdAt)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
