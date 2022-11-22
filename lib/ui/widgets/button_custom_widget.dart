import 'package:codigo2_alerta/ui/general/colors.dart';
import 'package:flutter/material.dart';

class ButtonCustomWidget extends StatelessWidget {
  String text;
  Function onTap;

  ButtonCustomWidget({
    required this.text,
    required this.onTap,
});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();

      },
      child: Container(
        width: double.infinity,
        height: 48.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 4),
              color: kBrandPrimaryColor.withOpacity(0.4),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              kBrandPrimaryColor,
              kBrandPrimaryColor,
              kBrandPrimaryColor,
              kBrandSecondaryColor,
            ],
          ),
        ),
        child: Text(
          text,
        ),

      ),
    );
  }
}
