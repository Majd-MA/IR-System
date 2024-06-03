import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/serach/cubit.dart';
import 'package:untitled/serach/search_screen.dart';
import 'core/bloc_observer.dart';
import 'core/dio_helper.dart';

Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor:  const Color(0xff437A99)),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xff282A2C),
        ),
         home: const SearchScreen(),
      ),
    );
  }
}
