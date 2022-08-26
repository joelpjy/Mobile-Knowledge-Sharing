import 'package:auth_buttons/auth_buttons.dart';
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
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(
                      flex: 4,
                    ),
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
                              'Mobile Team',
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
                    Spacer(
                      flex: 2,
                    ),
                    DelayedDisplay(
                      delay: Duration(seconds: 2),
                      fadingDuration: const Duration(milliseconds: 500),
                      fadeIn: true,
                      slidingBeginOffset: Offset(0, 1),
                      child: Column(
                        children: [
                          Text(
                            'Login with',
                            style: TextStyle(
                                fontFamily: 'Aharoni', color: ColorTheme.white),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GoogleAuthButton(
                                  onPressed: model.signInWithGoogle,
                                  style: AuthButtonStyle(
                                    buttonType: AuthButtonType.icon,
                                    iconType: AuthIconType.secondary,
                                    borderRadius: 300,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FacebookAuthButton(
                                  onPressed: model.facebookLogin,
                                  style: AuthButtonStyle(
                                    buttonType: AuthButtonType.icon,
                                    iconType: AuthIconType.secondary,
                                    borderRadius: 300,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              if (model.isBusy)
              AbsorbPointer(
                child: Container(
                  color: Colors.black45,
                  child: Center(
                    child: SizedBox(
                      width: 160,
                      height: 160,
                      child: CircularProgressIndicator(
                        strokeWidth: 16,
                        color: ColorTheme.cyberGrape,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.initialise(),
    );
  }
}
