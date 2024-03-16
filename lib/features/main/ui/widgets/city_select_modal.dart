import 'package:flutter/material.dart';
import 'package:sadykova_app/core/compoents/utils/custom_line.dart';
import 'package:sadykova_app/core/theme/colors.dart';

class CitySelectModal extends StatefulWidget {
  const CitySelectModal({Key? key}) : super(key: key);

  @override
  CitySelectModalState createState() => CitySelectModalState();
}

class CitySelectModalState extends State<CitySelectModal> {
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
          color: const Color(0xff66788C),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget buildInfos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          const Text(
            "Ваш город",
            style: TextStyle(
              color: Color(0xff66788C),
              fontSize: 23,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat-b',
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCityItem("Казань"),
                  CustomLine(
                    color: const Color(0xff66788C).withOpacity(0.4),
                    height: 0.5,
                  ),
                  buildCityItem("Москва"),
                ],
              ),
            ),
          )
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
        Navigator.pop(context, selectedCity);
        // await Future.delayed(const Duration(milliseconds: 300)).then(
        //   (value) => Navigator.pop(context, selectedCity),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Color(0xff66788C),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
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
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: kBgColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, -8),
            color: const Color(0xff514B43).withOpacity(0.1),
            spreadRadius: 0,
          ),
        ],
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
