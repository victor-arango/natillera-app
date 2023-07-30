// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/users/list_users_provider.dart';


class AddAbonosController {

  BuildContext? context;
   GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  TextEditingController valueController = TextEditingController();
  
  TextEditingController timeController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> init(BuildContext context,Function refresh) async {
    this.context = context;
    refresh();
  }




  void registerAbono(context,ref) async {
   final value = ref.read(valueProvider);
   final userId = ref.watch(idProvider);
   final fecha = DateTime.now();
    final formattedDate = DateFormat('yyyy/MM/dd').format(fecha);




    if (value.isEmpty) {
      
      return;
    } else {
      await supabase.from('payment').upsert([
        {'value': value, 'created_at': formattedDate, 'id_user': userId},
      ]);

           GoRouter.of(context).go('/user');
  //   if (GoRouter.of(context).canPop()) {
  //   GoRouter.of(context).pop();
  //   print('Primer parametro');
  // } else {
  //   print('Segundo parametro');
  //   GoRouter.of(context).go('/');
  // }
    }

  }


  
}
