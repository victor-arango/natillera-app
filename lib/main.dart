import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:natillera_app/presentation/providers/providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';

void main() async {

   WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  //inicializando supabase
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey,
  authFlowType: AuthFlowType.pkce,
  );
  runApp(
   const ProviderScope(child:MyApp())
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isaDarkMode = ref.watch(isDarkModeProvider);
    return MaterialApp.router(
      title: 'Natillera-App',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme( isDarkmode: isaDarkMode ).getTheme(),
    
    );
  }
}

