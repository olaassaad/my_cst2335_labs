import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository {
  static String loginName = "";

  static String firstName = "";
  static String lastName = "";
  static String phoneNumber = "";
  static String emailAddress = "";

  static Future<void> loadData() async {
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

    DataRepository.firstName = await prefs.getString("FirstName");
    DataRepository.lastName = await prefs.getString("LastName");
    DataRepository.phoneNumber = await prefs.getString("PhoneNumber");
    DataRepository.emailAddress = await prefs.getString("EmailAddress");
  }

  static Future<void> saveData() async {
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

    await prefs.setString("FirstName", DataRepository.firstName);
    await prefs.setString("LastName", DataRepository.lastName);
    await prefs.setString("PhoneNumber", DataRepository.phoneNumber);
    await prefs.setString("EmailAddress", DataRepository.emailAddress);
  }
}