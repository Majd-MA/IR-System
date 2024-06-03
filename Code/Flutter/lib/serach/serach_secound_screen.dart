import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:languagetool_textfield/core/controllers/language_tool_controller.dart';
import 'package:untitled/serach/cubit.dart';
import 'package:untitled/serach/serach_result.dart';
import 'package:untitled/serach/state.dart';

class SearchInputScreen extends StatefulWidget {
  const SearchInputScreen({super.key});

  @override
  _SearchInputScreenState createState() => _SearchInputScreenState();
}

class _SearchInputScreenState extends State<SearchInputScreen> {
  LanguageToolController _controller = LanguageToolController();

  @override
  Widget build(BuildContext context) {
    var cubit = SearchCubit.get(context);
    return BlocConsumer<SearchCubit, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              child: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onTap: () => Navigator.pop(context),
            ),
            backgroundColor: const Color(0xff282A2C),
            title: TextFormField(
              controller: _controller,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                cubit.postOnSearchAntique(query: value.toString());
              },
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    SearchCubit.get(context)
                        .postAntique(query: _controller.text);
                    cubit.postOnSearchAntique(query: _controller.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchResult(correction: _controller.text)),
                    );
                  },
                  icon: const Icon(Icons.search_rounded,
                      color: Colors.white, size: 25),
                ),
              )
            ],
          ),
          body: state is PostAntiqueLoadingState
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 150),
                  child: Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Color(0xff437A99))),
                )
              : ListView.separated(
                  itemCount: cubit.modelSearchTow.documents?.first.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        cubit.modelSearchTow.documents!.first[index].toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        SearchCubit.get(context).postAntique(
                            query: cubit.modelSearchTow.documents!.first[index]
                                .toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchResult(correction: _controller.text)),
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 0.5,
                      color: Color(0xff939393),
                    );
                  },
                ),
        );
      },
      listener: (context, state) {},
    );
  }
}
