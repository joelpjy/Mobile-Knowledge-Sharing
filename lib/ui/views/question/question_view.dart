import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_knowledge_sharing_app/ui/themes/color_theme.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/Question/question_view_model.dart';
import 'package:stacked/stacked.dart';

class QuestionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuestionViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorTheme.aliceBlue,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: ColorTheme.russianViolet,
            centerTitle: true,
            title: DelayedDisplay(
              fadeIn: true,
              slidingBeginOffset: Offset(0, -1),
              child: Text(
                model.titleLabel,
                style: TextStyle(
                    fontFamily: 'Aharoni',
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: ColorTheme.white),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Column(
                  children: [
                    Text(
                      model.question,
                      style: TextStyle(
                        fontFamily: 'Aharoni',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: ChoiceList(model: model),
                    ),
                  ],
                ),
                Container(
                  child: Center(
                      child: model.finalIsRight != null
                          ? model.finalIsRight! == true
                              ? Lottie.asset(
                                  'assets/json/green_tick.json',
                                  width: 400,
                                  height: 400,
                                  frameRate: FrameRate(120),
                                  repeat: false,
                                  fit: BoxFit.fill,
                                )
                              : Lottie.asset(
                                  'assets/json/red_cross.json',
                                  width: 400,
                                  height: 400,
                                  repeat: false,
                                  fit: BoxFit.fill,
                                )
                          : null),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => QuestionViewModel(),
      onModelReady: (model) => model.initialise(),
    );
  }
}

class ChoiceList extends StatelessWidget {
  final QuestionViewModel model;

  ChoiceList({required this.model});
  final Tween<Offset> _offset = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: model.optionListKey,
      initialItemCount: model.finalChoiceList.length,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: animation.drive(_offset),
          child: Card(
            child: ListTile(
              title: Text(model.finalChoiceList[index]),
              onTap: () {
                model.selectChoice(index);
              },
            ),
          ),
        );
      },
    );
  }
}
