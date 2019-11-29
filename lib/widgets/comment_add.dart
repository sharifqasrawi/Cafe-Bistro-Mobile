import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comment.dart';
import '../providers/menus.dart';

class CommentAdd extends StatefulWidget {
  final int itemId;

  CommentAdd(this.itemId);

  @override
  _CommentAddState createState() => _CommentAddState();
}

class _CommentAddState extends State<CommentAdd> {
  final _form = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _commentFocusNode = FocusNode();

  var _comment = Comment(
    id: null,
    itemId: null,
    name: '',
    text: '',
    email: '',
    createdAt: DateTime.now(),
  );

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    try {
      _comment = Comment(
        id: _comment.id,
        itemId: widget.itemId,
        name: _comment.name,
        email: _comment.email,
        text: _comment.text,
        createdAt: DateTime.now(),
      );

      Provider.of<Menus>(context, listen: false).postComment(_comment);
    } catch (error) {
      print(error);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('An Error Occured'),
                content: const Text('Sorry, something went wrong.'),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Color.fromRGBO(255, 199, 163, 0.9),
      padding: EdgeInsets.fromLTRB(
        10,
        10,
        10,
        MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Name and Email are required, Email will not be published.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                autofocus: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Name is required';
                  }

                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailFocusNode);
                },
                onSaved: (value) {
                  _comment = Comment(
                    id: null,
                    itemId: _comment.itemId,
                    name: value,
                    email: _comment.email,
                    text: _comment.text,
                    createdAt: _comment.createdAt,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                focusNode: _emailFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_commentFocusNode);
                },
                onSaved: (value) {
                  _comment = Comment(
                    id: null,
                    itemId: _comment.itemId,
                    name: _comment.name,
                    email: value,
                    text: _comment.text,
                    createdAt: _comment.createdAt,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Comment'),
                textInputAction: TextInputAction.done,
                maxLines: 3,
                focusNode: _commentFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Comment is required';
                  }
                  return null;
                },
                onSaved: (value) {
                  _comment = Comment(
                    id: null,
                    itemId: _comment.itemId,
                    name: _comment.name,
                    email: _comment.email,
                    text: value,
                    createdAt: _comment.createdAt,
                  );
                },
              ),
              FlatButton(
                child: Text('Post'),
                textColor: Colors.blue,
                onPressed: _saveForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
