import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  var tittle;
  SignIn({Key? key,this.tittle}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool _userValidate=false;
  bool _passwordValidate=false;
  bool _emailValidate=false;
  bool _mobileValidate=false;

  FocusNode nameFocusNode=FocusNode();
  FocusNode emailFocusNode=FocusNode();
  FocusNode passwordFocusNode=FocusNode();
  FocusNode mobileFocusNode=FocusNode();

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController mobileController=TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late FirebaseAuth auth;
  late User logedin;
  bool islogedin=false;
  bool isverified=false;
  String no='+91';

  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        auth = FirebaseAuth.instance;
      } else {
        print('User is signed in!');
       setState(() {
         islogedin=true;
       });
      }
    });

    super.initState();
  }

  Future<void> signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      logedin=userCredential.user!;
      User? user = FirebaseAuth.instance.currentUser;
      if(logedin.email==user?.email){
        setState(() {
          islogedin=true;
        });
        Fluttertoast.showToast(msg: "Login Successfull",toastLength: Toast.LENGTH_LONG);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> phoneVerify() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+911111111111',
      verificationCompleted: (PhoneAuthCredential credential) {
        setState(() {
          isverified=true;
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          isverified=false;
        });
      },
      codeSent: (String verificationId, int? resendToken) async {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: '111222');
        await auth.signInWithCredential(credential);

        if(FirebaseAuth.instance.currentUser?.phoneNumber.toString()=='+911111111111'){
          setState(() {
            isverified=true;
            no=FirebaseAuth.instance.currentUser!.phoneNumber.toString();
          });
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tittle),),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    onChanged: (text){
                      if(text.length<4 || text.isEmpty){
                        setState(() {
                          _userValidate=true;
                        });
                      }else{
                        setState(() {
                          _userValidate=false;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: nameFocusNode,
                    controller: nameController,
                    decoration: InputDecoration(
                        errorText: _userValidate?"Name must be greater than 4 digit":null,
                        labelText: 'Enter your name',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(width: 3,color: Colors.blue)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onChanged: (text){
                      if(!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(text)){
                        setState(() {
                          _emailValidate=true;
                        });
                      }else{
                        setState(() {
                          _emailValidate=false;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: emailController,
                    focusNode: emailFocusNode,
                    decoration: InputDecoration(
                        errorText: _emailValidate?"Not is email Format":null,
                        labelText: 'Enter your Email',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(width: 3,color: Colors.blue)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    focusNode: passwordFocusNode,
                    onChanged: (text){
                      if(text.length<6 || text.isEmpty){
                        setState(() {
                          _passwordValidate=true;
                        });
                      }else{
                        setState(() {
                          _passwordValidate=false;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                      errorText: _passwordValidate?"Password should be at least 6 character":null,
                      labelText: 'Enter your password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3,color: Colors.blue),
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                Padding(padding: const EdgeInsets.all(20),child: ElevatedButton(
                    onPressed: (){
                      if (!_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Not Valid Data')),
                        );
                      }else{
                        signIn();
                      }
                    }, child: const Text("SignIn"))),

                islogedin?Icon(Icons.login,color: Colors.green,size: 50,):Icon(Icons.login,color: Colors.red,size: 50,),

                Padding(padding: const EdgeInsets.all(20),child: ElevatedButton(
                    onPressed: (){
                      FirebaseAuth.instance.signOut();
                      setState(() {
                        islogedin=false;
                      });
                    }, child: const Text("SignOut"))),

                islogedin?Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        focusNode: mobileFocusNode,
                        onChanged: (text){
                          if(text.length<6 || text.isEmpty){
                            setState(() {
                              _mobileValidate=true;
                            });
                          }else{
                            setState(() {
                              _mobileValidate=false;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: mobileController,
                        decoration: InputDecoration(
                            errorText: _mobileValidate?"Mobile no. must at least 10 digit":null,
                            labelText: 'Enter your Mobile no.',
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 3,color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(20),child: ElevatedButton(
                        onPressed: (){
                          phoneVerify();
                        }, child: const Text("Verify Mobile"))),

                    Text("No. "+no),

                    isverified?Icon(Icons.verified,color: Colors.green,size: 50,):Icon(Icons.verified,color: Colors.red,size: 50,),
                  ],
                ):Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
