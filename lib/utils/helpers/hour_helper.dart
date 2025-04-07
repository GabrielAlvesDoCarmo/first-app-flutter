class HourHelpers {
  static int hoursToMinutes(String hours) {
    List<String> parts = hours.split(':');
    int hoursInt = int.parse(parts[0]);
    int minutesInt = int.parse(parts[1]);
    return hoursInt * 60 + minutesInt;
  }

  static String minutesToHours(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return '${hours.toString().padLeft(2,"0")}:${remainingMinutes.toString().padLeft(2,"0")}';
  }
}