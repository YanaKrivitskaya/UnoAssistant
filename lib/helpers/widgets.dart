
import 'package:flutter/material.dart';

Widget loadingWidget(Color color) => Center(
  child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color)
  ),
);