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
            backgroundColor: ColorTheme.darkPurple, body: Container());
      },
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialise(),
    );
  }
}
