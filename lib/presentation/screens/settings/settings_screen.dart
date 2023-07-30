// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:natillera_app/config/colors/customColors.dart';
import 'package:natillera_app/presentation/providers/providers.dart';


class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDarkMode = ref.watch(isDarkModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones'),
      ),
      body: Column(
        children: [
         const  SizedBox(height: 20,),
          SwitchListTile(
            secondary: Icon(isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined, color: getColorBasedOnTheme(context, CustomColors.blueLight, CustomColors.blueDark)),
            title:  isDarkMode ? const Text('Light  Mode') : const Text('Dark Mode'),
            value: ref.read(isDarkModeProvider),
            onChanged: (value) {
              ref.read(isDarkModeProvider.notifier).update((state) => !state);
              if (value) {
                isDarkMode; // Cambiar al tema claro (light)
              } else {
                isDarkMode; // Cambiar al tema claro (light)
              }
            },
          ),
        ],
      ),
    );
  }
}
