import 'package:flutter/material.dart';
import 'package:sadykova_app/features/main/domain/models/action_model.dart';
import 'package:sadykova_app/features/main/domain/models/event_model.dart';
import 'package:sadykova_app/features/main/domain/models/news_model.dart';
import 'package:sadykova_app/features/main/ui/widgets/all_events_screen/actions_card.dart';
import 'package:sadykova_app/features/main/ui/widgets/all_events_screen/event_cart.dart';
import 'package:sadykova_app/features/main/ui/widgets/all_events_screen/news_card.dart';
import 'package:sadykova_app/features/main/ui/widgets/slider_widget.dart';

class SliderListWidget extends StatelessWidget {
  const SliderListWidget({
    Key? key,
    required this.topEvents,
    required this.onTapSlider,
  }) : super(key: key);

  final List<Object> topEvents;
  final Function(int index) onTapSlider;

  @override
  Widget build(BuildContext context) {
    if (topEvents.isEmpty) {
      return Container();
    }

    return CarouselWidget(
      items: List.generate(
        topEvents.length,
        (index) {
          if (topEvents[index] is ActionsModel) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  onTapSlider(index);
                },
                child: ActionCard(
                  model: topEvents[index] as ActionsModel,
                ),
              ),
            );
          }

          if (topEvents[index] is NewsModel) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  onTapSlider(index);
                },
                child: NewsCard(
                  model: topEvents[index] as NewsModel,
                ),
              ),
            );
          }

          if (topEvents[index] is EventModel) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  onTapSlider(index);
                },
                child: EventCard(
                  model: topEvents[index] as EventModel,
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
