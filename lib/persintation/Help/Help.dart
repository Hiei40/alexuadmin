import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';
import '../Home/Home.dart';
import 'Cubit/help_cubit.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController helpNote = TextEditingController();
    BlocProvider.of<HelpCubit>(context).fetchHelpData();

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Help),
      ),
      body: BlocBuilder<HelpCubit, HelpState>(
        builder: (context, state) {
          if (state is HelpInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HelpDataFetchedSuccessfully) {
            final listSubject = BlocProvider.of<HelpCubit>(context).Help;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = listSubject[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: ListTile(
                      title: Text(item['Email'] ?? 'No Email'),
                      subtitle: Text(item['content'] ?? 'No Content'),
                    ),
                  );
                },
                itemCount: listSubject.length,
              ),
            );
          } else if (state is HelpDataFetchFailed) {
            return Center(child: Text('Failed to load help data: ${state.error}'));
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
