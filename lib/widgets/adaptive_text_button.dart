import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextButton extends StatelessWidget {
  final _text;
  final Function _handler;

  AdaptiveTextButton(this._text, this._handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(child: Text(_text), onPressed: _handler)
        : TextButton(
            child: Text(_text),
            onPressed: _handler,
          );
  }
}
