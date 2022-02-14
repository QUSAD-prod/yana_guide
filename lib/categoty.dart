import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yana_guide/button_back.dart';
import 'package:yana_guide/custom_behaviour.dart';
import 'package:yana_guide/organization.dart';

class Category extends StatefulWidget {
  const Category.dataConstructor(this.data, {Key? key}) : super(key: key);

  final Map<String, String> data;

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Box<dynamic> box = Hive.box('data');
  late Map<String, dynamic> data;
  late List<Map<String, dynamic>> list;

  @override
  void initState() {
    super.initState();
    data = Map<String, dynamic>.from(box.get('data', defaultValue: {}));
    list = getList(data);
  }

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
                  margin: const EdgeInsets.only(bottom: 12.0),
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
                //Список
                Container(
                  width: width * 0.88,
                  margin: const EdgeInsets.only(bottom: 18),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        offset: const Offset(0.0, 4.0),
                        blurRadius: 36.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: getWidgetList(width),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Получение элементов списка
  List<Map<String, dynamic>> getList(Map<String, dynamic> input) {
    List<Map<String, dynamic>> output = [];
    if (input[widget.data['category']] != null) {
      Map<String, dynamic> category =
          Map<String, dynamic>.from(input[widget.data['category']]);
      category.forEach(
        (key, value) {
          Map<String, dynamic> temp = {
            'name': key.toString(),
            'child': value,
          };
          output.add(temp);
        },
      );
    }
    return output;
  }

  //Получение виджетов списка
  List<Widget> getWidgetList(double width) {
    List<Widget> widgetList = [];
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        widgetList.add(
          Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.transparent,
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (BuildContext context) =>
                      Organization.dataConstructor(
                    Map<String, dynamic>.from(list[i]['child'] as Map),
                    name: list[i]['name'],
                    iconPath: widget.data['icon']!,
                  ),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 24,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        list[i]['name'],
                        style: const TextStyle(
                          color: Color(0xFF232425),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 0.98,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.1),
                      child: SvgPicture.asset('assets/arrow.svg'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        if (i + 1 < list.length) {
          widgetList.add(
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              height: 1,
              color: const Color(0xFF868686).withOpacity(0.1),
            ),
          );
        }
      }
    } else {
      widgetList.add(
        const Center(
          child: Text(
            "Пока здесь пусто",
            style: TextStyle(
              color: Color(0xFF232425),
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 0.98,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return widgetList;
  }
}
