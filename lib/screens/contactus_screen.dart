import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/message.dart';
import '../providers/messages.dart';

class ContactUsScreen extends StatefulWidget {
  static const routeName = '/contact-us';
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var _isLoading = false;
  var _messageSent = false;

  final _form = GlobalKey<FormState>();

  final _emailFocusNode = FocusNode();
  final _subjectFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();

  var _message = Message(
    id: null,
    name: '',
    email: '',
    text: '',
    subject: '',
    createdAt: DateTime.now(),
  );

  // var _initValues = {
  //   'name': '',
  //   'email': '',
  //   'subject': '',
  //   'message': '',
  // };

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _subjectFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    try {
      setState(() {
        _isLoading = true;
      });
      // send message
      await Provider.of<Messages>(context).sendMessage(_message).then((_) {
        setState(() {
          _isLoading = false;
          _messageSent = true;
        });
      });
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
      setState(() {
        // _isLoading = false;
      });
    }
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Email is required";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/c.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(15),
                color: Colors.black87,
                height: double.infinity,
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(top: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white60,
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Send us a message',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_emailFocusNode);
                            },
                            onSaved: (value) {
                              _message = Message(
                                id: null,
                                name: value,
                                email: _message.email,
                                subject: _message.subject,
                                text: _message.text,
                                createdAt: _message.createdAt,
                                isSeen: _message.isSeen,
                              );
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _emailFocusNode,
                            validator: (value) => _validateEmail(value),
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_subjectFocusNode);
                            },
                            onSaved: (value) {
                              _message = Message(
                                id: null,
                                name: _message.name,
                                email: value,
                                subject: _message.subject,
                                text: _message.text,
                                createdAt: _message.createdAt,
                                isSeen: _message.isSeen,
                              );
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Subject',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textInputAction: TextInputAction.next,
                            focusNode: _subjectFocusNode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Subject is required';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_messageFocusNode);
                            },
                            onSaved: (value) {
                              _message = Message(
                                id: null,
                                name: _message.name,
                                email: _message.email,
                                subject: value,
                                text: _message.text,
                                createdAt: _message.createdAt,
                                isSeen: _message.isSeen,
                              );
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Message',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textInputAction: TextInputAction.done,
                            focusNode: _messageFocusNode,
                            maxLines: 4,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Message is required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _message = Message(
                                id: null,
                                name: _message.name,
                                email: _message.email,
                                subject: _message.subject,
                                text: value,
                                createdAt: _message.createdAt,
                                isSeen: _message.isSeen,
                              );
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: RaisedButton(
                              color: Color.fromRGBO(100, 100, 100, 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Send',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              onPressed: _saveForm,
                            ),
                          ),
                          if (_messageSent)
                            Card(
                              elevation: 5,
                              color: Colors.teal,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Message sent successfully',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
