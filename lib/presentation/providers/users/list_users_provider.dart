// ignore_for_file: await_only_futures

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:natillera_app/config/helpers/user_information.dart';
import 'package:natillera_app/presentation/models/savings.dart';
import '../../models/users.dart';




//obtiene los usuarios
final listUserProvider = FutureProvider.autoDispose<List<Users>>((ref) async{
  final listUsers = await UserInformation.getUsers('');
  return listUsers;
  
});



//Obienete el valor del id 
final idProvider = StateProvider<int>((ref) {
  return 1;
});


//obtiene los detalles de los abonos del usaurio por id
final getDetailsByIdProvider = FutureProvider.autoDispose<List<Savings>>((ref) async{
    final userId = ref.watch(idProvider);
    final listDetail = await UserInformation.getDetailsById(userId);
  return listDetail;


});




//obtiene detalles de cada usuario
final listDetailUserProvider = FutureProvider<Users> ((ref) async {
   final userId = ref.watch(idProvider);

  final listUsers = await UserInformation.getUserById(userId);
  return listUsers;
});




//Obtiene y devuleve valor del valor a pagar
final valueProvider = StateProvider.autoDispose<String>((ref) => ''); 


//Obtiene el total de abonos 
final totalAbonoStateNotifierProvider = StateNotifierProvider<TotalSavingsNotifier, int>((ref) {
  return TotalSavingsNotifier();
});
class TotalSavingsNotifier extends StateNotifier<int> {
  TotalSavingsNotifier() : super(0);

  void updateTotalSavings(int value)async {
   await state ; 
   state= value;
  }
}


//Obtiene el total del ahorro 
final totalAhorroStateNotifierProvider = StateNotifierProvider<TotalAhorroNotifier, int>((ref) {
  return TotalAhorroNotifier();
});
class TotalAhorroNotifier extends StateNotifier<int> {
  TotalAhorroNotifier() : super(0);

  void updateTotalAhorro(int value)async {
   await state ; 
   state= value;
  }
}


//calcula el porcentaje
// final porcentageProvider = FutureProvider<double> ((ref) async {
//    final totalSaving = ref.watch(totalSavingProvider);
//    final totalAhorro = ref.watch(totalSavingsProvider);

//   double porcentage = (totalAhorro / totalSaving) * 100;

//   print(porcentage); 
//   return  porcentage;
// });
