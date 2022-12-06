import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({this.onTap, this.leading, this.title});
  final onTap;
  final leading;
  final title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0xffdddddd),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: leading,
        title: Text('$title'),
        trailing: const Icon(Icons.arrow_right),
      ),
    );
  }
}
