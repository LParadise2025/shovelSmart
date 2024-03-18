import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppState extends ChangeNotifier {


  //int cleanItemTotal = 0;
  // list all variables and their default values below

  //initializes varibles and sets their default values
  // variables vreated by appstate can be accessed from all other classes where AppState is imported



  Future<void> saveData() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setInt('cleanItemTotal', cleanItemTotal);
    // add all appState variables below 


  
// uses Shared Preferences to persist data within the app 
// this is called whenever the values are changed

  }



  


  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //cleanItemTotal = prefs.getInt('cleanItemTotal') ?? 0;
    // add all persisted variables here
   

    print("data loaded!");


    notifyListeners();

    // Using the Shared Preferences plugin, this method sets the AppState variables to the value that had been persisted (as long as it is not zero)
    // this is called every time the app is opened 

  }



//this method sets all of the variables used in the app to 0
// doing this allows the user to reset their progress
  void clearData(){
// set all vars to default 



    notifyListeners(); 
  }
 






  
}