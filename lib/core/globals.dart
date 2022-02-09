library maxwell.globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

String defaultClass = '5ALS';
bool isLoading = false;
List en_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
String mode = 'light';
bool firstAccess = true;

updateClass(String newClass) async {
    firstAccess = false;
    final prefs = await SharedPreferences.getInstance();
    const key = 'defaultClass';
    prefs.setString(key, newClass);
    print('new classe stored: $newClass');
    defaultClass = newClass;
}

updateColorMode() async {
    mode = mode == 'light' ? 'dark' : 'light';
    final prefs = await SharedPreferences.getInstance();
    const key = 'colorMode';
    prefs.setString(key, mode);
    print('changed colorMode: $mode');
}

setLoading(bool state) {
    isLoading = state;
}

getDate(int index, String format) {
    final DateTime now = DateTime.now();
    final DateFormat weekdayFormatter = DateFormat('EEEE');
    final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

    int todayIndex = en_days.indexOf(weekdayFormatter.format(now));

    int difference = 0;

    if (index != todayIndex) {
        if (todayIndex == 6) {
            todayIndex = 0;
            difference = index - todayIndex + 1;
        } else {
            difference = index - todayIndex;
        }
    }

    final DateTime returnDateTime = DateTime.now().add(Duration(days: difference));

    final String returnWeekDay = weekdayFormatter.format(returnDateTime);
    final String returnDate = dateFormatter.format(returnDateTime);


    if (format == 'WeekDay') {
        return returnWeekDay.toString();
    } else if (format == 'date') {
        return returnDate.toString();
    } else {
        return 'invalid props';
    }
}

getTodayIndex() {
    final DateTime now = DateTime.now();
    final DateFormat weekdayFormatter = DateFormat('EEEE');
    final String today = weekdayFormatter.format(now);
    final int index = en_days.indexOf(today);
    if (index == 6) {
        return 0;
    } else {
        return index;
    }
}
