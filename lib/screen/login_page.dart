import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pertemuan_6/shared_pref.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  var baseUrl = "https://b517-103-17-77-3.ngrok-free.app/api";

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> login() async {
      var dio = Dio();

      try {
        var response = await dio.post('$baseUrl/login', data: {
          "email": emailController.text,
          "password": passwordController.text
        });

        SharedPref.pref?.setString("token", response.data["data"]["token"]);

        print(response);

        Navigator.of(context).pushNamed("home");
      } catch (e) {
        print(e);
      }
    }

    AppBar myAppbar = AppBar(
      leading: Icon(Icons.lock_clock_outlined, color: Colors.black),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

    final double devieHeight = MediaQuery.of(context).size.height;
    final double bodyApp = devieHeight -
        myAppbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final double bodyWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: myAppbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: bodyApp * 0.1,
              width: bodyWidth,
              color: Colors.amber,
              child: const Center(
                  child: Text(
                "Welcome, Please Login",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ),
            Container(
              height: bodyApp * 0.9,
              width: bodyWidth,
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(50),
                      color: Colors.amber,
                    ),
                    child: const Icon(
                      Icons.person_3,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: bodyWidth,
                      height: 40,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.amber),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          onPressed: () {
                            login();
                            // Navigator.of(context).pushNamed("home");
                          },
                          child: const Text(
                            "login",
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
