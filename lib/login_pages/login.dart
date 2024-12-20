import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/home/bottom_bar.dart';
import 'package:trendview/login_pages/forget_password.dart';
import 'package:trendview/login_pages/register.dart';
import 'package:trendview/utils/provider_listeners.dart';
import 'package:trendview/utils/secrets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formkeyy = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  late Future<List<dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _future = loadAllApis();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/login_page.jpg'), fit: BoxFit.cover),
      ),
      child: Consumer<NewsProviders>(
        builder: (BuildContext context, NewsProviders newsModel, Widget? child) => Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error : ${snapshot.error}',
                    style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                final List<dynamic> apiResults = snapshot.data!;
                // final List<dynamic> latest_news_future = apiResults[0];
                // final List<dynamic> recommended_news_future = apiResults[1];=
                newsModel.latest_news = apiResults[0];
                newsModel.recommended_news = apiResults[1];
                return _buildUI(context);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Stack _buildUI(BuildContext context) {
    return Stack(
      children: [
        Container(),
        Container(
          padding: const EdgeInsets.only(left: 35, top: 130),
          child: const Text(
            'Welcome\n Back.',
            style: TextStyle(
              fontFamily: 'FormaDJRMicro',
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Color.fromARGB(205, 219, 225, 227),
              height: 1,
              letterSpacing: -1,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 35),
                  child: Form(
                    key: _formkeyy,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: loginEmailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Username...",
                            hintStyle: const TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 15,
                              color: Color.fromARGB(192, 76, 80, 91),
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            try {
                              all_users.firstWhere((user) => user['name'] == value);
                            } catch (e) {
                              return 'User not found';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: loginPasswordController,
                          style: const TextStyle(),
                          obscureText: true,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Password...",
                              hintStyle: const TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 15,
                                color: Color.fromARGB(192, 76, 80, 91),
                                fontWeight: FontWeight.bold,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            try {
                              all_users.firstWhere(
                                  (user) => user['name'] == loginEmailController.text && user['password'] == value);
                            } catch (e) {
                              return 'Incorrect password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sign in',
                              style: TextStyle(
                                fontFamily: 'FormaDJRMicro',
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Color.fromARGB(205, 12, 12, 12),
                                height: 1,
                                letterSpacing: -1,
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    if (_formkeyy.currentState!.validate()) {
                                      bool? userVerified =
                                          validateUser(loginEmailController.text, loginPasswordController.text);
                                      if (userVerified == true) {
                                        final_user = loginEmailController.text;
                                        final_pass = loginPasswordController.text;
                                      }

                                      loginVerifyDialog(userVerified, context);
                                      print('$final_pass $final_user');
                                    } else {
                                      loginVerifyDialog(false, context);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: const Color.fromARGB(192, 115, 146, 230),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Register(),
                                    ),
                                  );
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'FormaDJRMicro',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Color.fromARGB(205, 12, 12, 12),
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  showPasswordResetBottomSheet(context);
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 15,
                                    color: Color.fromARGB(192, 76, 80, 91),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: handleSkip,
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                fontFamily: 'FormaDJRMicro',
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: Color.fromARGB(192, 115, 146, 230),
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Add this method to handle the skip functionality
  void handleSkip() {
    setState(() {
      didSkip = true;
      final_user = 'Guest';
      final_email = '';
      final_pass = '';
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomBar(),
      ),
    );
  }

  void loginVerifyDialog(bool? userVerified, BuildContext context) {
    if (userVerified == true) {
      didSkip = false;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF303030),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: userVerified == true ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                userVerified == true ? Icons.check : Icons.close,
                color: userVerified == true ? Colors.green : Colors.red,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              userVerified == true ? 'Verification Successful' : 'Verification Failed',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userVerified == true ? 'User is verified successfully.' : 'User verification was not successful.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: userVerified == true ? Colors.green : Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (userVerified == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomBar(),
                    ),
                  );
                }
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*


        body:


    */
