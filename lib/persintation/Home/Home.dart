import 'package:alexuadmin/persintation/Home/AddAnouncment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../generated/l10n.dart';
import '../Help/Help.dart';
import '../Settings/Settings.dart';
import '../profile/profile_screen.dart';
import '../subject/subject_screen.dart';
import 'Announcment.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
import '../../../Model/HomeModel.dart'; // consistent import

class Admin extends StatelessWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      SubjectScreen(),
      Announcment(),
      AddAnouncment(),
      Help(),
      Settings(),
    ];

    List<String> HomeList = [
      S.of(context).existingsubjects,
      S.of(context).Announcement,
      S.of(context).Add,
      S.of(context).Help,
      S.of(context).Settings
    ];
    BlocProvider.of<HomeCubit>(context).fetchData();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeDataSucceful) {
          return Scaffold(
            appBar: AppBar(
              actions: [

              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 1000,
                        width: double.infinity,
                        child: GridView.builder(
                          itemBuilder: (context, index) {
                            Subject subject =
                                context.read<HomeCubit>().data[index];

                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => screens[index],
                                  ),
                                );
                              },
                              child: Container(
                                height: 88,
                                width: 150,
                                color: Color(0xff87CEEB),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      "${subject.image}",
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${HomeList[index]}",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: context.read<HomeCubit>().data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 120,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is HomeDataLoaded) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is HomeError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${state.error}"),
            ),
          );
        } else {
          return Scaffold(
            body: Container(),
          );
        }
      },
    );
  }
}
