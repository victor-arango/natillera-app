import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';


final appRouter = GoRouter(
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => const MenuScreen(),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/form-user',
      builder: (context, state) => const AddFormUserPage(),
    ),

    GoRoute(
      path: '/abonos-user',
      builder: (context, state) => const AbonosPage(),
    ),

    GoRoute(
      path: '/user',
      builder: (context, state) =>  const DetailUserPage(),
    ),

    // GoRoute(
    //   path: '/todo',
    //   builder: (context, state) => const TodoScreen(),
    // ),

    // GoRoute(
    //   path: '/future-provider',
    //   builder: (context, state) => const FutureProviderScreen(),
    // ),

    // GoRoute(
    //   path: '/future-family-provider',
    //   builder: (context, state) => const FamilyFutureScreen(),
    // ),

    // GoRoute(
    //   path: '/stream-provider',
    //   builder: (context, state) => const StreamProviderScreen(),
    // ),

    // GoRoute(
    //   path: '/change-notifier-provider',
    //   builder: (context, state) => const ChangeNotifierScreen(),
    // ),

    // GoRoute(
    //   path: '/state-notifier-provider',
    //   builder: (context, state) => const StateNotifierScreen(),
    // ),



  ]);