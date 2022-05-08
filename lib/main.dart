import 'package:atem_interview/home_screen/calendarevent/calendar_names.dart';
import 'package:atem_interview/home_screen/calendarevent/providers/event_provider.dart';
import 'package:atem_interview/home_screen/home_page.dart';
import 'package:atem_interview/home_screen/product/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen/calendarevent/providers/calendar_event_provider.dart';
import 'home_screen/product/product_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // product list api call
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        // Fetch calendar types like local, email etc
        ChangeNotifierProvider<EventProvider>(
          create: (context) => EventProvider(),
        ),
        // Retrieving the events based on the calendar id
        ChangeNotifierProvider<CalendarEventProvider>(
          create: (_) => CalendarEventProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/home',
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => const HomePage(),
            '/calendarevent': (BuildContext context) => const CalendarNames(),
            '/products': (BuildContext context) => const ProductList(),
          }),
    );
  }
}
