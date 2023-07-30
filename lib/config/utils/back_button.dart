import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget backButton(BuildContext context, Color color) {
  return IconButton(
    icon: const Icon(Icons.arrow_back),
    color: color,
    onPressed: () {
      if (GoRouter.of(context).canPop()) {
    GoRouter.of(context).pop();
    
  } else {
 
    GoRouter.of(context).go('/');
  }
    },
  );
}