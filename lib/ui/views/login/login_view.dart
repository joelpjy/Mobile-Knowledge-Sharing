import 'package:flutter/material.dart';
import 'package:mobile_knowledge_sharing_app/ui/views/login/login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: Container(),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => model.initialise(),
    );
  }
}
