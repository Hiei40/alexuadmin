import 'package:alexuadmin/persintation/subject/progress/Progress%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/l10n.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class Progress extends StatefulWidget {
  const Progress({Key? key, required this.level, required this.subject}) : super(key: key);
  final String level;
  final String subject;

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  late SubjectCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<SubjectCubit>(context);
    _cubit.ProgressFetch(widget.level);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Progress,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<SubjectCubit, SubjectState>(
        builder: (context, state) {
          if (state is ProgressLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProgressSuccefull) {
            if (_cubit.Progress.isEmpty) {
              return Column(
                children: [
                  Center(child: Text(S.of(context).NoStudentavailable)),
                ],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: _cubit.Progress.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProgressScreen(
                              email: _cubit.Progress[index]["email"],
                              subject: widget.subject, Name: _cubit.Progress[index]["name"],
                            ), // Navigate to ProgressScreen
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(_cubit.Progress[index]["name"]),
                          subtitle: Text(_cubit.Progress[index]["email"]),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          } else if (state is ProgressError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: _cubit.Progress.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProgressScreen(
                            email: _cubit.Progress[index]["email"],
                            subject: widget.subject, Name:  _cubit.Progress[index]["name"]
                          ), // Navigate to ProgressScreen
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(_cubit.Progress[index]["name"]),
                        subtitle: Text(_cubit.Progress[index]["email"]),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
