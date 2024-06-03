import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/serach/cubit.dart';
import 'package:untitled/serach/serach_secound_screen.dart';
import 'package:untitled/serach/serach_secound_screen_lotte.dart';
import 'package:untitled/serach/state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = SearchCubit.get(context);
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 150),
              Center(
                child: Image.asset(
                  'assets/WBH-search.png',
                  width: 250,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Align(
                  alignment:Alignment.center,
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
          
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SearchInputScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: const Color(0xff437A99),
                        ),
                        child: const Text(
                          'Antique DataSet',
                          style: TextStyle(color: Colors.white),
                        )
          
          
                        , ),
                  ),
                ),
              ) ,Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Align(
                  alignment:Alignment.center,
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SearchInputScreenLotte()),
                          );
          
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: const Color(0xff437A99),
                        ),
                        child: const Text(
                          '  Lotte DataSet',
                          style: TextStyle(color: Colors.white),
                        ) ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
