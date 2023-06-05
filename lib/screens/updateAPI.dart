import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonify_app/components/style_manager.dart';

import '../components/CustomTextFields.dart';
import '../components/custom_button.dart';

class UpdateAPIScreen extends StatefulWidget {
  static const routeName = '/forget-pass';
  const UpdateAPIScreen({Key? key}) : super(key: key);

  @override
  State<UpdateAPIScreen> createState() => _UpdateAPIScreenState();
}

class _UpdateAPIScreenState extends State<UpdateAPIScreen> {
  TextEditingController apiKeyCtr = TextEditingController();
  GlobalKey<FormState> gKey = GlobalKey();
  bool isLoading=false;


  @override
  void dispose() {
    apiKeyCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Form(
          key: gKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Text('Update API Key',
                  style: getMediumStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 32.spMax)),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              CustomTextFields(
                controller: apiKeyCtr,
                hintText: "Enter New Cartoon Yourself API Key",
                hintColor: Theme.of(context).colorScheme.onSecondary,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              CustomButton(
                  onTap: updateAPI,
                  text: 'Update',
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  updateAPI()async{
    if (gKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      String newApiKey = apiKeyCtr.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('api_key', newApiKey);
      _showSnackBar(context,
          'New API key is : $newApiKey');
      setState(() {
        apiKeyCtr.clear();
      });
    }
  }
}
