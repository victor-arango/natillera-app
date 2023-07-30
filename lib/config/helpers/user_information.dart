


import 'package:natillera_app/presentation/models/savings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../presentation/models/users.dart';

class UserInformation{

  static Future<List<Users>> getUsers(String? filter) async {
    final query = Supabase.instance.client
        .from('user')
        .select('id, name, apellido, saving');

 
    late dynamic response;

    if (filter == null || filter.isEmpty) {
      response = await query;
    } else {
      response = await query.textSearch('name', "$filter:*");
    }


    if (response!= null) {
      return (response as List<dynamic>)
          .map((json) => Users.fromJson(json))
          .toList();
    } else {
      return [];
    }
  }



  
  static Future<List<Savings>> getDetailsById(int id) async {
    final query = Supabase.instance.client
        .from('payment')
        .select('id, created_at, id_user, value');

 
    late dynamic response;

      response = await query.eq('id_user',id);
  


    if (response!= null) {
      return (response as List<dynamic>)
          .map((json) => Savings.fromJson(json))
          .toList();
    } else {
      return [];
    }

  }
  



  static Future<Users> getUserById(int id) async {
    final query = Supabase.instance.client
        .from('user')
        .select('id, name, apellido, saving');

 
    late dynamic response;

    
      response = await query.eq('id',id).single();
    
  if (response != null) {
    final user = Users.fromJson(response as Map<String, dynamic>);
    return user;
  } else {
    throw Exception('No se encontró un usuario con el ID especificado');
  }

  }






  static Future<Users> registerUser(String name, String lastName, double savings,) async {
    final query = Supabase.instance.client.from('user').insert([
        {'name': name, 'apellido': lastName, 'saving': savings,},
      ]);

    late dynamic response;

    response = await query;


    if (response != null) {
      final user = Users.fromJson(response as Map<String, dynamic>);
      return user;
    } else {
      throw Exception('Se produjo un error al realizar la insercción');
    }
  }

  static Future<Savings> insertAbono(int value, String fecha, int id) async {
    final query = Supabase.instance.client.from('payment').insert([
        {'value': value, 'created_at': fecha,},
      ]);

    late dynamic response;

    
    response = await query.eq('id',id);


    if (response != null) {
   
      return response;
    } else {
      throw Exception('Se produjo un error al realizar la insercción');
    }
  }


}

