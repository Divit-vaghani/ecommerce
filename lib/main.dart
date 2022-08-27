import 'package:ecommerce/blocs/shopping_bloc.dart';
import 'package:ecommerce/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Ecommerce());
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShoppingBloc>(
      create: (context) => ShoppingBloc(),
      child: MaterialApp(
        title: 'Ecommerce App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
