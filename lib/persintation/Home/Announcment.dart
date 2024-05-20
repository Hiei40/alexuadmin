
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/Announcement.dart';
import '../../generated/l10n.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

class Announcment extends StatefulWidget {
  const Announcment({super.key});

  @override
  State<Announcment> createState() => _AnnouncmentState();
}

class _AnnouncmentState extends State<Announcment> {

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<HomeCubit>(context).announcement();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).Announcement,
            ),
          ),
          body: Container(
            child: ListView.builder(
              itemBuilder: (context, index) {
                Announcement announcment =
                    context.read<HomeCubit>().data2[index];

                return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(announcment.photo),
                      ),
                      title: Text(announcment.name),
                      subtitle: Text("${announcment.news}"),
                    ));
              },
              itemCount: context.read<HomeCubit>().data2.length,
            ),
          ),
        );
      },
    );
  }
}
