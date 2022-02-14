import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yana_guide/button_back.dart';
import 'package:yana_guide/custom_behaviour.dart';

class Organization extends StatefulWidget {
  const Organization.dataConstructor(
    this.data, {
    Key? key,
    required this.iconPath,
    required this.name,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final String iconPath;
  final String name;

  @override
  State<Organization> createState() => _OrganizationState();
}

class _OrganizationState extends State<Organization> {
  late List<Map<String, dynamic>> list;

  @override
  void initState() {
    super.initState();
    list = getList(widget.data);
  }

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
                //Заголовок
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: width * 0.88,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 14),
                        child: SvgPicture.asset(widget.iconPath),
                      ),
                      Expanded(
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            color: Color(0xFF232425),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 0.98,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                //Основные данные
                Container(
                  width: width * 0.88,
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: getMainDataWidgets(width),
                  ),
                ),
                //Специалисты и другое
                list.isNotEmpty
                    ? Container(
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
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //получение данных
  List<Map<String, dynamic>> getList(input) {
    List<Map<String, dynamic>> output = [];
    input.forEach(
      (key, value) {
        if (key != 'Адрес' &&
            key != 'Телефон' &&
            key != 'Почта' &&
            key != 'Телефон 1' &&
            key != 'Телефон 2' &&
            key != 'Факс') {
          Map<String, dynamic> temp = {
            'name': key.toString(),
            'child': value,
          };
          output.add(temp);
        }
      },
    );
    return output;
  }

  //Получение главных данных
  List<Widget> getMainDataWidgets(double width) {
    List<Widget> widgetList = [];
    if (widget.data['Адрес'] != null) {
      widgetList.add(getMainDataWidget(width, widget.data, 'Адрес'));
      if (widget.data['Телефон'] != null || widget.data['Почта'] != null) {
        widgetList.add(
          Container(
            height: 1,
            color: const Color(0xFF868686).withOpacity(0.1),
          ),
        );
      }
    }
    if (widget.data['Телефон'] != null) {
      widgetList.add(getMainDataWidget(width, widget.data, 'Телефон'));
      if (widget.data['Телефон 1'] != null) {
        widgetList.add(
          Container(
            height: 1,
            color: const Color(0xFF868686).withOpacity(0.1),
          ),
        );
      }
    }
    if (widget.data['Телефон 1'] != null) {
      widgetList.add(getMainDataWidget(width, widget.data, 'Телефон 1'));
      if (widget.data['Телефон 2'] != null) {
        widgetList.add(
          Container(
            height: 1,
            color: const Color(0xFF868686).withOpacity(0.1),
          ),
        );
      }
    }
    if (widget.data['Телефон 2'] != null) {
      widgetList.add(getMainDataWidget(width, widget.data, 'Телефон 2'));
      if (widget.data['Факс'] != null) {
        widgetList.add(
          Container(
            height: 1,
            color: const Color(0xFF868686).withOpacity(0.1),
          ),
        );
      }
    }
    if (widget.data['Факс'] != null) {
      widgetList.add(getMainDataWidget(width, widget.data, 'Факс'));
      if (widget.data['Почта'] != null) {
        widgetList.add(
          Container(
            height: 1,
            color: const Color(0xFF868686).withOpacity(0.1),
          ),
        );
      }
    }
    if (widget.data['Почта'] != null) {
      widgetList.add(getMainDataWidget(width, widget.data, 'Почта'));
    }
    return widgetList;
  }

  //Виджет главных данных
  Widget getMainDataWidget(
    double width,
    Map<String, dynamic> data,
    String key,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: width * 0.135,
            height: width * 0.135,
            decoration: BoxDecoration(
              color: const Color(0xFFE8ECF9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                key == 'Адрес'
                    ? 'assets/adress.svg'
                    : key == 'Телефон' ||
                            key == 'Телефон 1' ||
                            key == 'Телефон 2'
                        ? 'assets/phone.svg'
                        : key == 'Факс'
                            ? 'assets/phone.svg' //TODO fax icon
                            : 'assets/mail.svg',
                width: width * 0.06,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key == 'Адрес'
                      ? 'Адрес'
                      : key == 'Телефон' ||
                              key == 'Телефон 1' ||
                              key == 'Телефон 2'
                          ? 'Номер телефона'
                          : key == 'Факс'
                              ? 'Факс'
                              : 'Email',
                  style: const TextStyle(
                    color: Color(0xFF868686),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 0.98,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  data[key],
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
        ],
      ),
    );
  }

  //Получение виджетов списка
  List<Widget> getWidgetList(double width) {
    List<Widget> widgetList = [];
    for (int i = 0; i < list.length; i++) {
      widgetList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.transparent,
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (BuildContext context) => Organization.dataConstructor(
                  Map<String, dynamic>.from(list[i]['child'] as Map),
                  name: list[i]['name'],
                  iconPath: widget.iconPath,
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
    return widgetList;
  }
}
