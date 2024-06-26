
import 'package:agricare/screens/login.dart';
import 'package:window_manager/window_manager.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main()  async  {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();
   WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(1280, 800),
    title: 'AgriCare',
    skipTaskbar: false,
    center: true
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: FluentThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

