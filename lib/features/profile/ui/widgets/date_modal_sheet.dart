import 'package:flutter/material.dart';
import 'package:sadykova_app/core/theme/colors.dart';
import 'package:sadykova_app/core/theme/text_styles.dart';

class DateModalSheet extends StatefulWidget {
  const DateModalSheet({
    Key? key,
  }) : super(key: key);
  @override
  DateModalSheetState createState() => DateModalSheetState();
}

class DateModalSheetState extends State<DateModalSheet> {
  @override
  void initState() {
    super.initState();
  }

  List<String> listOfCitis = ['Казань', 'Набережные Челны'];
  String selectedCity = 'Казань';

  Widget buildHeader() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.56,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(
                20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget closWidgets() {
    return Center(
      child: Container(
        width: 70,
        height: 4,
        margin: const EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
          color: kGreyScale600Color,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget buildInfos() {
    return Padding(
      padding: const EdgeInsets.only(top: 14, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "День рождения",
            style: mainBoldTextStyle.copyWith(
              color: const Color(0xff66788C),
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // buildCityItem("Казань"),
                    // const CustomLine(
                    //   color: kGreyScale500Color,
                    // ),
                    // buildCityItem("Набережные Челны"),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget buildCityItem(String text) {
    return InkWell(
      onTap: () async {
        setState(() {
          selectedCity = text;
        });
        await Future.delayed(const Duration(milliseconds: 300))
            .then((value) => Navigator.pop(context, selectedCity));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 18, left: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Color(0xff66788C),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (text == selectedCity)
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                ),
                child: const Center(
                  child: Icon(
                    Icons.done_rounded,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  Widget buildContent() {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        color: kBgColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          closWidgets(),
          buildInfos(),
        ],
      ),
    );
  }
}
