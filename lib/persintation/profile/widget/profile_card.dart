import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key,required this.title,required this.body,});
  final String ? title;
  final String ? body;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: MediaQuery.of(context).size.height*.0921375921375921,
        width:MediaQuery.of(context).size.width* .8346666666666667,
        decoration: BoxDecoration(
          color: Color(0xFF87CEEB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0,top: 10),
              child: Text(title!,style: TextStyle(
                color: Colors.white,
              ),),
            ),
            SizedBox(
              width: double.infinity,
              height: 15,
              child: Divider(
                height: 1,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,),
              child: Text(body==null?"no data now":"${body!}"),
            ),
          ],
        ),
      ),
    );
  }
}
