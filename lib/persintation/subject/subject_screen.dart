import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../utils/theme/color_manger/color_mange.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'subject_info.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key});
//
  @override
  Widget build(BuildContext context) {
    SubjectCubit cubit=SubjectCubit.get(context);
    cubit.MyProfile();
    return Scaffold(
      appBar:  AppBar(
        title: Text(S.of(context).YourSubject),
      ),
      body: BlocBuilder<SubjectCubit,SubjectState>(
        builder: (context,state) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0, // Spacing between rows
            ),
                itemCount: cubit.listSubject.length,
                itemBuilder: (c,i){
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                    return SubjectInfo(id:FirebaseAuth.instance.currentUser!.uid, name:cubit.listSubject[i],);
                  }));
                },
                child: Container(
                  color: ColorManger.main_color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40,),
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: ColorManger.dark_container,
                          shape: BoxShape.circle
                        ),
                        child: Text("${i+1}".toString(),style: TextStyle(
                        color: ColorManger.main_color,
                      ),
                      ),
                      ),
                      SizedBox(height: 20,),
                      Text(cubit.listSubject[i]),
                    ],
                  ),
                ),
              );
            }),
          );
        }
      ) ,
    );
  }
}
