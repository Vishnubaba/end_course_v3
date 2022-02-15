import 'package:end_course/global_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'string_const.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //USER AUTHENTICATION
  String? _userStoredName;
  String? _userStoredPass;

  bool _checkAuthorization() {
    if ((_userStoredName == Strings.userName)&&(_userStoredPass == Strings.userPass)) {
      return true;
    }
    return false;
  }

  void _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userStoredName = (prefs.getString('userStoredName') ?? '');
      _userStoredPass = (prefs.getString('userStoredPass') ?? '');
    });
  }

  void _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userStoredName', (_userStoredName ?? ''));
    prefs.setString('userStoredPass', (_userStoredPass ?? ''));
  }
  //END OF USER AUTHENTICATION

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_checkAuthorization()) {
      return Scaffold(
        appBar: myAppBar(Strings.appTitle),
        drawer: navDrawer(context),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/11.png"),
                fit: BoxFit.cover,
              ),
          ),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40,),
                Icon(Icons.verified_user, size: 50, color: Theme.of(context).primaryColor,),
                const SizedBox(height: 50),
                Text(
                  Strings.authSuccess,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: const [
                    Expanded(child: SizedBox(height: 20)),
                  ],
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (){
                        _userStoredName ='';
                        _userStoredPass ='';
                        _saveUserData();
                        setState(() {});
                      },
                      child: const Text(Strings.buttonExit)
                  ),
                )
              ],
            ),
          ),
        ),

      );
    } else {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/11.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  Icon(Icons.apps, size: 50, color: Theme.of(context).primaryColor,),
                  const SizedBox(height: 50),
                  Text(
                      Strings.authEnterLogin,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: SizedBox()
                      ),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: userController,
                          keyboardType: TextInputType.phone,
                          decoration: textFieldDecoration(Strings.fieldPhone, context),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Strings.validName;
                            } else if (value.length !=10){
                              return Strings.validNameLength;
                            }
                            return null;
                          },
                        ),
                      ),
                      const Expanded(
                          flex: 1,
                          child: SizedBox()
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: SizedBox()
                      ),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: passController,
                          obscureText: true,
                          decoration: textFieldDecoration(Strings.fieldPass, context),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Strings.validPass;
                            }
                            return null;
                          },
                        ),
                      ),
                      const Expanded(
                          flex: 1,
                          child: SizedBox()
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            _userStoredName = userController.text;
                            _userStoredPass = passController.text;
                            if (_checkAuthorization()) {
                              _saveUserData();
                            } else {
                              _userStoredName = '';
                              _userStoredPass = '';
                              _saveUserData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(Strings.authFailed), duration: Duration(seconds: 2)),
                              );
                            }
                          }
                          setState(() {});
                        },
                        child: const Text(Strings.buttonEnter)
                    ),
                  ),
                  //const SizedBox(
                  //  height: 50,
                 // ),
                 // const Text('Демо-доступ:'),
                //  Text('Тел: ${Strings.userName}'),
                //  Text('Пароль: ${Strings.userPass}'),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}