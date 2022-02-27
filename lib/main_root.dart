import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yana_guide/categoty.dart';
import 'package:yana_guide/custom_behaviour.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yana_guide/search_page.dart';

class MainRoot extends StatefulWidget {
  const MainRoot({Key? key}) : super(key: key);

  @override
  _MainRootState createState() => _MainRootState();
}

class _MainRootState extends State<MainRoot> {
  Box<dynamic> box = Hive.box('data');
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  late TextEditingController searchController = TextEditingController();

  BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-9786536863361967/9769008801',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();
    databaseReference.onValue.listen(
      (event) {
        DataSnapshot dataSnapshot = event.snapshot;
        if (dataSnapshot.value != null) {
          Map<String, dynamic> data =
              Map<String, dynamic>.from(dataSnapshot.value! as Map);
          box.put('data', data);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(box.get('data'));
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (BuildContext context, Box box, Widget? widget) => Stack(
          children: [
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
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
                                margin: EdgeInsets.only(top: height * 0.025),
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
                                  controller: searchController,
                                  onSubmitted: (String text) => search(text),
                                  cursorRadius: const Radius.circular(2),
                                  cursorColor: const Color(0xFF232425),
                                  cursorWidth: 2,
                                  decoration: InputDecoration(
                                    suffixIcon: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        radius: 16.0,
                                        borderRadius:
                                            BorderRadius.circular(64.0),
                                        highlightColor: Colors.transparent,
                                        onTap: () =>
                                            search(searchController.text),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getTile(
                                        'Власть',
                                        'assets/main_root_icons/user.svg',
                                        const Color(0xFFE9F5F4),
                                        width,
                                      ),
                                      Expanded(child: Container()),
                                      getTile(
                                        "Правоохра-\nнительные\nорганы",
                                        'assets/main_root_icons/town_hall.svg',
                                        const Color(0xFFF6EDE9),
                                        width,
                                      ),
                                      Expanded(child: Container()),
                                      getTile(
                                        'Медицина',
                                        'assets/main_root_icons/medicine.svg',
                                        const Color(0xFFE8ECF9),
                                        width,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getTile(
                                        'Образование',
                                        'assets/main_root_icons/book.svg',
                                        const Color(0xFFF9F2E8),
                                        width,
                                      ),
                                      Expanded(child: Container()),
                                      getTile(
                                        "Обслужи-\nвающие\nорганизации",
                                        'assets/main_root_icons/creative_commons.svg',
                                        const Color(0xFFF4E8F9),
                                        width,
                                      ),
                                      Expanded(child: Container()),
                                      getTile(
                                        'Безопасность',
                                        'assets/main_root_icons/safe_square.svg',
                                        const Color(0xFFDCECEA),
                                        width,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getTile(
                                        "Культура и\nспорт",
                                        'assets/main_root_icons/supervised_user.svg',
                                        const Color(0xFFE2F5E2),
                                        width,
                                      ),
                                      Expanded(child: Container()),
                                      getTile(
                                        "Социальная\nсфера",
                                        'assets/main_root_icons/chat.svg',
                                        const Color(0xFFF9E8E8),
                                        width,
                                      ),
                                      Expanded(child: Container()),
                                      getTile(
                                        'Торговля',
                                        'assets/main_root_icons/shopping_basket.svg',
                                        const Color(0xFFFFE6F3),
                                        width,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getTile(
                                        'Услуги',
                                        'assets/main_root_icons/products.svg',
                                        const Color(0xFFF4E8F9),
                                        width,
                                      ),
                                      Expanded(child: Container()),
                                      getTile(
                                        'СМИ',
                                        'assets/main_root_icons/news.svg',
                                        const Color(0xFFF9F2E8),
                                        width,
                                      ),
                                      Expanded(child: Container()),
                                      getTile(
                                        'Прочие',
                                        'assets/main_root_icons/other.svg',
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
                  Container(
                    height: 1,
                    color: (Theme.of(context).brightness == Brightness.light
                            ? const Color(0xFF363738)
                            : const Color(0xFFD7D8D9))
                        .withOpacity(0.12),
                  ),
                  Center(
                    child: SizedBox(
                      height: myBanner.size.height.toDouble(),
                      width: myBanner.size.width.toDouble(),
                      child: AdWidget(ad: myBanner),
                    ),
                  ),
                ],
              ),
            ),
            box.get('data', defaultValue: {}) == {} || box.get('data') == null
                ? Container(
                    width: width,
                    height: height,
                    color: Colors.black.withOpacity(0.7),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  //Плитка
  Widget getTile(String text, String icon, Color color, double width) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (BuildContext context) => Category.dataConstructor(
              {
                'category': getPath(text),
                'icon': icon,
                'color': '0x' + color.value.toRadixString(16),
              },
            ),
          ),
        ),
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
                  child: SvgPicture.asset(
                    icon,
                    width: width * 0.1,
                    height: width * 0.1,
                  ),
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

  //Получение пути
  String getPath(String input) {
    switch (input) {
      case "Правоохра-\nнительные\nорганы":
        return "Правоохранительные органы";
      case "Обслужи-\nвающие\nорганизации":
        return "Обслуживающие организации";
      case "Культура и\nспорт":
        return "Культура и спорт";
      case "Социальная\nсфера":
        return "Социальная сфера";
      case 'Власть':
      case 'Медицина':
      case 'Образование':
      case 'Безопасность':
      case 'Торговля':
      case 'Услуги':
      case 'СМИ':
        return input;
      default:
        return "Прочие";
    }
  }

  //Поиск
  void search(String input) {
    FocusScope.of(context).unfocus();
    if (input.length > 2) {
      ScaffoldMessenger.of(context).clearSnackBars();
      List<Map<String, dynamic>> export = [];
      Map<String, dynamic> data = box.get('data')!;
      data.forEach(
        (key, value) {
          String category = key;
          String organization;
          String specialist;
          String specialist2;
          (value as Map).forEach(
            (key, value) {
              if ((key as String).toLowerCase().contains(input.toLowerCase())) {
                Map<String, dynamic> temp = {
                  'category': category,
                  'path': category,
                  'name': key,
                  'value': value,
                };
                export.add(temp);
              }
              organization = key;
              (value as Map).forEach(
                (key, value) {
                  if ((key as String)
                      .toLowerCase()
                      .contains(input.toLowerCase())) {
                    Map<String, dynamic> temp = {
                      'category': category,
                      'path': category + '/' + organization,
                      'name': key,
                      'value': value,
                    };
                    export.add(temp);
                  }
                  if (value is! Map) {
                    if ((value as String)
                        .toLowerCase()
                        .contains(input.toLowerCase())) {
                      Map<String, dynamic> temp = {
                        'category': category,
                        'path': category + '/' + organization,
                        'name': key,
                        'value': value,
                      };
                      export.add(temp);
                    }
                  } else {
                    specialist = key;
                    (value).forEach(
                      (key, value) {
                        if ((key as String)
                            .toLowerCase()
                            .contains(input.toLowerCase())) {
                          Map<String, dynamic> temp = {
                            'category': category,
                            'path': category +
                                '/' +
                                organization +
                                '/' +
                                specialist,
                            'name': key,
                            'value': value,
                          };
                          export.add(temp);
                        }
                        if (value is! Map) {
                          if ((value as String)
                              .toLowerCase()
                              .contains(input.toLowerCase())) {
                            Map<String, dynamic> temp = {
                              'category': category,
                              'path': category +
                                  '/' +
                                  organization +
                                  '/' +
                                  specialist,
                              'name': key,
                              'value': value,
                            };
                            export.add(temp);
                          }
                        } else {
                          specialist2 = key;
                          (value).forEach(
                            (key, value) {
                              if ((key as String)
                                  .toLowerCase()
                                  .contains(input.toLowerCase())) {
                                Map<String, dynamic> temp = {
                                  'category': category,
                                  'path': category +
                                      '/' +
                                      organization +
                                      '/' +
                                      specialist +
                                      '/' +
                                      specialist2,
                                  'name': key,
                                  'value': value,
                                };
                                export.add(temp);
                              }
                              if ((value as String).contains(input)) {
                                Map<String, dynamic> temp = {
                                  'category': category,
                                  'path': category +
                                      '/' +
                                      organization +
                                      '/' +
                                      specialist +
                                      '/' +
                                      specialist2,
                                  'name': key,
                                  'value': value,
                                };
                                export.add(temp);
                              }
                            },
                          );
                        }
                      },
                    );
                  }
                },
              );
            },
          );
        },
      );
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (BuildContext context) =>
              SearchPage.dataConstructor(export, data),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Слишком короткий запрос",
          ),
        ),
      );
    }
  }
}
