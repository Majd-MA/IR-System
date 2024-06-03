import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/serach/cubit.dart';
import 'package:untitled/serach/state.dart';

import 'expandable_text.dart';

class SearchResult extends StatelessWidget {
  String correction;
   SearchResult({super.key,required this.correction});

  @override
  Widget build(BuildContext context) {
    var cubit = SearchCubit.get(context);
    return BlocConsumer<SearchCubit,SearchState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(child: const Icon(Icons.arrow_back_ios, color: Colors.white),onTap: ()=>Navigator.pop(context),),
          backgroundColor: const Color(0xff282A2C),
          title: const Text('Search result',style: TextStyle(color:Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              correction.isEmpty ?const SizedBox.shrink():
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Correction Text :',style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 18)),
              ),
              correction.isEmpty ?const SizedBox.shrink():
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 10),
                child: Text(correction,style: const TextStyle(color:Colors.white,fontWeight: FontWeight.w400,fontSize: 16),),
              ),
              correction.isEmpty ?const SizedBox.shrink():
              const SizedBox(height: 10),
              correction.isEmpty ?const SizedBox.shrink():
              const Divider(
                thickness: 0.5,
                color: Color(0xff939393),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Suggestions :',style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 18),),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.modelSearchTow.documents?.first.length ??0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( '${index+1} -  '   ,style: const TextStyle(color:Colors.white),),
                          Expanded(
                            child: Text(
                              cubit.modelSearchTow.documents!.first[index].toString()
                              ,style: const TextStyle(color:Colors.white,fontWeight: FontWeight.w400,fontSize: 16), maxLines:10,
                              overflow: TextOverflow.visible,),
                          ),
                        ],
                      ),
                    );
                  }, ),
              const SizedBox(height: 10),

              const Divider(
                thickness: 0.5,
                color: Color(0xff939393),
              ),
              const SizedBox(height: 10),
              state is PostAntiqueLoadingState
                  ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 150),
                    child: Center(child: CircularProgressIndicator(backgroundColor: Color(0xff437A99))),
                  )
                  :
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.modelSearch.documents?.first.length ??0,
                itemBuilder: (context, index) {
                  return  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: const Color(0xff2D2F31),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: 9,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if(cubit.modelSearch.distances!.first[index] < 0.7)...{
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'distances : ${ cubit.modelSearch.distances!.first[index]}',
                                    style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          },
                          if( cubit.modelSearch.distances!.first[index] > 0.7 )...{
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'distances : ${ cubit.modelSearch.distances!.first[index]}',
                                    style: const TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          },

                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                            child: ExpandableText(
                              text:cubit.modelSearch.documents!.first[index],
                              textStyle: const TextStyle(color:Color(0xff939393),fontWeight: FontWeight.w500,fontSize: 16),
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }, listener: ( context,state) {  },);
  }
}
