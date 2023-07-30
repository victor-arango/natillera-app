
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:natillera_app/presentation/providers/users/list_users_provider.dart';
import 'package:natillera_app/presentation/screens/widgets/header.dart';

import '../../../config/colors/customColors.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: header(context, 'Hola', 'Estos son los socios'),
      body:const _ListUser()
    );
    
   
  }
    
}






class _ListUser extends ConsumerWidget{
  const _ListUser();


  @override
  Widget build(BuildContext context, WidgetRef ref){
    
  
    return Column(
      children: [

        addUser(context),
        const SizedBox(height: 10,),

        Expanded(
          child: Consumer(
          builder: (context, watch, _) {
            final listUsers = ref.watch(listUserProvider);
        
            return listUsers.when(
              data: (usersList) => ListView.builder(
          itemCount: usersList.length,
          itemBuilder: (context, index) {
            final user = usersList[index];
            return GestureDetector(
              onTap: (){
                

                 int idUser = user.id!;
                ref.read(idProvider.notifier)
            .update((state) => idUser );
               
              GoRouter.of(context).go('/user');

                
              },
              child: ListPartners(name: user.name, socio: user.id.toString(), lasName: user.apellido,));
          },
              ),
              loading: () => const Center(child:  CircularProgressIndicator()),
              error: (error, _) => Text('Error al cargar los usuarios: $error'),
            );
          },
        ),
        )

      ],
    );
  }
  


}






class ListPartners extends ConsumerWidget {
  final String socio;
  final String name ;
  final String lasName ;
  
  const ListPartners({
    super.key,
    required this.name, 
    required this.socio,
    required this.lasName,
  });



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: getColorBasedOnTheme(
                context,
                CustomColors.textWhite,
                CustomColors.headerCircle,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        color: Colors.orange,
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          Icons.person,
                          color: getColorBasedOnTheme(
                            context,
                            CustomColors.textWhite,
                            CustomColors.textWhite,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$name $lasName',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Socio # $socio',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.more_vert),
              ],
            ),
          ),
        );
  }
}

Widget addUser(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 25),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
    child: ListTile(
      title: const Text('Agregar nuevo usuario'),
      trailing: IconButton(
          onPressed: () {
            GoRouter.of(context).go('/form-user');
          },
          icon: const Icon(Icons.add)),
    ),
  );
}
