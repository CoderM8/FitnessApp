import 'package:fitness_ui/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? userid;
String? languageCode;

Future<void> getUserId() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  userid = sharedPreferences.getString('userid');
  languageCode = sharedPreferences.getString('languageCode') ?? 'en';
  print('USER ID ID === $userid Local $languageCode');
  await UserProfile.getProfile();
}
