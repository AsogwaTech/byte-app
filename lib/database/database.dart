import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class AppUser extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();// primary key
  TextColumn get name => text().named('user_name')();

  TextColumn get email => text().nullable()();

  //TextColumn get email => text().named('email')();

  TextColumn get phoneNumber => text().nullable()();
  
  //TextColumn get phoneNumber => text().named('phone_number')();

  TextColumn get token => text().nullable()();

  TextColumn get dateOfBirth => text(). nullable()();
  //TextColumn get dateOfBirth => text(). named('dateOfBirth')();

  TextColumn get imagePath => text().nullable()();
}

@DriftDatabase(tables: [AppUser])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
    MigrationStrategy get migration => MigrationStrategy(onUpgrade: (migrator, from, to) async{
     if (from ==1){
       await migrator.addColumn(appUser, appUser.imagePath);
     }
  });

  // @override
  // MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
  //       return m.createAll();
  //     }, onUpgrade: (Migrator m, int from, int to) async {
  //       if (from == 3) {
  //         // we added the dueDate property in the change from version 1
  //         await m.addColumn(individual, individual.token);
  //         await m.addColumn(individual, individual.dateCreated);
  //       }
  //       if (from == 4) {
  //         // we added the dueDate property in the change from version 1
  //         await m.addColumn(individual, individual.dateCreated);
  //       }
  //       if (from == 5) {
  //         // we added the dueDate property in the change from version 1
  //         await m.addColumn(individual, individual.trackingId);
  //         await m.addColumn(individual, individual.status);
  //       }
  //     });


// for resolving the conflicts when a username is already there and to manage the state of the database
//when a user log out.

  // Future<List<AppUserData>> getUserDetails() async {
  //   // hmm, there is an issue here
  //   return await select(appUser)
  //       .get();
    Future<List<AppUserData>> getUsers() => (select(appUser)).get();// Added by me for the list of users which will be shown on the listview

    Future<AppUserData?> getUser() =>
        (select(appUser)
          ..limit(1)).getSingleOrNull(); // get a single user details.

    Future<int?> insertOrUpdate(AppUserCompanion entity) {
      //using arrow notation for this function can also work
      return into(appUser).insertOnConflictUpdate(
          entity); // queries to insert and update the database data
    }
    //for me to be able to display the user data in real time at list view, i have to be watching this man using
    //streambuilder

    Future logout() {
      return (delete(appUser)).go(); // to delete users details
    }
  }

//to state the path of storage of the data in the database
  LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      // put the database file, called db.sqlite here, into the documents folder
      // for your app.
      final dbFolder = await getApplicationDocumentsDirectory();
      print( dbFolder.path);
      final file = File(path.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    });
  }

//to submit your user input when logged in or any other thing that needs to be stored in the database
//use this function on the onpressed function of the submit function
//onpressed(){
// setstate((){
// Appdatabase().insertorupdate(Appuserdata(
//username: Usernamecontroller.text,
//email: emailcontroller.text,
//password: passwordcontroller.text,));
// Then clear the textholder
//usernamecontroller.clear();
//emailcontroller.clear();
// })
// }
//Note: Snapshot.data is the list of all the data fetched from the local database
//stream builder is used to listen to the stream watch data for automation.


//add this to your database for watching the list of user
//Stream<List<AppUser>> WatchAllAppUser() => select(appuser).watch();

//StreamBuilder(
//stream: Database.WatchAllAppUser(),
//builder:(context, AsyncSnapshot<List<AppUser>>snapshot){
//return Listview,builder(
//itemBuilder:(_, index){
//return card(
//color: Colors.blue,
//child:LisTile(
//leading(
//circularAvatar(for holding the user pics
//child:backgroundImage(image.file
//title: Text(snapshot.data[index].username),
//trailing:......
//icon button for delete
//on pressed{setState
// Database.logout(snapshot.data[index])}
//itemcount=snapshot.data.length
