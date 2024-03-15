import 'package:flutter/material.dart';
import 'package:sadykova_app/core/utils/path_converter.dart';
import 'package:sadykova_app/features/main/ui/widgets/photo_text_menu_item.dart';
import 'package:sadykova_app/features/services/domain/models/advantage_model.dart';

class AdvantageWidget extends StatefulWidget {
  const AdvantageWidget({
    Key? key,
    required this.advantages,
  }) : super(key: key);

  final List<AdvantageModal> advantages;

  @override
  State<AdvantageWidget> createState() => _AdvantageWidgetState();
}

class _AdvantageWidgetState extends State<AdvantageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Преимущества обращения в Нашу клинику",
                style: TextStyle(
                  color: Color(0xff66788C),
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat-b',
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: List.generate(
                  widget.advantages.length,
                  (index) {
                    return PhotoTextMenuItem(
                      title: widget.advantages[index].name ?? '',
                      description: widget.advantages[index].description ?? '',
                      photo: ImagePathConvertor.convertTopaht(
                        path: widget.advantages[index].path ?? '',
                      ),
                      advantage: true,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
