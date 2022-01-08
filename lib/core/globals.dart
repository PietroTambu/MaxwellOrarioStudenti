library maxwell.globals;
import 'package:shared_preferences/shared_preferences.dart';

String defaultClass = '5ALS';
bool isLoading = false;

updateClass(String newClass) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'defaultClass';
    prefs.setString(key, newClass);
    print('new classe stored: $newClass');
    defaultClass = newClass;
}

setLoading(bool state) {
    isLoading = state;
}
