import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                child: Image.asset('assets/images/logo.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "First Name"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Last Name"),
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Street Address"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Parish"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "City"),
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LargeText(text: 'Sign Up'),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.arrow_forward,
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
