import 'package:fall_detector/providers/sign_in_provider.dart';
import 'package:fall_detector/services/auth.dart';
import 'package:fall_detector/utils/app_colors.dart';
import 'package:fall_detector/utils/constants.dart';
import 'package:fall_detector/utils/text_styles.dart';
import 'package:fall_detector/widgets/app_logo.dart';
import 'package:fall_detector/widgets/disabled_button.dart';
import 'package:fall_detector/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  bool _validForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.nameApp,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 80,
          ),
          child: ChangeNotifierProvider(
            create: (_) => SignInProvider(),
            builder: (context, _) {
              final _provider = context.watch<SignInProvider>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AppLogo(),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16.0, bottom: 10),
                        child: Text(
                          AppConstants.welcome,
                          style: TextStyles.heading3SmallLight,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Text(
                          AppConstants.pleaseSignIn,
                          style: TextStyles.headingMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 32, top: 16),
                        child: Text(
                          AppConstants.firstTime,
                          style: TextStyles.body,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    onChanged: () {
                      if (_validForm != _formKey.currentState.validate() && _provider.formActivated()) {
                        setState(() {
                          _validForm = _formKey.currentState.validate();
                        });
                      }
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            style: TextStyles.subtitleMedium.copyWith(color: AppColors.greyishBrown),
                            controller: _mailController,
                            decoration: InputDecoration(labelText: AppConstants.login),
                            onChanged: _provider.activateEmail,
                            validator: _provider.validateEmail,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            style: TextStyles.subtitleMedium.copyWith(color: AppColors.greyishBrown),
                            controller: _passwordController,
                            decoration: InputDecoration(labelText: AppConstants.password),
                            obscureText: true,
                            onChanged: _provider.activatePassword,
                            validator: _provider.validatePassword,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 16),
                    child: _validForm
                        ? PrimaryButton(
                            text: AppConstants.signIn,
                            onPressed: () async {
                              dynamic result = await _auth.registerWithEmailAndPassword(
                                  _provider.email, _provider.password);
                              if (result != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomeScreen()),
                                );
                              }
                            },
                          )
                        : DisabledButton(
                            text: AppConstants.signIn,
                          ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
