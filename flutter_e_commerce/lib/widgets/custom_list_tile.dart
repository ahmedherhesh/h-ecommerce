import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({this.onTap, this.leading, this.title, this.subtitle, this.trailing});
  final onTap;
  final leading;
  final title;
  final subtitle;
  final trailing;
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
        visualDensity: const VisualDensity(vertical: -4),
        onTap: onTap,
        leading: leading,
        title: Text('$title'),
        subtitle: subtitle != null ? Text('$subtitle') : const SizedBox(),
        trailing: trailing ?? const Icon(Icons.arrow_right),
      ),
    );
  }
}
