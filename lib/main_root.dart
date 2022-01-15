import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainRoot extends StatefulWidget {
  const MainRoot({Key? key}) : super(key: key);

  @override
  _MainRootState createState() => _MainRootState();
}

class _MainRootState extends State<MainRoot> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scrollbar(
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
                  //Заголовок
                  Container(
                    margin: EdgeInsets.only(top: height * 0.04),
                    width: width * 0.85,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Справочник',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF232425),
                          ),
                        ),
                        Text(
                          "Верхоянского района",
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF232425),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Поиск
                  Container(
                    margin: EdgeInsets.only(
                      top: height * 0.035,
                      bottom: height * 0.045,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          offset: const Offset(0.0, 4.0),
                          blurRadius: 36,
                        ),
                      ],
                    ),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      cursorRadius: const Radius.circular(2),
                      cursorColor: const Color(0xFF232425),
                      cursorWidth: 2,
                      decoration: InputDecoration(
                        suffixIcon: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            radius: 16.0,
                            borderRadius: BorderRadius.circular(64.0),
                            highlightColor: Colors.transparent,
                            onTap: () => {},
                            child: const Icon(
                              Icons.search,
                              color: Color(0xFF232425),
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Поиск по справочнику...",
                        hintStyle: const TextStyle(
                          color: Color(0xFF868686),
                          fontSize: 16,
                        ),
                        contentPadding: const EdgeInsets.all(20.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Плитки
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTile(
                            'Власть',
                            SvgPicture.asset(
                              'assets/main_root_icons/user.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFE9F5F4),
                            width,
                          ),
                          Expanded(child: Container()),
                          getTile(
                            "Правоохра-\nнительные\nорганы",
                            SvgPicture.asset(
                              'assets/main_root_icons/town_hall.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFF6EDE9),
                            width,
                          ),
                          Expanded(child: Container()),
                          getTile(
                            'Медицина',
                            SvgPicture.asset(
                              'assets/main_root_icons/medicine.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFE8ECF9),
                            width,
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTile(
                            'Образование',
                            SvgPicture.asset(
                              'assets/main_root_icons/book.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFF9F2E8),
                            width,
                          ),
                          Expanded(child: Container()),
                          getTile(
                            "Обслужи-\nвающие\nорганизации",
                            SvgPicture.asset(
                              'assets/main_root_icons/creative_commons.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFF4E8F9),
                            width,
                          ),
                          Expanded(child: Container()),
                          getTile(
                            'Безопасность',
                            SvgPicture.asset(
                              'assets/main_root_icons/safe_square.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFDCECEA),
                            width,
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTile(
                            "Культура и спорт",
                            SvgPicture.asset(
                              'assets/main_root_icons/supervised_user.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFE2F5E2),
                            width,
                          ),
                          Expanded(child: Container()),
                          getTile(
                            "Социальная сфера",
                            SvgPicture.asset(
                              'assets/main_root_icons/chat.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFF9E8E8),
                            width,
                          ),
                          Expanded(child: Container()),
                          getTile(
                            'Торговля',
                            SvgPicture.asset(
                              'assets/main_root_icons/shopping_basket.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFFFE6F3),
                            width,
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTile(
                            'Услуги',
                            SvgPicture.asset(
                              'assets/main_root_icons/products.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFF4E8F9),
                            width,
                          ),
                          Expanded(child: Container()),
                          getTile(
                            'СМИ',
                            SvgPicture.asset(
                              'assets/main_root_icons/news.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFF9F2E8),
                            width,
                          ),
                          Expanded(child: Container()),
                          getTile(
                            'Прочие',
                            SvgPicture.asset(
                              'assets/main_root_icons/other.svg',
                              width: width * 0.1,
                              height: width * 0.1,
                            ),
                            const Color(0xFFEFEFEF),
                            width,
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Плитка
  Widget getTile(String text, Widget icon, Color color, double width) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        //TODO Переход на next page
        onTap: () => {},
        highlightColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: width * 0.25,
                height: width * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: color,
                ),
                child: Center(
                  child: icon,
                ),
              ),
              Container(
                width: width * 0.25,
                margin: const EdgeInsets.only(top: 6),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF232425),
                  ),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoPhysicsBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
