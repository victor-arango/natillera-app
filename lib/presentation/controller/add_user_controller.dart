// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddUserController {

  BuildContext? context;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController savingsController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> init(BuildContext context) async {
    this.context = context;

    // Código de inicialización aquí
  

  }



  void registerUser() async {
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();

    String savings = savingsController.text.trim();



    if (name.isEmpty || lastName.isEmpty) {
      
      return;
    } else {
      await supabase.from('user').insert([
        {'name': name, 'apellido': lastName, 'saving': savings,},
      ]);

       GoRouter.of(context!).go('/');
    
    }
  }


  
}
