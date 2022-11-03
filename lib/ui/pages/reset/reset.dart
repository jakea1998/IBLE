import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ible/models/user.model.dart';
import 'package:ible/theme.dart';
import 'package:ible/ui/widgets/auth_text_input_field.dart';
import 'package:ible/utils/network_response.dart';
import 'package:provider/provider.dart';




class ResetPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  String? error;

  int _selectedIndexValue = 0;

  final _requestResetFormKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _tokenController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Reset Password',
          style: AppStyles.titleStyle(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            CupertinoSegmentedControl(
              // unselectedColor: ThemeColors.backgroundGrey,

              selectedColor: ThemeColors.segmented(context),
              borderColor: ThemeColors.segmented(context),
              children: {
                0: Text(" Request token "),
                1: Text("Enter token"),
              },
              groupValue: _selectedIndexValue,
              onValueChanged: (dynamic value) {
                setState(() {
                  _selectedIndexValue = value;
                });
              },
            ),
            Expanded(
              child: _selectedIndexValue == 0
                  ? _buildRequestResetPage(context)
                  : _buildResetPage(context),
            ),
            if (error != null) Text(error!),
          ],
        ),
      ),
    );
  }

  _buildRequestResetButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8),
      child: OutlinedButton(
        onPressed: () async {
          if (!_requestResetFormKey.currentState!.validate()) return;
          error = null;
          

          /* final result = await showDialog<NetworkResponse>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Container(
                  child: FutureBuilder(
                    future: Provider.of<AuthController>(context, listen: false)
                        .requestReset(form),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData)
                        Navigator.pop(
                            context,
                            NetworkResponse(
                                success: true, body: snapshot.data));
                      if (snapshot.hasError)
                        Navigator.pop(
                            context,
                            NetworkResponse(
                                success: false, body: snapshot.error));
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    },
                  ),
                );
              });

          if (result?.success! ?? false)
            Navigator.of(context).pop();
          else
            setState(() {
              error = result?.message.toString() ?? 'Some error';
            }); */
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.0),
          ),
          side: BorderSide(width: 2, color: Color(0xFFA7B0B3)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12),
          child: Text(
            'Request token',
            style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 20),
          ),
        ),
      ),
    );
  }

  _buildResetButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8),
      child: OutlinedButton(
        onPressed: () async {
          if (!_resetFormKey.currentState!.validate()) return;
          error = null;
          

          /* final result = await showDialog<NetworkResponse>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Container(
                  child: FutureBuilder(
                    future: Provider.of<AuthController>(context, listen: false)
                        .reset(form),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData)
                        Navigator.pop(
                            context,
                            NetworkResponse(
                                success: true, body: snapshot.data));
                      if (snapshot.hasError)
                        Navigator.pop(
                            context,
                            NetworkResponse(
                                success: false, body: snapshot.error));
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    },
                  ),
                );
              });

          if (result?.success! ?? false)
            Navigator.of(context).pop();
          else
            setState(() {
              error = result?.message.toString() ?? 'Some Error';
            }); */
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.0),
          ),
          side: BorderSide(width: 2, color: Color(0xFFA7B0B3)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12),
          child: Text(
            'Reset password',
            style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestResetPage(BuildContext context) {
    return Form(
      key: _requestResetFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 8.0, top: 24.0, left: 16.0, right: 16.0),
            child: InkWell(
              child: ScriptureInputFormField(
                labelText: 'Enter Username',
                controller: _usernameController,
                validator: (value) =>
                (value?.isNotEmpty ?? false) ? 'Enter the username' : null,
              ),
            ),
          ),
          Divider(
            color: ThemeColors.greyB2B2B2,
          ),
          Expanded(
            child: Container(),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildRequestResetButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildResetPage(BuildContext context) {
    return Form(
      key: _resetFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 8.0, top: 24.0, left: 16.0, right: 16.0),
            child: ScriptureInputFormField(
              labelText: 'Enter Token',
              validator: (value) =>
              (value?.isNotEmpty ?? false) ? null : 'Please enter the token',
              controller: _tokenController,
              keyboardType: TextInputType.number,
            ),
          ),
          Divider(
            color: ThemeColors.greyB2B2B2,
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 8.0, top: 16.0, left: 16.0, right: 16.0),
            child: ScriptureInputFormField(
              labelText: 'Enter Username',
              validator: (value) => (value?.isNotEmpty ?? false) && (value?.trim().length ?? 0) >= 4
                  ? null
                  : 'Username must be at least 4 characters',
              controller: _usernameController,
            ),
          ),
          Divider(
            color: ThemeColors.greyB2B2B2,
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ScriptureInputFormField(
              labelText: 'Enter Password',
              controller: _passwordController,
              obscureText: true,
              validator: (value) => (value?.isNotEmpty ?? false) && (value?.trim().length ?? 0) >= 6
                  ? null
                  : 'Password must be at least 6 characters',
            ),
          ),
          Divider(
            color: ThemeColors.greyB2B2B2,
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ScriptureInputFormField(
              labelText: 'Repeat Password',
              controller: _repeatPasswordController,
              validator: (value) => value == _passwordController.value.text
                  ? null
                  : 'Passwords do not match',
              obscureText: true,
            ),
          ),
          Divider(
            color: ThemeColors.greyB2B2B2,
          ),
          //Expanded(child: Container()),
          Expanded(
            child: Container(),
          ),
          Divider(color: ThemeColors.greyB2B2B2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildResetButton(context),
          ),
        ],
      ),
    );
  }
}
