import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:mobile_knowledge_sharing_app/ui/themes/color_theme.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorTheme.aliceBlue,
          appBar: AppBar(
            elevation: 1,
            automaticallyImplyLeading: false,
            backgroundColor: ColorTheme.russianViolet,
            centerTitle: true,
            title: DelayedDisplay(
              fadeIn: true,
              slidingBeginOffset: Offset(0, -1),
              child: Text(
                "Mobile Quiz",
                style: TextStyle(
                    fontFamily: 'Aharoni',
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: ColorTheme.white),
              ),
            ),
            actions: [
              IconButton(
                onPressed: model.questionMarkPress,
                color: Colors.white,
                icon: Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 25.0,
                ),
              )
            ],
          ),
          body: /*Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              /*TextLiquidFill(
                loadUntil: 0.3,
                text: 'MOBILE',
                waveColor: ColorTheme.rhythm,
                boxBackgroundColor: ColorTheme.russianViolet,
                textStyle: TextStyle(
                  fontFamily: 'Aharoni',
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
            ],
          ),*/
              QuizListView(model: model),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialise(),
    );
  }
}

class QuizListView extends StatelessWidget {
  HomeViewModel model;

  QuizListView({required this.model});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: model.questionList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(model.questionList[index].label),
              trailing: model.questionList[index].isAnswered
                  ? model.questionList[index].isCorrect
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.close,
                          color: Colors.red,
                        )
                  : Icon(Icons.question_mark),
              onTap: () {
                model.questionSelected(index);
              },
            ),
          );
        });
  }
}
