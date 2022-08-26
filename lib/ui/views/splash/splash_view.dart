import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:mobile_knowledge_sharing_app/ui/themes/color_theme.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/splash/splash_view_model.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorTheme.russianViolet,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: DelayedDisplay(
                    delay: Duration(seconds: 0),
                    fadeIn: true,
                    slidingBeginOffset: Offset(0, 0),
                    child: Image(
                      image: AssetImage('assets/images/splash_icon.webp'),
                      height: 250,
                      width: 250,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Debug with ',
                        style: TextStyle(
                            fontFamily: 'Aharoni',
                            fontWeight: FontWeight.w600,
                            fontSize: 21,
                            color: ColorTheme.white),
                      ),
                      DelayedDisplay(
                        delay: Duration(seconds: 1),
                        fadeIn: true,
                        slidingBeginOffset: Offset(0, 1),
                        child: Text(
                          "Mobile Team",
                          style: TextStyle(
                              fontFamily: 'Aharoni',
                              fontWeight: FontWeight.w600,
                              fontSize: 21,
                              color: ColorTheme.white),
                        ),
                      ),
                    ],
                  ),
                ),

                /*Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Debug with Mobile Team',
                    style: TextStyle(
                        fontFamily: 'Aharoni',
                        fontWeight: FontWeight.w600,
                        fontSize: 21,
                        color: ColorTheme.white),
                  ),
                ),*/
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.initialise(),
    );
  }
}
