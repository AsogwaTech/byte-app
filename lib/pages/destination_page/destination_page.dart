//import 'package:etra_flutter/pages/alertdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../services/routes.dart';

class destination_page extends StatelessWidget {
  const destination_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Destination page'),
      ),
      body: (
      const Center(
        child: Text('Flutter Destination Page'),
      )
      ),
      // body: Column(
      //   children: [
      //     FloatingActionButton(
      //       child: const Text('Add yours'),
      //         onPressed:() {
      //            showUserDialog();
      //         }// return a dialog box
      //     ),
      //   ],
      );
  }
}


