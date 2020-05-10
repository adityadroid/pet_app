import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/home/home_page.dart';
import 'package:pet_app/login/bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        }
        if (state is AuthenticationFailure) {
          final snackBar = SnackBar(content: Text('Invalid credentials'));
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xff6c6cd4),
        body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is LoginProgress) {
            return Center(child: CircularProgressIndicator());
          }
          return buildHelloThere(context);
        }),
      ),
    );
  }

  Column buildHelloThere(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Text('Hello There!',
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Sign in to continue caring',
              style: Theme.of(context).textTheme.subhead),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 72, 32, 0),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
                hintText: "E-Mail", prefixIcon: Icon(Icons.alternate_email)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
          child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
                hintText: 'Password', prefixIcon: Icon(Icons.lock)),
          ),
        ),
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
          child: RaisedButton(
            elevation: 0,
            color: Colors.white,
            onPressed: () {
              if (emailController.text.isEmpty ||
                  passwordController.text.isEmpty) {
                final snackBar =
                    SnackBar(content: Text('Both fields are mandatory'));
                Scaffold.of(context).showSnackBar(snackBar);
                return;
              }
              bloc.add(
                  SignInEvent(emailController.text, passwordController.text));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                'Sign in',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}
