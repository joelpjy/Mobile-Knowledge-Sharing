import 'package:flutter/material.dart';

class GreyedOut extends StatelessWidget {
  final Widget child;
  final bool greyedOut;

  GreyedOut(this.child, {this.greyedOut = true});

  @override
  Widget build(BuildContext context) {
    return greyedOut ? Opacity(opacity: 0.3, child: child) : child;
  }
}
