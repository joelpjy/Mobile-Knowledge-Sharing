import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:mobile_knowledge_sharing_app/ui/components/greyed_out.dart';
import 'package:mobile_knowledge_sharing_app/ui/themes/color_theme.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) {
        var userDisplayPhoto = model.userDisplayPhoto;
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: ColorTheme.cyberGrape,
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (userDisplayPhoto != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CircleAvatar(
                              foregroundImage: NetworkImage(
                                  'https://as2.ftcdn.net/v2/jpg/01/17/98/93/1000_F_117989378_Pzd5jxeB9L6kt46S1g7vt16lbfDUvSdB.jpg'),
                              radius: 30,
                            ),
                          ),
                        Text(
                          '${model.username}\n${model.userEmail}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  trailing: Icon(Icons.logout),
                  title: const Text('Sign Out'),
                  onTap: model.logout,
                ),
              ],
            ),
          ),
          appBar: AppBar(
            elevation: 1,
            centerTitle: true,
            title: DelayedDisplay(
              fadeIn: true,
              slidingBeginOffset: Offset(0, -1),
              child: Text(
                'Mobile Quiz',
                style: TextStyle(
                    fontFamily: 'Aharoni',
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: ColorTheme.white),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: model.initialise,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: QuizListView(
                    model: model,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DelayedDisplay(
                  delay: Duration(seconds: 1),
                  fadeIn: true,
                  slidingBeginOffset: Offset(0, 1),
                  child: Text(
                    'Total Score: ${model.totalScore}',
                    style: TextStyle(
                        fontFamily: 'Aharoni',
                        fontWeight: FontWeight.w600,
                        fontSize: 21,
                        color: ColorTheme.russianViolet),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialise(),
    );
  }
}

class QuizListView extends StatelessWidget {
  final HomeViewModel model;

  QuizListView({required this.model});

  final Tween<Offset> _offset = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: model.questionListKey,
      initialItemCount: model.questionList.length,
      shrinkWrap: true,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: animation.drive(_offset),
          child: Card(
            child: ListTile(
              title: GreyedOut(
                Text(
                  model.questionList[index].label,
                  style: TextStyle(
                      fontFamily: 'Aharoni',
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: ColorTheme.russianViolet),
                ),
                greyedOut: model.questionList[index].isAnswered ||
                    !model.questionList[index].isEnabled,
              ),
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
          ),
        );
      },
    );
  }
}
