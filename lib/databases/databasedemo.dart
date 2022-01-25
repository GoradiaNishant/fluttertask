import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DatabaseDemo extends StatefulWidget {
  const DatabaseDemo({Key? key}) : super(key: key);

  @override
  _DatabaseDemoState createState() => _DatabaseDemoState();
}

class _DatabaseDemoState extends State<DatabaseDemo> {

  bool _userValidate=false;

  FocusNode nameFocusNode=FocusNode();

  TextEditingController nameController=TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final databaseReference = FirebaseDatabase.instance.ref();

  void addData(String pushedText) async {
    await databaseReference.child('demoTest').push().set({
      "pushedText":pushedText
    });
  }

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firebase Realtime Database"),),
      body: SingleChildScrollView(
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
                  textInputAction: TextInputAction.done,
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

              Padding(padding: const EdgeInsets.all(20),child: ElevatedButton(
                  onPressed: (){
                    addData(nameController.text);
                  }, child: const Text("Push")))
            ],
          ),
        ),
      ),
    );
  }
}
