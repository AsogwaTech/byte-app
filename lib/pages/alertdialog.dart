import 'package:drift/drift.dart' as drift;
import 'package:etra_flutter/database/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({Key? key}) : super(key: key);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

 class _DialogBoxState extends State<DialogBox> {

   //late Database _database;
   final _formKey = GlobalKey<FormState>();

   ImagePicker picker = ImagePicker();
   File? _image;

   Future<void>_getImage() async{
     final image = await picker.pickImage(source: ImageSource.camera);
     Directory appPath = await getApplicationDocumentsDirectory();
     final fileName = path.basename(image!.path);
     String pathApp = appPath.path;
     final newImage = await File (image.path).copy('$pathApp/$fileName');
     setState(() {
       _image = newImage;
       Navigator.of(context).pop();
     });
   }

   Future<void>_getGalla() async{
     final image = await picker.pickImage(source: ImageSource.gallery);
     Directory appPath = await getApplicationDocumentsDirectory();
     final fileName = path.basename(image!.path);
     String pathApp = appPath.path;
     final newImage = await File (image.path).copy('$pathApp/$fileName');
     setState(() {
       _image = newImage;
       Navigator.of(context).pop();
     });
    // return File(newImage.path).create(recursive: true);
   }


   //String? newImage;

   // Future <void> _getImage() async {
   //   XFile? image = await picker.pickImage(source: ImageSource.camera);
   //   setState(() {
   //     _image = File(image!.path);
   //     //newImage = _image!.uri as String?;
   //     //Image? _image = File(image.path) as Image?;
   //   });
   //   Navigator.of(context).pop();
   // }
   //
   //
   // Future <void> _getGalla() async {
   //   XFile? image = await picker.pickImage(source: ImageSource.gallery);
   //   //newImage = Uri.parse(_image.toString());
   //   setState(() {
   //     _image = File(image!.path);
   //     //final newImage = Uri.parse(_image.toString());
   //    // _imageController.text = _image!.toString();
   //     //final newImage = _image!.uri as String?;
   //   });
   //   //final newImage = Uri.parse(_image.toString());
   //   Navigator.of(context).pop();
   // }
   //final newImage = Uri.parse(_image!.path.toString());


   // Future<void> saveImage() async{
   //   var pics = await Database.insertOrUpdate(_image);
   // }

   void camDia() {
     showDialog(context: context, builder: (_) {
       return AlertDialog(
         title: Text('Make your choice'),
         content: Container(
           height: MediaQuery
               .of(context)
               .size
               .height * 0.3,
           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               InkWell(
                 child: Padding(
                   padding: const EdgeInsets.only(bottom: 20),
                   child: Text('Take a photo'),
                 ),
                 onTap: _getImage,
                 //()async{
                 //   XFile? image =  await picker.pickImage(source: ImageSource.camera);
                 //   Navigator.of(context).pop();
                 // },
               ),
               InkWell(
                 child: Text('Import from gallery'),
                 onTap: _getGalla,
                 //()async{
                 //   XFile? image =  await picker.pickImage(source: ImageSource.gallery);
                 //   Navigator.of(context).pop();
                 // },
               ),
             ],
           ),
         ),
       );
     });
   }


   final TextEditingController _userNameController = TextEditingController();
   final TextEditingController _emailController = TextEditingController();
   final TextEditingController _phoneNumberController = TextEditingController();
   final TextEditingController _dateOfBirthController = TextEditingController();
  // final TextEditingController _imageController = TextEditingController();






   @override
   void initState() {
     super.initState();
     //_database = Database(); // initialize the database
   }

   @override
   void dispose() {
     //_database.close(); // closes the database connections
     _userNameController.dispose();
     _emailController.dispose();
     _phoneNumberController.dispose();
     _dateOfBirthController.dispose();
     //_image!.delete();
     super.dispose();


     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(
           title: const Text('Add User Details'),
           centerTitle: true,
           actions: [
             IconButton(
               onPressed: () {
                 final isValid = _formKey.currentState?.validate();
                 if (isValid != null && isValid) {
                   final entity = AppUserCompanion(

                     name: drift.Value(_userNameController.text),
                     email: drift.Value(_emailController.text),
                     phoneNumber: drift.Value(_phoneNumberController.text),
                     dateOfBirth: drift.Value(_dateOfBirthController.text),
                     //imagePath: drift.Value(_image?.uri.toString()),
                   );

                   Provider.of<Database>(context, listen: false).insertOrUpdate(entity).then((value) =>
                       ScaffoldMessenger.of(context)
                           .showMaterialBanner(
                         MaterialBanner(
                           backgroundColor: Colors.red,
                           content: Text('Details added successfully: $value',
                             style: TextStyle(color: Colors.white),),
                           actions: [
                             TextButton(
                               onPressed: () {
                                 ScaffoldMessenger.of(context)
                                     .hideCurrentMaterialBanner();
                                 Navigator.pop(context);
                               },
                               child: const Text('close',
                                 style: TextStyle(color: Colors.white),),
                             ),
                           ],
                         ),
                       ),

                   );
                 }
                 // final entity = UserDetailsCompanion(
                 //   UserName: drift.Value(_userNameController.text),
                 //   Email: drift.Value(_emailController.text),
                 //   Phone_number: drift.Value(_phoneNumberController.text),
                 //   DateOfBirth: drift.Value(_dateOfBirthController.text),
                 // );
                 //
                 // _dataBase.InsertUserDetail(entity).then((value) => ScaffoldMessenger.of(context)
                 // .showMaterialBanner(
                 //   MaterialBanner(
                 //     backgroundColor: Colors.red,
                 //       content:Text('Details added successfully: $value', style: TextStyle(color: Colors.white),),
                 //       actions: [
                 //         TextButton(
                 //             onPressed: (){
                 //               ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                 //               Navigator.pop(context);
                 //             },
                 //             child: const Text('close',style: TextStyle(color: Colors.white),),
                 //         ),
                 //       ],
                 //   ),
                 // ),
                 //
                 // );// A function that will insert the entities mentioned or entered by the user as stated above// ////o

               },
               icon: const Icon(Icons.save),
             ),
           ],
         ),
         body:
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               children: [
                 GestureDetector(
                   onTap: camDia,
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(50),
                     child: _image == null ? const Text('Add your image') : Image
                         .file(
                       _image!, height: 100, width: 100, fit: BoxFit.fill,),

                   ),
                 ),
                 const SizedBox(height: 20),
                 SingleChildScrollView(
                   child: Form(
                     key: _formKey,
                     // passing the global key of the formstate at the form position
                     child: Column(
                       children: [
                         TextFormField(
                           controller: _userNameController,
                           keyboardType: TextInputType.name,
                           decoration: InputDecoration(
                             border: OutlineInputBorder(),
                             label: Text('UserName'),
                           ),
                           validator: (String? value) {
                             if (value == null || value.isEmpty) {
                               return 'username cannot be empty';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(height: 10),
                         TextFormField(
                           controller: _emailController,
                           keyboardType: TextInputType.name,
                           decoration: InputDecoration(
                             border: OutlineInputBorder(),
                             label: Text('email'),
                           ),
                           validator: (String? value) {
                             if (value == null || value.isEmpty) {
                               return 'email cannot be empty';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(height: 10),
                         TextFormField(
                           controller: _phoneNumberController,
                           keyboardType: TextInputType.name,
                           decoration: InputDecoration(
                             border: OutlineInputBorder(),
                             label: Text('Phone Number'),
                           ),
                           validator: (String? value) {
                             if (value == null || value.isEmpty) {
                               return 'phone number cannot be empty';
                             }
                             return null;
                           },
                         ),
                         const SizedBox(height: 10),
                         TextFormField(
                           controller: _dateOfBirthController,
                           keyboardType: TextInputType.name,
                           decoration: InputDecoration(
                             border: OutlineInputBorder(),
                             label: Text('Date of birth'),
                           ),
                           validator: (String? value) {
                             if (value == null || value.isEmpty) {
                               return 'Date of birth cannot be empty';
                             }
                             return null;
                           },
                         ),
                       ],
                     ),

                   ),
                 ),
                 // TextFormField(
                 //   controller: _userNameController,
                 //   keyboardType: TextInputType.name,
                 //   decoration: InputDecoration(
                 //     border: OutlineInputBorder(),
                 //     label: Text('UserName'),
                 //   ),
                 //   validator: (String? value){
                 //     if (value ==null|| value.isEmpty){
                 //       return 'username cannot be empty';
                 //     }
                 //     return null;
                 //   },
                 // ),
                 // const SizedBox(height: 10),
                 // TextFormField(
                 //   controller: _emailController,
                 //   keyboardType: TextInputType.name,
                 //   decoration: InputDecoration(
                 //     border: OutlineInputBorder(),
                 //     label: Text('email'),
                 //   ),
                 //   validator: (String? value){
                 //     if (value ==null|| value.isEmpty){
                 //       return 'email cannot be empty';
                 //     }
                 //     return null;
                 //   },
                 // ),
                 // const SizedBox(height: 10),
                 // TextFormField(
                 //   controller: _phoneNumberController,
                 //   keyboardType: TextInputType.name,
                 //   decoration: InputDecoration(
                 //     border: OutlineInputBorder(),
                 //     label: Text('Phone Number'),
                 //   ),
                 //   validator: (String? value){
                 //     if (value ==null|| value.isEmpty){
                 //       return 'phone number cannot be empty';
                 //     }
                 //     return null;
                 //   },
                 // ),
                 // const SizedBox(height: 10),
                 // TextFormField(
                 //   controller: _dateOfBirthController,
                 //   keyboardType: TextInputType.name,
                 //   decoration: InputDecoration(
                 //     border: OutlineInputBorder(),
                 //     label: Text('Date of birth'),
                 //   ),
                 //   validator: (String? value){
                 //     if (value == null || value.isEmpty){
                 //       return 'Date of birth cannot be empty';
                 //     }
                 //     return null;
                 //   },
                 // ),
               ],
             ),
           ),
       );
     }
//     var Usernamecontroller = TextEditingController();// for holding the values entered by the users.
//     var Emailcontroller = TextEditingController();
//     var UserPhonecontroller = TextEditingController();
//     var UserBirthDatecontroller= TextEditingController();
//
//     // Future<void>pickDate(BuildContext context)async{
//     //   final initialDate = DateTime.now();
//     //   final newDate = await showDatePicker(
//     //     context: context,
//     //     initialDate: initialDate,
//     //     firstDate: DateTime(DateTime.now().year - 100),
//     //     lastDate: DateTime(DateTime.now().year + 1),
//     //     builder: (context, child)=> Theme(
//     //       data: ThemeData().copyWith(
//     //         colorScheme: const ColorScheme.light(
//     //           primary: Colors.pink,
//     //           onPrimary: Colors.white,
//     //           onSurface: Colors.black,
//     //         ),
//     //         dialogBackgroundColor: Colors.white,
//     //       ),
//     //       child: child?? const Text(''),
//     //     ),
//     //   );
//     //   if (newDate == null){
//     //     return;
//     //   }
//     //   setState(() {
//     //     String dob = DateFormat('dd/mm/yyyy').format(newDate);
//     //     UserBirthDatecontroller.text = dob;
//     //   });
//     // }
//
//
//     return SingleChildScrollView(
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.65,
//         padding: EdgeInsets.all(8),
//         child: Column(
//           children: [
//             Text('Add your details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
//             Container(
//               margin: EdgeInsets.all(5),
//               child: TextFormField(
//                    decoration: InputDecoration(
//                      labelText: 'username',
//                      border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(15),
//                        borderSide: BorderSide(
//                          color: Colors.black,
//                        )
//                      )
//                    ),
//                 controller: Usernamecontroller,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(5),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     labelText: 'email id',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(
//                           color: Colors.black,
//                         )
//                     )
//                 ),
//                 controller: Emailcontroller,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(5),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     labelText: 'phone number',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(
//                           color: Colors.black,
//                         )
//                     )
//                 ),
//                 controller: UserPhonecontroller,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(5),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     labelText: 'Date of birth',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(
//                           color: Colors.black,
//                         )
//                     )
//                 ),
//                 controller: UserBirthDatecontroller,
//                 //onTap: () =>pickDate(context),
//               ),
//             ),
//             CircleAvatar(
//               radius: 40,
//               child: Text('add image'),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 15.0),
//               child: FloatingActionButton.extended(
//                 icon: Icon(Icons.save),
//                 label: Text('Save Yours'),
//                 onPressed: (){},
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text('Add User Details'),
         centerTitle: true,
         actions: [
           IconButton(
             onPressed: () {
               print(Uri.parse(_image.toString())); // To test weather the path is saving on the database
               print(drift.Value(_image?.uri.toString()));
               print(_image?.uri);
               print(_image?.path);
               final isValid = _formKey.currentState?.validate();
               if (isValid != null && isValid) {
                 final entity = AppUserCompanion(
                   name: drift.Value(_userNameController.text),
                   email: drift.Value(_emailController.text),
                   phoneNumber:drift.Value (_phoneNumberController.text),
                   dateOfBirth: drift.Value(_dateOfBirthController.text),
                   // imagePath: drift.Value(_image!.path.toString()),
                   imagePath:drift.Value(_image?.uri.toString()),
                 );

                 Provider.of<Database>(context, listen: false).insertOrUpdate(entity).then((value) =>
                     ScaffoldMessenger.of(context)
                         .showMaterialBanner(
                       MaterialBanner(
                         backgroundColor: Colors.red,
                         content: Text('Details added successfully: $value',
                           style: TextStyle(color: Colors.white),),
                         actions: [
                           TextButton(
                             onPressed: () {
                               ScaffoldMessenger.of(context)
                                   .hideCurrentMaterialBanner();
                               Navigator.pop(context);
                             },
                             child: const Text('close',
                               style: TextStyle(color: Colors.white),),
                           ),
                         ],
                       ),
                     ),

                 );
               }
               // final entity = UserDetailsCompanion(
               //   UserName: drift.Value(_userNameController.text),
               //   Email: drift.Value(_emailController.text),
               //   Phone_number: drift.Value(_phoneNumberController.text),
               //   DateOfBirth: drift.Value(_dateOfBirthController.text),
               // );
               //
               // _dataBase.InsertUserDetail(entity).then((value) => ScaffoldMessenger.of(context)
               // .showMaterialBanner(
               //   MaterialBanner(
               //     backgroundColor: Colors.red,
               //       content:Text('Details added successfully: $value', style: TextStyle(color: Colors.white),),
               //       actions: [
               //         TextButton(
               //             onPressed: (){
               //               ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
               //               Navigator.pop(context);
               //             },
               //             child: const Text('close',style: TextStyle(color: Colors.white),),
               //         ),
               //       ],
               //   ),
               // ),
               //
               // );// A function that will insert the entities mentioned or entered by the user as stated above// ////o

             },
             icon: const Icon(Icons.save),
           ),
         ],
       ),
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: SingleChildScrollView(
           child: Column(
             children: [
               GestureDetector(
                 onTap: camDia,
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(50),
                   child: _image == null ? const Text('Add your image') : Image
                       .file(
                     _image!, height: 100, width: 100, fit: BoxFit.fill,),

                 ),
               ),
               const SizedBox(height: 20),
               Form(
                 key: _formKey,
                 // passing the global key of the formstate at the form position
                 child: Column(
                   children: [
                     TextFormField(
                       controller: _userNameController,
                       keyboardType: TextInputType.name,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(),
                         label: Text('UserName'),
                       ),
                       validator: (String? value) {
                         if (value == null || value.isEmpty) {
                           return 'username cannot be empty';
                         }
                         return null;
                       },
                     ),
                     const SizedBox(height: 10),
                     TextFormField(
                       controller: _emailController,
                       keyboardType: TextInputType.name,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(),
                         label: Text('email'),
                       ),
                       validator: (String? value) {
                         if (value == null || value.isEmpty) {
                           return 'email cannot be empty';
                         }
                         return null;
                       },
                     ),
                     const SizedBox(height: 10),
                     TextFormField(
                       controller: _phoneNumberController,
                       keyboardType: TextInputType.name,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(),
                         label: Text('Phone Number'),
                       ),
                       validator: (String? value) {
                         if (value == null || value.isEmpty) {
                           return 'phone number cannot be empty';
                         }
                         return null;
                       },
                     ),
                     const SizedBox(height: 10),
                     TextFormField(
                       controller: _dateOfBirthController,
                       keyboardType: TextInputType.name,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(),
                         label: Text('Date of birth'),
                       ),
                       validator: (String? value) {
                         if (value == null || value.isEmpty) {
                           return 'Date of birth cannot be empty';
                         }
                         return null;
                       },
                     ),
                   ],
                 ),

               ),
               // TextFormField(
               //   controller: _userNameController,
               //   keyboardType: TextInputType.name,
               //   decoration: InputDecoration(
               //     border: OutlineInputBorder(),
               //     label: Text('UserName'),
               //   ),
               //   validator: (String? value){
               //     if (value ==null|| value.isEmpty){
               //       return 'username cannot be empty';
               //     }
               //     return null;
               //   },
               // ),
               // const SizedBox(height: 10),
               // TextFormField(
               //   controller: _emailController,
               //   keyboardType: TextInputType.name,
               //   decoration: InputDecoration(
               //     border: OutlineInputBorder(),
               //     label: Text('email'),
               //   ),
               //   validator: (String? value){
               //     if (value ==null|| value.isEmpty){
               //       return 'email cannot be empty';
               //     }
               //     return null;
               //   },
               // ),
               // const SizedBox(height: 10),
               // TextFormField(
               //   controller: _phoneNumberController,
               //   keyboardType: TextInputType.name,
               //   decoration: InputDecoration(
               //     border: OutlineInputBorder(),
               //     label: Text('Phone Number'),
               //   ),
               //   validator: (String? value){
               //     if (value ==null|| value.isEmpty){
               //       return 'phone number cannot be empty';
               //     }
               //     return null;
               //   },
               // ),
               // const SizedBox(height: 10),
               // TextFormField(
               //   controller: _dateOfBirthController,
               //   keyboardType: TextInputType.name,
               //   decoration: InputDecoration(
               //     border: OutlineInputBorder(),
               //     label: Text('Date of birth'),
               //   ),
               //   validator: (String? value){
               //     if (value == null || value.isEmpty){
               //       return 'Date of birth cannot be empty';
               //     }
               //     return null;
               //   },
               // ),
             ],
           ),
         ),
       ),
     );
   }
