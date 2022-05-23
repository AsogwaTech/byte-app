//import 'dart:html';

//import 'dart:html';

import 'package:etra_flutter/pages/dashboard/dashboard.dart';
import 'package:etra_flutter/services/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../database/database.dart';
import '../../widgets/logo.dart';
import '../alertdialog.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'dart:io';
import 'dart:async';

class custom_dashboard extends StatefulWidget {
  //final String username_second;
  const custom_dashboard({Key? key, /*required this.username_second*/}) : super(key: key);

  @override
  _custom_dashboardState createState() => _custom_dashboardState(/*username_second*/);
}

class _custom_dashboardState extends State<custom_dashboard> {
  //final String username_second;
  _custom_dashboardState(/*this.username_second*/);
  //late Database _database;

  @override
  void initState(){
    super.initState();
    //_database = Database();// initialize the database
  }

  @override
  void dispose() {
    //_database.close();// closes the database connections
    super.dispose();
  }
  //File? _image;

  @override
  Widget build(BuildContext context) {
    // Image? newImage = userdetail.imagePath;

    // void showUserDialog(){// the function that should bw called when the button is pressed to display the dialog box
    //   showDialog(context: context, builder: (_){
    //     return AlertDialog(
    //       content: DialogBox(),//the name of the class that holds the text form field.
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     );
    //   });
    // }

    //_image = File(_image!.path);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add Details'),
        onPressed: (){
          //showUserDialog();
          Navigator.push(context, MaterialPageRoute(builder: (context) =>DialogBox()));
        },
      ),
      appBar: AppBar(backgroundColor: Colors.blue,
        title: Text('list of contacts'),
      ),
      body: FutureBuilder<List<AppUserData>>(
        future: Provider.of<Database>(context).getUsers(),// function from the database that will get all the details of available users already installed in the database
        builder: (context, AsyncSnapshot){// Asyncsnapshot fetches the data being stored in the local database
          final List<AppUserData>?userdetails = AsyncSnapshot.data; //take note of your named variable here very important ie the form of the list should tally with that of the database



          //var userdetails = AsyncSnapshot.data! as List<AppUserData>;

          if (AsyncSnapshot.connectionState != ConnectionState.done){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (AsyncSnapshot.hasError){
            return Center(
              child: Text(AsyncSnapshot.error.toString()),
            );
          }
          if (userdetails != null){
            return ListView.builder(
                itemCount: userdetails.length,
                itemBuilder: (ctx,index){
                  final userdetail = userdetails[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/edit_User', arguments: userdetail.id);//The userdetail here is to get the integer index which will serve as the pointer to the id
                    },
                    child: Card(
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment:  CrossAxisAlignment.start,
                          children: [
                            Text(userdetail.id.toString()),
                            Text(userdetail.name.toString()),
                            Text(userdetail.email.toString()),
                            Text(userdetail.phoneNumber.toString()),
                            Text(userdetail.dateOfBirth.toString()),
                            //Text(userdetail.imagePath.toString()),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: userdetail.imagePath == null ? const AssetImage('assets/images/Logo.png') : Image.file(File(userdetail.imagePath!)).image ,
                            ),
                            // CircleAvatar(
                            //   radius: 65.0,
                            //   backgroundImage:userdetail.imagePath == true ? Image.file(userdetail.imagePath).image : AssetImage('assets/images/Logo.png') as ImageProvider,
                            // )
                            // Container(
                            //   decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //       image: userdetail.imagePath == true ?Image.file(File(userdetail.imagePath!)).image :AssetImage('assets/images/Logo.png'),
                            //     ),
                            //
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }
          return const Text('no data found');// what is written on the button
        },
      ),
    );
  }
}

