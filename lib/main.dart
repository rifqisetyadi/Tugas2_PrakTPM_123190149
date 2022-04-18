import 'package:tugas2/homepage.dart';
import 'package:april17/model/account_list.dart';
import 'package:april17/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainPage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  initiateLocalDB();
  runApp(MyApp());
}

void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AccountListAdapter());
  await Hive.openBox<AccountList>("register");
  //await Hive.openBox("register");
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext contect) {
    return MaterialApp(
      title: 'Tugas 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget{
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage>  {
  Box<AccountList> localDB = Hive.box<AccountList>("register");

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login Form",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: password_controller,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',

                ),
              ),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                String username = username_controller.text;
                String password = password_controller.text;

                if (username != '' && password != '') {
                  print('Successfull');
                  logindata.setBool('login', false);
                  logindata.setString('username', username);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyDashboard()));
                }

               //  bool isRegistered=false;
               //
               //  for(var i=0; i<localDB.length; i++){
               //    if(username == localDB.getAt(i)!.username && password == localDB.getAt(i)!.password){
               //      isRegistered=true;
               //    }
               //  }
               // // localDB.getAt(index)!.username
               //
               //  if (username != '' && password != '' && isRegistered==true) {
               //    print('Successfull');
               //    logindata.setBool('login', false);
               //    logindata.setString('username', username);
               //    Navigator.push(context, MaterialPageRoute(builder: (context) => MyDashboard()));
               //  }
              },
              child: Text("Log In"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                  },
                child: Text("Register"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }
  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
}