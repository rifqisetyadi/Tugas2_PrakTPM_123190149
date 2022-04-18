import 'package:tugas2/main.dart';
import 'package:april17/model/account_list.dart';
import 'package:april17/tools/common_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Box<AccountList> localDB = Hive.box<AccountList>("register");

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildInputUsername(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildInputPassword(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildRegisterButton(),
            ),
            //_buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputUsername() {
    return TextField(
      controller: _username,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Username',
      ),
    );
  }

  Widget _buildInputPassword() {
    return TextField(
      controller: _password,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'password',
      ),
    );
  }

  Widget _buildRegisterButton() {
    return CommonSubmitButton(
        labelButton: "Register",
        submitCallback: (value){
          localDB.add(AccountList(username: _username.text, password: _password.text));
          // _username.clear();
          // _password.clear();
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyLoginPage()));
          setState(() {

          });
        });
  }

  Widget _buildList(){
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: localDB.listenable(),
        builder: (BuildContext context, Box<dynamic> value, Widget? child){
          if(value.isEmpty){
            return Center(
              child: Text("data kosong"),
            );
          }

          return ListView.builder(itemBuilder: (BuildContext context, int index){
            return Text("${localDB.getAt(index)!.username}");
          });
        },
      ),
    );
  }
}

