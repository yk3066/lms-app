import 'package:flutter/material.dart';
import 'package:geoguru/onlineplayer.dart';
import 'auth_service.dart';

class AuthScreens extends StatefulWidget {
  @override
  _AuthScreensState createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreens> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _isLogin = true;
  bool _isStudent = true;
  bool _isTeacher = false;

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _selectStudent() {
    setState(() {
      _isStudent = true;
      _isTeacher = false;
    });
  }

  void _selectTeacher() {
    setState(() {
      _isStudent = false;
      _isTeacher = true;
    });
  }

  Future<void> _submitForm() async {
    if (_isLogin) {
      final token = await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );
      if (token != null) {
        // Navigate to the authenticated screen or perform any other action
      } else {
        // Show an error message
      }
    } else {
      try {
        await _authService.signup(
          _nameController.text,
          _usernameController.text,
          _passwordController.text,
          _isStudent,
          _isTeacher,
        );
        // Show a success message or navigate to login
        _toggleAuthMode();
      } catch (error) {
        // Show an error message
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(_isLogin ? 'Login to GeoGuru' : 'Signup to GeoGuru'),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.blue, Colors.white, Colors.white, Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome to GeoGuru",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.pink
                ),),
                SizedBox(
                  height: 80,
                ),
                if (!_isLogin)
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                if (!_isLogin)

                  Column(
                    children: [
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            "Are you a ",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          Checkbox(
                            value: _isStudent,
                            onChanged: (newValue) {
                              if (newValue!) {
                                _selectStudent();
                              }
                            },
                          ),
                          Text('Student'),
                          SizedBox(width: 20),
                          Checkbox(
                            value: _isTeacher,
                            onChanged: (newValue) {
                              if (newValue!) {
                                _selectTeacher();
                              }
                            },
                          ),
                          Text('Teacher'),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed:(){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OnlineHomeScreen()
                      ),
                    );
    },
                  child: Text(
                    _isLogin ? 'Login' : 'Signup',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _toggleAuthMode,
                  child: Text(
                    _isLogin
                        ? 'Don\'t have an account? Signup'
                        : 'Already have an account? Login',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
