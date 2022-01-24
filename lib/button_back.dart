import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({required this.onTap, Key? key}) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_back,
              color: Color(0xFF868686),
            ),
            Container(
              width: 8.0,
            ),
            const Text(
              "Вернуться назад",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF868686),
                height: 0.98,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
