import 'package:absensi_app/core/core.dart';
import 'package:absensi_app/data/datasources/attendance_remote_datasource.dart';
import 'package:absensi_app/data/datasources/auth_remote_datasource.dart';
import 'package:absensi_app/data/datasources/firebase_messaging_remote_datasource.dart';
import 'package:absensi_app/data/datasources/permission_remote_datasource.dart';
import 'package:absensi_app/firebase_options.dart';
import 'package:absensi_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:absensi_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:absensi_app/presentation/auth/pages/splash_page.dart';
import 'package:absensi_app/presentation/home/bloc/checkin_attendance/checkin_attendance_bloc.dart';
import 'package:absensi_app/presentation/home/bloc/checkout_attendance/checkout_attendance_bloc.dart';
import 'package:absensi_app/presentation/home/bloc/get_attendance_by_date/get_attendances_bloc.dart';
import 'package:absensi_app/presentation/home/bloc/get_company/get_company_bloc.dart';
import 'package:absensi_app/presentation/home/bloc/is_checkdin/is_checkdin_bloc.dart';
import 'package:absensi_app/presentation/home/bloc/permissions/permissions_bloc.dart';
import 'package:absensi_app/presentation/home/bloc/update_user_register/update_user_register_face_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingRemoteDatasource().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdateUserRegisterFaceBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetCompanyBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => IsCheckdinBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckinAttendanceBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckoutAttendanceBloc(AttendanceRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => PermissionsBloc(PermissionRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetAttendancesBloc(AttendanceRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            dividerTheme:
                DividerThemeData(color: AppColors.light.withOpacity(0.5)),
            dialogTheme: const DialogTheme(elevation: 0),
            textTheme: GoogleFonts.kumbhSansTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              color: AppColors.white,
              elevation: 0,
              titleTextStyle: GoogleFonts.kumbhSans(
                color: AppColors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          home: const SplashPage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
