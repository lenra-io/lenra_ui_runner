import 'package:flutter/material.dart';
import 'package:api/response_models/api_error.dart';

class Error extends StatelessWidget {
  final ApiError error;

  Error(this.error);
  @override
  Widget build(BuildContext context) {
    return Text(
      this.error.message,
      style: TextStyle(color: Theme.of(context).errorColor),
    );
  }
}
