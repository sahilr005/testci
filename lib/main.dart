import 'package:flexable/config/apiconst.dart';
import 'package:flexable/config/const.dart';
import 'package:flexable/controller/utils/network_dio/network_dio.dart';
import 'package:flexable/view/auth/login.dart';
import 'package:flexable/view/auth/signup.dart';
import 'package:flexable/view/home.dart';
import 'package:flexable/view/dats/qr_details.dart';
import 'package:flexable/view/dats/qrview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flexable/view/auth/splach.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  NetworkDioHttp.setDynamicHeader(endPoint: ApiAppConstants.apiEndPoint);
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabasetoken,
    authCallbackUrlHostname: 'marketplace.dev.flexabledats.com',
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'flexable',
      debugShowCheckedModeBanner: false,
      initialRoute: 'splach',
      routes: {
        'splach': (_) => const SplachScreen(),
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignUpPage(),
        '/home': (_) => const HomeScreen(),
        '/QrCodeView': (_) => const QrCodeView(),
        '/QrDetails': (_) => const QrDetailsScreen(),
      },
      theme: ThemeData(
        fontFamily: "Baskerville",
        primarySwatch: Colors.blue,
      ),
      home: const SplachScreen(),
    );
  }
}
