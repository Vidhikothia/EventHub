  import 'package:firebase_core/firebase_core.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'login.dart';
  import '../home.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
  const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return const MaterialApp(
        home: Wrapper(),
      );
    }
  }

  class Wrapper extends StatefulWidget {
    const Wrapper({super.key});

    @override
    _WrapperState createState() => _WrapperState();
  }

  class _WrapperState extends State<Wrapper> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return const Center(child: Text('Something went wrong!'));
            }
            else if(snapshot.hasData){
              return const HomePage();
            } else {
              return const Login();
            }
          },
        ),
      );
    }
  }


