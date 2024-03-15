import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './view_models/hero_list_view_model.dart';
import './views/hero_list_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // Ensure that plugin services are initialized so that `dotenv` can be used before `runApp`
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: "assets/.env");

  runApp(const MyApp());
}

/// Root widget of the application.
/// Sets up Provider and MaterialApp configuration.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Initialize the HeroListViewModel
      create: (context) => HeroListViewModel(),
      child: MaterialApp(
        title: 'Marvel Heroes',
        theme: ThemeData(
          // Define the default brightness and colors.
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HeroListView(), // Set the HeroListView as the home widget
        debugShowCheckedModeBanner: false, // Disable the debug banner
      ),
    );
  }
}
