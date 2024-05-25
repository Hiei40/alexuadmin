import 'package:alexuadmin/persintation/subject/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../../Help/Cubit/help_cubit.dart';
import '../../Home/Home.dart';
import '../cubit/state.dart';

class Feedbacks extends StatelessWidget {
  const Feedbacks({super.key, required this.Subject});
  final String Subject;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController helpNote = TextEditingController();
    var cubit = BlocProvider.of<SubjectCubit>(context);
    cubit.FeedBackFetch(Subject);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Feedback, // Localized text for Feedback title
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<SubjectCubit, SubjectState>(
        builder: (context, state) {
          if (state is FeedBackLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FeedBackSuccefull) {
            if (cubit.FeedBack.isEmpty) {
              return Center(child: Text(S.of(context).NoFeedBaclavailable));
            } else {
              return ListView.builder(
                itemCount: cubit.FeedBack.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(S.of(context).AnonymousStudent),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cubit.FeedBack[index]["NameofSubject"]),
                          Text(cubit.FeedBack[index]["content"]),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else if (state is FeedBackError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
