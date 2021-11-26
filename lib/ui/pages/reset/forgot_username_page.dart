import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:ible/models/user.model.dart';
import 'package:ible/theme.dart';

import 'package:provider/provider.dart';

class ForgotUsernamePage extends StatefulWidget {
  @override
  _ForgotUsernamePageState createState() => _ForgotUsernamePageState();
}

class _ForgotUsernamePageState extends State<ForgotUsernamePage> {
  final _loginFormKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  bool _emailError = false;

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
              'Forgot username',
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
              'Enter the email address used to register your star bucky account to recover your username.',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 20, color: ThemeColors.grey2E3235),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 0.0, top: 32.0, left: 20.0, right: 20.0),
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
                  errorBorder: UnderlineInputBorder(),
                ),
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
      padding: const EdgeInsets.only(bottom: 20.0, top: 8, left: 20, right: 20),
      child: ElevatedButton(
        onPressed: () async {
          final valid = _loginFormKey.currentState!.validate();
          this._autoValidate = true;
          setState(() {});
          if (!valid) return;
          error = null;
          

          throw UnimplementedError();

          /* final result = await (showDialog<Result>(
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
            'Reset username',
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
