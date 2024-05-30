import 'package:agricare/constants/layout.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter Demo',
      theme: FluentThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: const LayoutScreen(),
    );
  }
}

