// ignore_for_file: camel_case_types, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers
import 'dart:core';

import 'package:countup/countup.dart';
// ignore: unused_import
import 'package:flutter/scheduler.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:natillera_app/presentation/models/savings.dart';
import 'package:natillera_app/presentation/providers/users/list_users_provider.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:unicons/unicons.dart';

import '../../../config/colors/customColors.dart';
import '../../../config/utils/screen_size.dart';
import '../widgets/header.dart';

class DetailUserPage extends StatefulWidget {
  const DetailUserPage({super.key});
  @override
  State<DetailUserPage> createState() => _DetailUserPageState();
}

class _DetailUserPageState extends State<DetailUserPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, 'Detalle Usuario', ''),
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.only(top: 20, bottom: 40),
                    child: const userDetail(),
                  ),
                  const circularGrafic(),

                  // const graficoCircularAnimated(),
                  const buttonsDetail(),

                  //Title Abonos
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Abonos: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),

                  const savinsTable(),
                ],
              )
            ]))
          ],
        ));
  }

  void refresh() {
    setState(() {});
  }
}
class circularGrafic extends ConsumerWidget {
  const circularGrafic({
     super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 120.0,
      child: FutureBuilder<void>(
        future: _delayedFuture(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Retorno del widget mientras esperamos el retraso de 3 segundos
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // El retraso de 3 segundos ha terminado, mostramos el SemicircularIndicator.
            final totalSaving = ref.watch(totalAbonoStateNotifierProvider);
            final totalAhorro = ref.watch(totalAhorroStateNotifierProvider);
    
            double total = (totalSaving / totalAhorro) * 100;
            double factor = total.roundToDouble();
            double totalParse = total / 100;
            double totalParseDouble = double.parse(totalParse.toStringAsFixed(2));
    
            double totalParseDoubleMax;
            if (totalParseDouble > 0.99) {
              totalParseDoubleMax = 1;
            } else {
              totalParseDoubleMax = totalParseDouble;
            }
    
            return SemicircularIndicator(
              progress: totalParseDoubleMax,
              color: getColorBasedOnTheme(
                  context, CustomColors.blueDark, CustomColors.blueDark),
              bottomPadding: 20,
              child: Text(
                '$factor %',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  // color: Colors.orange
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _delayedFuture() {
    // Creamos la futura con un retraso de 3 segundos.
    return Future.delayed(const Duration(seconds: 2));
  }
}


class userDetail extends ConsumerWidget {
  const userDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(listDetailUserProvider);

    return user.when(
      data: (user) => userProgramingSaving(
        name: user.name,
        saving: user.saving.toDouble(),
        lasName: user.apellido,
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('Error al cargar los usuarios: $error'),
    );
  }
}

class userProgramingSaving extends ConsumerWidget {
  final String name;
  final double saving;
  final String lasName;
  const userProgramingSaving(
      {super.key,
      required this.name,
      required this.saving,
      required this.lasName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

          ref.read(totalAhorroStateNotifierProvider.notifier).updateTotalAhorro(saving.toInt());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ahorro programado ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text('$name $lasName'),
          ],
        ),
        Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
              color: getColorBasedOnTheme(
                  context, CustomColors.textWhite, CustomColors.headerCircle),
              borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  '\$',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 0.5,
                  ),
                ),
                Countup(
                  begin: 0,
                  end: saving,
                  duration: const Duration(milliseconds: 1500),
                  separator: '.',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 0.5,
                  ),
                ),

                  

              ],
            ),
          ),
        ),
      ],
    );
  }
}

class buttonsDetail extends StatelessWidget {
  const buttonsDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: 90,
      width: screenWidth.getScreenWidth(context: context, multiplier: 0.90),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: getColorBasedOnTheme(
            context, CustomColors.textWhite, CustomColors.headerCircle),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: getColorBasedOnTheme(
                        context, CustomColors.blueDark, CustomColors.blueDark)),
                child: IconButton(
                  onPressed: () {
                    GoRouter.of(context).go('/abonos-user');
                  },
                  icon: const Icon(UniconsLine.wallet),
                  color: getColorBasedOnTheme(
                      context, CustomColors.textWhite, CustomColors.textWhite),
                ),
              ),
              const Text('Abonos')
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: getColorBasedOnTheme(
                        context, CustomColors.blueDark, CustomColors.blueDark)),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(UniconsLine.money_bill),
                    color: getColorBasedOnTheme(context, CustomColors.textWhite,
                        CustomColors.textWhite)),
              ),
              const Text('Credito')
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: getColorBasedOnTheme(
                        context, CustomColors.blueDark, CustomColors.blueDark)),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(UniconsThinline.create_dashboard),
                    color: getColorBasedOnTheme(context, CustomColors.textWhite,
                        CustomColors.textWhite)),
              ),
              const Text('Balance')
            ],
          ),
        ],
      ),
    );
  }
}

class savinsTable extends ConsumerWidget {
  const savinsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailTableAbono = ref.watch(getDetailsByIdProvider);
    int cuota = 0;
    int valueAbonos = 0;

    return detailTableAbono.when(
      data: (data) {
        final List<Savings> savingsList = data;

        // Calcular la suma de los savings.value
        valueAbonos = savingsList.fold(
            0, (previousValue, savings) => previousValue + savings.value);

                  ref.read(totalAbonoStateNotifierProvider.notifier).updateTotalSavings(valueAbonos);



        ScrollController _scrollController = ScrollController();

        return data.isEmpty
            ? Container(
                width: screenWidth.getScreenWidth(
                    context: context, multiplier: 0.90),
                height: screenHeight.getScreenHeight(
                    context: context, multiplier: 0.40),
                decoration: BoxDecoration(
                  color: getColorBasedOnTheme(context, CustomColors.textWhite,
                      CustomColors.headerCircle),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text('No se encontraron Abonos '),
                ),
              )
            : Column(children: [
                Container(
                    width: screenWidth.getScreenWidth(
                        context: context, multiplier: 0.90),
                    height: screenHeight.getScreenHeight(
                        context: context, multiplier: 0.40),
                    decoration: BoxDecoration(
                      color: getColorBasedOnTheme(context,
                          CustomColors.textWhite, CustomColors.headerCircle),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      interactive: false,
                      thickness: 2.0,
                      child: CustomScrollView(
                        controller:
                            _scrollController, // Asociar el ScrollController al CustomScrollView
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate([
                              DataTable(
                                columns: const [
                                  DataColumn(label: Text('Cuota')),
                                  DataColumn(label: Text('Fecha')),
                                  DataColumn(label: Text('Valor')),
                                ],
                                rows: savingsList.map<DataRow>((savings) {
                                  cuota++;
                                  return DataRow(cells: [
                                    DataCell(Text(cuota.toString())),
                                    DataCell(
                                        Text(savings.created_at.toString())),
                                    DataCell(Text(savings.value.toString())),
                                  ]);
                                }).toList(),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                 
                  width: screenWidth.getScreenWidth(
                      context: context, multiplier: 0.90),
                  child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Ahorrado', style: TextStyle(fontSize: 20),),
                      Row(
                        children: [
                          const Icon(Icons.monetization_on_rounded),
                          const SizedBox(width: 7),
                          Text(valueAbonos.toString(), style: const TextStyle(fontSize: 25),)
                        ],
                      )
               
                    ],
                  ),
                ),
              ]);
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) =>
          Text('Error al cargar los detalles: $error'),
    );
  }
}









