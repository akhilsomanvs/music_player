class AppDateUtils {
  static List<String> _monthList = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  static String getDateFromDateTime(DateTime dateTime) {
    String month = _monthList[dateTime.month - 1];
    String dateToReturn = "${dateTime.day} $month ${dateTime.year}";
    return dateToReturn;
  }

  static String getCurrentDate() {
    DateTime dateTime = DateTime.now();
    return getDateFromDateTime(dateTime);
  }

  static TimeGreeting getGreetingTime() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return TimeGreeting.MORNING;
    }
    if (hour < 17) {
      return TimeGreeting.AFTERNOON;
    }
    return TimeGreeting.EVENING;
  }
}

enum TimeGreeting {
  MORNING,
  AFTERNOON,
  EVENING,
}
