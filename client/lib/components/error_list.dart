import 'package:flutter/material.dart';
import 'package:api/response_models/api_errors.dart';
import 'package:components/error.dart';

class ErrorList extends StatelessWidget {
  final ApiErrors? errors;
  ErrorList(this.errors);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: this.errors?.map((error) => Error(error)).toList() ?? [],
    );
  }
}
