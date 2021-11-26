import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import 'package:ible/models/user.model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/pages/reset/reset.dart';
import 'package:ible/ui/widgets/slide_from_right_page_route.widget.dart';

import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _loginFormKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _emailError = false;
  bool _usernameError = false;

  String? error;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: ImageIcon(
              AssetImage(
                'assets/images/icons/arrow_left.png',
              ),
              color: Colors.black,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Text(
              'Forgot password',
              style: AppStyles.titleStyle(context).copyWith(fontSize: 22),
            ),
          ),
          toolbarHeight: 64,
          backgroundColor: ThemeColors.greyEEEEEE,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: _buildLoginPage(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginPage(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 56),
            child: Text(
              'We need to confirm your email to send you instructions to reset your password.',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 20, color: ThemeColors.grey2E3235),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 0.0, top: 32.0, left: 16.0, right: 16.0),
            child: InkWell(
              child: TextFormField(
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 18, color: ThemeColors.grey2E3235),
                decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Email',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 18, color: ThemeColors.grey2E3235),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 18, color: ThemeColors.grey2E3235),
                    errorStyle: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 13, color: ThemeColors.grey808082),
                    suffixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                    suffixIcon: _emailError
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Image.asset(
                              'assets/images/icons/input-error-preview.png',
                              height: 20,
                            ),
                          )
                        : null,
                    errorBorder: UnderlineInputBorder()),
                controller: _emailController,
                validator: (value) {
                  final emailReg =
                      r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                  this._emailError =
                      value!.isEmpty || !RegExp(emailReg).hasMatch(value);
                  return this._emailError
                      ? value.isEmpty
                          ? 'Please enter email address'
                          : 'Please enter a valid email address'
                      : null;
                },
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextFormField(
              autovalidateMode: _autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 18, color: ThemeColors.grey2E3235),
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 18, color: ThemeColors.grey2E3235),
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 13, color: ThemeColors.grey808082),
                suffixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0),
                suffixIcon: _usernameError
                    ? Image.asset(
                        'assets/images/icons/input-error-preview.png',
                        height: 20,
                      )
                    : null,
              ),
              controller: _usernameController,
              validator: (value) {
                this._usernameError = value!.isEmpty || value.trim().length < 4;
                return this._usernameError ? 'Username cannot be empty' : null;
              },
            ),
          ),
          SizedBox(
            height: 32,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                SlideFromRightPageRoute(widget: ResetPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 18,
                  color: ThemeColors.grey2E3235,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 32),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Forgot Username?',
                style: TextStyle(
                  fontSize: 18,
                  color: ThemeColors.grey2E3235,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          _buildLoginButton(context),
        ],
      ),
    );
  }

  _buildLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8, left: 20, right: 20),
      child: ElevatedButton(
        onPressed: () async {
          final valid = _loginFormKey.currentState!.validate();
          this._autoValidate = true;
          setState(() {});
          if (!valid) return;
          error = null;
         

          throw UnimplementedError();

         /*  final result = await (showDialog<Result>(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Container(
                      child: FutureBuilder(
                        future:
                            Provider.of<AuthController>(context, listen: false)
                                .login(form),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData)
                            Navigator.pop(context, Result(true, snapshot.data));
                          if (snapshot.hasError)
                            Navigator.pop(
                                context, Result(false, snapshot.error));
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        },
                      ),
                    );
                  })) ??
              Result(false, 'Some Error');

          if (result.success)
            Navigator.of(context).pop();
          else
            setState(() {
              error = result.message.toString();
            }); */
        },
        style: ElevatedButton.styleFrom(
          primary: ThemeColors.blue027CFE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
          elevation: 0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 17),
          child: Text(
            'Reset password',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
