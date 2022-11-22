import 'package:codigo2_alerta/ui/general/colors.dart';
import 'package:codigo2_alerta/ui/widgets/general_widget.dart';
import 'package:flutter/material.dart';

class ItemMenuWidget extends StatelessWidget {
  String text;
  Color color;
  IconData icon;
  Function onTap;

  ItemMenuWidget({
    required this.text,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                // color: Colors.red,
                offset: const Offset(0, 4),
                blurRadius: 12.0),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            spacing6,
            Text(
              text,
              style: TextStyle(
                color: kFontPrimaryColor.withOpacity(0.85),
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}