import 'package:supabase_flutter/supabase_flutter.dart';

//Different classes can be created for different APIs, no specific use, just for organization purposes. Maybe an authenticaiton API can be created then before all functions that requrire auth call that function
class RegistrationApi {
  final supabase = Supabase.instance.client;

  //Each API function starts with static, when I acess from front end is just ClassName.functionName
  static Future<void> signUpUser(
      {required String email, required String password}) async {


    //Here is where the supabase api is placed.
    Future.delayed(Duration(seconds: 2));
    print("Email: ${email}\nPassword: ${password}");
  }
}
