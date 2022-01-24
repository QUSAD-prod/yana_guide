import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yana_guide/button_back.dart';
import 'package:yana_guide/custom_behaviour.dart';

class Category extends StatefulWidget {
  const Category.dataConstuctor(this.data, {Key? key}) : super(key: key);

  final Map<String, String> data;

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Scrollbar(
        isAlwaysShown: true,
        radius: const Radius.circular(15),
        thickness: width * 0.015,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: width * 0.06,
          ),
          child: ScrollConfiguration(
            behavior: NoPhysicsBehavior(),
            child: ListView(
              children: [
                //Возврат к пред. странице
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ButtonBack(
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                //Обложка
                Container(
                  width: width * 0.88,
                  padding: EdgeInsets.symmetric(vertical: height * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        offset: const Offset(0.0, 4.0),
                        blurRadius: 36.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: width * 0.25,
                          height: width * 0.25,
                          decoration: BoxDecoration(
                            color: Color(int.parse(widget.data['color']!)),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              widget.data['icon']!,
                              width: width * 0.12,
                              height: width * 0.12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          widget.data['category']!,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            height: 0.97,
                            color: Color(0xFF232425),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
