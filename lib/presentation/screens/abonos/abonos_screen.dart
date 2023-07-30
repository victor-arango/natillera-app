// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:natillera_app/presentation/controller/add_abono_controller.dart';
import 'package:natillera_app/presentation/providers/users/list_users_provider.dart';
import 'package:unicons/unicons.dart';
import 'package:customizable_datetime_picker/date_picker_widget.dart';
import '../../../config/colors/customColors.dart';
import '../../../config/utils/screen_size.dart';
import '../widgets/header.dart';





class AbonosPage extends ConsumerStatefulWidget  {
  const AbonosPage({super.key});

  @override
  ConsumerState<AbonosPage> createState() => AbonosPageState();
}
final AddAbonosController _con = AddAbonosController();

class AbonosPageState extends ConsumerState<AbonosPage> {



  DateTime _dateTime = DateTime.now(); 
   @override
  Widget build(BuildContext context) {

   final value = ref.watch(valueProvider);
    return Scaffold(
      
      appBar: header(context, 'Registra Abonos', ''),
      body:Column(
        children: [
          Container(
     margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    height: 150,
    width: screenWidth.getScreenWidth(context: context, multiplier: 0.90),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: getColorBasedOnTheme(
          context, CustomColors.textWhite, CustomColors.headerCircle),
    ),
    child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child:const  Text('Generar Abono por' ),
          ),
          
          Row(
          
                  
            children:  [
              Row(
                children:  [
                  
                  const Icon(UniconsLine.dollar_alt,size: 30,),
                  Text(value.isNotEmpty  ? value : '0', style: const TextStyle(fontSize: 30),)
                ],
              
              ),
            
            ],
          ),
        ],
      ),
    ),
    
    ),
          Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          


          TextField(
           onChanged: (value) {
               ref.read(valueProvider.notifier)
                  .update((state) => value);
           },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              
              hintText: 'Valor ',
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

 CustomizableDatePickerWidget(
                separatorWidget: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    ":",
                  ),
                ),
                locale: DateTimePickerLocale.es,
                looping: true,
                
                initialDate: _dateTime,
                dateFormat: "dd-MMMM-yyyy",                            
                pickerTheme:  DateTimePickerTheme(     
                             
 
                  backgroundColor: getColorBasedOnTheme(context, CustomColors.textWhite, CustomColors.headerCircle),
                  itemHeight: 80,
                  pickerHeight: 70,
                   dividerTheme: DatePickerDividerTheme(
                    dividerColor: getColorBasedOnTheme(context, CustomColors.textWhite, CustomColors.headerCircle),
                    thickness: 0,
                    height: 2
                  )                  
                ),
                
                
              
                onChange: (dateTime, selectedIndex ){
                  _dateTime = dateTime;
              
                
                }

                    

                    
              ),     
          
        ],
      ),
    ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(30),
            
            ),
            child: ElevatedButton(
              onPressed: ()
              {

                _con.registerAbono(context,ref);
                //  ref.read(dateTimeProvider.notifier)
                //   .update((state) => _dateTime.toString());
                 
              },
              style: ElevatedButton.styleFrom(
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child:  const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(child: Text("Generar Abono"))),
            ),
      )
    );
  }
    void refresh() {
    setState(() {});
  }
}
