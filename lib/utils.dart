import 'package:shared_preferences/shared_preferences.dart';

class Utils {
 static final String _instructionKey =  "INSTRUCTIONKEY";

static Future<bool> setInstruction(bool value) async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   return await preferences.setBool(_instructionKey, value);
 }
static Future getInstruction()async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   return  preferences.getBool(_instructionKey);
 }
}