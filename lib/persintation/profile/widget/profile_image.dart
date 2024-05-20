import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubit/profile_cubit.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key,required this.image,});
  final String ? image;
  @override
  Widget build(BuildContext context) {
    return image==null ? Container(
      height:80,
      width: 80,
      alignment: Alignment.center,
      child: Text("+",style: TextStyle(
        fontSize: 20,
      ),),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)
      ),
    ) : Container(
      height:80,
      width: 80,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        image:DecorationImage(
          image: NetworkImage(image!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
