import 'package:flutter/material.dart';

class ProfileDropDownMenu extends StatelessWidget {
  const ProfileDropDownMenu({
    super.key,
    required this.title,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.validator,
  });

  final String? title;
  final List<String> items;
  final String? selectedValue;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1591375921375921,
        width: MediaQuery.of(context).size.width * 0.8846666666666667,
        decoration: BoxDecoration(
          color: Color(0xFF87CEEB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Text(
                title!,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 15,
              child: Divider(
                height: 1,
                color: Colors.white,
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButtonFormField<String>(
                  value: selectedValue,
                  onChanged: onChanged,
                  validator: validator,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: false,
                  ),
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
