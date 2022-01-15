import 'package:flutter/material.dart';

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
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.075,
        ),
        child: ScrollConfiguration(
          behavior: NoPhysicsBehavior(),
          child: ListView(
            children: [
              //Заголовок
              Container(
                margin: EdgeInsets.only(top: height * 0.06),
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
                    top: height * 0.035, bottom: height * 0.045),
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
                  cursorRadius: const Radius.circular(2),
                  cursorColor: const Color(0xFF232425),
                  cursorWidth: 2,
                  decoration: InputDecoration(
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
                    children: [
                      getTile(
                        'Медицина',
                        Container(),
                        const Color(0xFFE8ECF9),
                        width,
                      ),
                      Expanded(child: Container()),
                      getTile(
                        'Власть',
                        Container(),
                        const Color(0xFFE9F5F4),
                        width,
                      ),
                      Expanded(child: Container()),
                      getTile(
                        'ЖКХ',
                        Container(),
                        const Color(0xFFF6EDE9),
                        width,
                      ),
                    ],
                  ),
                  Container(
                    height: 20,
                  ),
                  Row(
                    children: [
                      getTile(
                        'Образование',
                        Container(),
                        const Color(0xFFF9F2E8),
                        width,
                      ),
                      Expanded(child: Container()),
                      getTile(
                        'Наука',
                        Container(),
                        const Color(0xFFF4E8F9),
                        width,
                      ),
                      Expanded(child: Container()),
                      getTile(
                        'Экономика',
                        Container(),
                        const Color(0xFFEFEFEF),
                        width,
                      ),
                    ],
                  ),
                  Container(
                    height: 20,
                  ),
                  Row(
                    children: [
                      getTile(
                        'Политика',
                        Container(),
                        const Color(0xFFF9E8E8),
                        width,
                      ),
                      Expanded(child: Container()),
                      getTile(
                        'Культура',
                        Container(),
                        const Color(0xFFE2F5E2),
                        width,
                      ),
                      Expanded(child: Container()),
                      getTile(
                        'Энергетика',
                        Container(),
                        const Color(0xFFF9F2E8),
                        width,
                      ),
                    ],
                  ),
                  Container(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(),
                      Expanded(child: Container()),
                      Container(),
                      Expanded(child: Container()),
                      Container(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Плитка
  Widget getTile(String text, Widget icon, Color color, double width) {
    return Column(
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
          margin: const EdgeInsets.only(top: 6),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF232425),
            ),
          ),
        ),
      ],
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
