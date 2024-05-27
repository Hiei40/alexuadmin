import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/theme/color_manger/color_mange.dart';
import '../subject/cubit/cubit.dart';
import '../subject/cubit/state.dart';

class WarningPage extends StatelessWidget {
  const WarningPage({super.key,required this.id,required this.name});
  final String ? name;
  final String ? id;
  @override
  Widget build(BuildContext context) {
    SubjectCubit cubit=SubjectCubit.get(context);
    cubit.warning();
    return Scaffold(
      appBar:  AppBar(
        title: Text(""),
      ),
      body:   BlocBuilder<SubjectCubit,SubjectState>(
        builder: (context,state) {
          return cubit.warningList.isEmpty || state is WarningLoadState ? Center(child: CircularProgressIndicator(),) :  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0,top: 20),
                child: Container(width: 320,
                  height: 50,
                  padding: EdgeInsets.only(top: 10,left: 10),
                  child: Text("Students +2",style: TextStyle(
                      fontSize: 12
                  ),),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorManger.main_color,
                  ),),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount:cubit.warningList.length ,
                itemBuilder: (context,i) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0,top: 20),
                    child: Text("${cubit.warningList[i]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                      ),),
                  );
                }
              ),
            ],
          );
        }
      )
      ,
    );
  }
}
