import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/DataRepository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late BuildContext theContext;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSnackBar("Welcome back ${DataRepository.loginName}");

      if (DataRepository.firstName.isEmpty) {
        DataRepository.loadData().then((_) => loadData);
      } else {
        loadData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    theContext = context;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: const Text("Profile Page"),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Welcome back ${DataRepository.loginName}"),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: callPhone,
                          icon: const Icon(Icons.phone),
                      ),
                      const SizedBox(width: 8.0),
                      IconButton(
                        onPressed: textPhone,
                        icon: const Icon(Icons.message),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Flexible(
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              border: OutlineInputBorder(),
                            ),
                          ),
                      ),
                      IconButton(onPressed: sendEmail, icon: const Icon(Icons.email)),
                    ],
                  )
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: saveData,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.save),
                      Text("Save"),
                    ],
                  ),
                )
              ],
            )
        )
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
  
  void showSnackBar(String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(theContext).showSnackBar(snackBar);
  }

  void callPhone() {
    final Uri url = Uri.parse('tel:${phoneController.text}');
    canLaunchUrl(url).then((canPhone) {
      if (canPhone) {
        launchUrl(url);
      } else {
        showAlertDialog("Could not call ${phoneController.text}");
      }
    });
  }

  void textPhone() {
    final Uri url = Uri.parse('sms:${phoneController.text}');
    canLaunchUrl(url).then((canText) {
      if (canText) {
        launchUrl(url);
      } else {
        showAlertDialog("Could not text ${phoneController.text}");
      }
    });
  }

  void sendEmail() {
    final Uri url = Uri.parse('mailto:${emailController.text}');
    canLaunchUrl(url).then((canMail) {
      if (canMail) {
        launchUrl(url);
      } else {
        showAlertDialog("Could not send email to ${emailController.text}");
      }
    });
  }

  void showAlertDialog(String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error Occurred'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void loadData() {
    firstNameController.text = DataRepository.firstName;
    lastNameController.text = DataRepository.lastName;
    phoneController.text = DataRepository.phoneNumber;
    emailController.text = DataRepository.emailAddress;
    showSnackBar("Loaded Profile");
  }

  Future<void> saveData() async {
    DataRepository.firstName = firstNameController.text;
    DataRepository.lastName = lastNameController.text;
    DataRepository.phoneNumber = phoneController.text;
    DataRepository.emailAddress = emailController.text;
    await DataRepository.saveData();
    showSnackBar("Saved Profile");
  }
}