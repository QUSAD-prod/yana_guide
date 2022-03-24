import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yana_guide/button_back.dart';
import 'package:yana_guide/custom_behaviour.dart';
import 'package:yana_guide/organization.dart';

class SearchPage extends StatefulWidget {
  const SearchPage.dataConstructor(this.data, this.box, {Key? key})
      : super(key: key);
  final List<Map<String, dynamic>> data;
  final Map<String, dynamic> box;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  child: widget.data.isNotEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: getSearchResults(width),
                        )
                      : const Center(
                          child: Text(
                            "Ничего не найдено",
                            style: TextStyle(
                              color: Color(0xFF232425),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 0.98,
                            ),
                            textAlign: TextAlign.center,
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

  //Получение результатов поиска
  List<Widget> getSearchResults(double width) {
    List<Widget> export = [];
    for (int i = 0; i < widget.data.length; i++) {
      Map<String, dynamic> temp = widget.data[i];
      export.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.transparent,
            onTap: temp['value'] is Map
                ? () => Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) =>
                            Organization.dataConstructor(
                          Map<String, dynamic>.from(temp['value'] as Map),
                          name: temp['name'],
                          iconPath: getPathIcon(temp['category']),
                        ),
                      ),
                    )
                : () => Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) =>
                            Organization.dataConstructor(
                          getData(temp['path']),
                          name: (temp['path'] as String).split('/')[
                              (temp['path'] as String).split('/').length - 1],
                          iconPath: getPathIcon(temp['category']),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          temp['path'],
                          style: const TextStyle(
                            color: Color(0xFF868686),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 0.98,
                          ),
                        ),
                        Container(
                          height: 4.0,
                        ),
                        temp['value'] is! Map
                            ? Text(
                                temp['name'] + ': ' + temp['value'],
                                style: const TextStyle(
                                  color: Color(0xFF232425),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  height: 0.98,
                                ),
                              )
                            : Text(
                                temp['name'],
                                style: const TextStyle(
                                  color: Color(0xFF232425),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  height: 0.98,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.075),
                    child: SvgPicture.asset('assets/arrow.svg'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i + 1 < widget.data.length) {
        export.add(
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            height: 1,
            color: const Color(0xFF868686).withOpacity(0.1),
          ),
        );
      }
    }
    return export;
  }

  //Получение иконки
  String getPathIcon(String input) {
    switch (input) {
      case "Правоохранительные органы":
        return 'assets/main_root_icons/town_hall.svg';
      case "Обслуживающие организации":
        return 'assets/main_root_icons/creative_commons.svg';
      case "Культура и спорт":
        return 'assets/main_root_icons/supervised_user.svg';
      case "Социальная сфера":
        return 'assets/main_root_icons/chat.svg';
      case 'Власть':
        return 'assets/main_root_icons/user.svg';
      case 'Медицина':
        return 'assets/main_root_icons/medicine.svg';
      case 'Образование':
        return 'assets/main_root_icons/book.svg';
      case 'Безопасность':
        return 'assets/main_root_icons/safe_square.svg';
      case 'Торговля':
        return 'assets/main_root_icons/shopping_basket.svg';
      case 'Услуги':
        return 'assets/main_root_icons/products.svg';
      case 'СМИ':
        return 'assets/main_root_icons/news.svg';
      default:
        return 'assets/main_root_icons/other.svg';
    }
  }

  //Получение данных
  Map<String, dynamic> getData(String input) {
    List<String> list = input.split('/');
    Map<String, dynamic> data = widget.box;
    while (list.isNotEmpty) {
      Map<String, dynamic> temp = data[list[0]];
      data = temp;
      list.remove(list[0]);
    }
    return data;
  }
}
