import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sadykova_app/features/appointment/domain/state/appointment_provider.dart';
import 'package:sadykova_app/features/auth/domain/state/auth_provider.dart';
import 'package:sadykova_app/features/auth/domain/state/user_provider.dart';
import 'package:sadykova_app/features/main/domain/state/home_provider.dart';
import 'package:sadykova_app/features/staffs/domain/state/staff_provider.dart';
import 'package:sadykova_app/navigation/main_swiper_provider.dart';
import 'package:sadykova_app/splash_screen.dart';
import 'features/services/domain/state/service_provider.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final List<SingleChildWidget> providers = [
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
    ),
    ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(),
    ),
    ChangeNotifierProvider<ServiceProvider>(
      create: (_) => ServiceProvider(),
    ),
    ChangeNotifierProvider<StaffProvider>(
      create: (_) => StaffProvider(),
    ),
    ChangeNotifierProvider<AppointmemtProvider>(
      create: (_) => AppointmemtProvider(),
    ),
    ChangeNotifierProvider<MainSwiperProvider>(
      create: (_) => MainSwiperProvider(),
    ),
    ChangeNotifierProxyProvider<UserProvider, AuthProvider>(
      create: (_) => AuthProvider(
        Provider.of<UserProvider>(_, listen: false),
      ),
      update: (_, userProvider, authProvider) => AuthProvider(userProvider),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MultiProvider(
        providers: providers,
        child: MaterialApp(
          scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
          debugShowCheckedModeBanner: false,
          locale: const Locale('ru'),
          theme: ThemeData(
            fontFamily: 'Montserrat-bold',
            scaffoldBackgroundColor: const Color(0xffFAF9F4),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color(0xff66788C),
            ),
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}
