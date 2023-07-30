// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../config/colors/customColors.dart';
import '../../../config/utils/screen_size.dart';
import '../../controller/add_user_controller.dart';
import '../widgets/header.dart';


class AddFormUserPage extends StatefulWidget {
  const AddFormUserPage({super.key});

  @override
  State<AddFormUserPage> createState() => _AddFormUserPageState();
}

class _AddFormUserPageState extends State<AddFormUserPage> {

  final AddUserController _con = AddUserController();
  

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Agregar Usuario', 'Agrega los nuevos socios de la natillera'),
      bottomNavigationBar:Container(
        padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(30),
            
            ),
            child: ElevatedButton(
              onPressed:
                _con.registerUser
              ,
              style: ElevatedButton.styleFrom(
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child:  const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(child: Text("Agregar Socio"))),
            ),
          ), 
      
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([
            Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
              height: screenHeight.getScreenHeight(context: context, multiplier: 0.45),
              child: Image.asset('assets/images/add_user_form.png')),
      

          TextField(
            controller: _con.nameController,
            decoration: InputDecoration(
              //  getColorBasedOnTheme( context ,CustomColors.TextWhite , CustomColors.HeaderCircle
              hintText: 'Nombre ',
              filled: true,
              fillColor: getColorBasedOnTheme(context, CustomColors.textWhite, CustomColors.headerCircle),
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding:const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: CustomColors.greyBorder),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:const  BorderSide(color: CustomColors.greyBorder),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
         const  SizedBox(height: 30),
          TextField(
            controller: _con.lastNameController,
            decoration: InputDecoration(
              //  getColorBasedOnTheme( context ,CustomColors.TextWhite , CustomColors.HeaderCircle
              hintText: 'Apellido ',
              filled: true,
              fillColor: getColorBasedOnTheme(context, CustomColors.textWhite, CustomColors.headerCircle),
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding:const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: CustomColors.greyBorder),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:const  BorderSide(color: CustomColors.greyBorder),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          
          const SizedBox(height: 40),
          TextField(
            controller: _con.savingsController,
            decoration: InputDecoration(
              //  getColorBasedOnTheme( context ,CustomColors.TextWhite , CustomColors.HeaderCircle
              hintText: 'Ahorro Programado ',
              filled: true,
              fillColor: getColorBasedOnTheme(context, CustomColors.textWhite, CustomColors.headerCircle),
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding:const EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: CustomColors.greyBorder),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:const  BorderSide(color: CustomColors.greyBorder),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          
          
          
          
        ],
      ),
    )
          ]))
        ],
      )
    );
  }
}