//     var Usernamecontroller = TextEditingController();// for holding the values entered by the users.
//     var Emailcontroller = TextEditingController();
//     var UserPhonecontroller = TextEditingController();
//     var UserBirthDatecontroller= TextEditingController();
//
//     // Future<void>pickDate(BuildContext context)async{
//     //   final initialDate = DateTime.now();
//     //   final newDate = await showDatePicker(
//     //     context: context,
//     //     initialDate: initialDate,
//     //     firstDate: DateTime(DateTime.now().year - 100),
//     //     lastDate: DateTime(DateTime.now().year + 1),
//     //     builder: (context, child)=> Theme(
//     //       data: ThemeData().copyWith(
//     //         colorScheme: const ColorScheme.light(
//     //           primary: Colors.pink,
//     //           onPrimary: Colors.white,
//     //           onSurface: Colors.black,
//     //         ),
//     //         dialogBackgroundColor: Colors.white,
//     //       ),
//     //       child: child?? const Text(''),
//     //     ),
//     //   );
//     //   if (newDate == null){
//     //     return;
//     //   }
//     //   setState(() {
//     //     String dob = DateFormat('dd/mm/yyyy').format(newDate);
//     //     UserBirthDatecontroller.text = dob;
//     //   });
//     // }
//
//
//     return SingleChildScrollView(
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.65,
//         padding: EdgeInsets.all(8),
//         child: Column(
//           children: [
//             Text('Add your details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
//             Container(
//               margin: EdgeInsets.all(5),
//               child: TextFormField(
//                    decoration: InputDecoration(
//                      labelText: 'username',
//                      border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(15),
//                        borderSide: BorderSide(
//                          color: Colors.black,
//                        )
//                      )
//                    ),
//                 controller: Usernamecontroller,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(5),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     labelText: 'email id',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(
//                           color: Colors.black,
//                         )
//                     )
//                 ),
//                 controller: Emailcontroller,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(5),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     labelText: 'phone number',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(
//                           color: Colors.black,
//                         )
//                     )
//                 ),
//                 controller: UserPhonecontroller,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(5),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     labelText: 'Date of birth',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(
//                           color: Colors.black,
//                         )
//                     )
//                 ),
//                 controller: UserBirthDatecontroller,
//                 //onTap: () =>pickDate(context),
//               ),
//             ),
//             CircleAvatar(
//               radius: 40,
//               child: Text('add image'),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 15.0),
//               child: FloatingActionButton.extended(
//                 icon: Icon(Icons.save),
//                 label: Text('Save Yours'),
//                 onPressed: (){},
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
 }




