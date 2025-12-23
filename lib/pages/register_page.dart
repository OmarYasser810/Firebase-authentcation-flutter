import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
	final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
	final _firstNameController = TextEditingController();
	final _lastNameController = TextEditingController();
	final _bioController = TextEditingController();
	final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
	final _confirmPasswordController = TextEditingController();

	Future signUp() async {
		if (passwordsMatch()) {
			await FirebaseAuth.instance.createUserWithEmailAndPassword(
				email: _emailController.text.trim(),
				password: _passwordController.text.trim(),
			);
		}
		await addUserDetails(
			_firstNameController.text.trim(),
			_lastNameController.text.trim(),
			_bioController.text.trim(),
			_emailController.text.trim(),
		);
	}

	Future addUserDetails(String firstName, String lastName, String bio, String email) async {
		// add user details to firestore
		await FirebaseFirestore.instance.collection('users').add({
			'first name': firstName,
			'last name': lastName,
			'bio': bio,
			'email': email,
		});
	}

	bool passwordsMatch() {
		return _passwordController.text.trim() ==
			_confirmPasswordController.text.trim();
	}

	@override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hello text
                Text(
                  'Hello there!',
                  style: TextStyle(fontFamily: 'bebasneue', fontSize: 52),
                ),
                Text(
                  'Register below with your details!',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 50),
								
								// first name textfield
								Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'First Name',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

								// last name textfield
								Padding(
									padding: const EdgeInsets.symmetric(horizontal: 25.0),
									child: Container(
										decoration: BoxDecoration(
											color: Colors.grey[200],
											border: Border.all(color: Colors.white),
											borderRadius: BorderRadius.circular(12),
										),
										child: Padding(
											padding: const EdgeInsets.only(left: 20.0),
											child: TextField(
												controller: _lastNameController,
												decoration: InputDecoration(
													border: InputBorder.none,
													hintText: 'Last Name',
												),
											),
										),
									),
								),
								SizedBox(height: 10),

								// bio textfield
								Padding(
									padding: const EdgeInsets.symmetric(horizontal: 25.0),
									child: Container(
										decoration: BoxDecoration(
											color: Colors.grey[200],
											border: Border.all(color: Colors.white),
											borderRadius: BorderRadius.circular(12),
										),
										child: Padding(
											padding: const EdgeInsets.only(left: 20.0),
											child: TextField(
												controller: _bioController,
												decoration: InputDecoration(
													border: InputBorder.none,
													hintText: 'Bio',
												),
											),
										),
									),
								),
								SizedBox(height: 10),

                // email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // confirm password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        ' Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}