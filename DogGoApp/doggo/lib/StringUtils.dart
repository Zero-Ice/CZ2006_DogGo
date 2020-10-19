String toHourString(int hour) {
  if (hour < 10) {
    return "0" + hour.toString() + ":00:00";
  } else if (hour >= 25) {
    return "0" + (hour - 24).toString() + ":00:00";
  }

  return hour.toString() + ":00:00";
}

String hourStringRemoveSeconds(String hourString) {
  String result = null;
  if((hourString != null) && hourString.length > 0) {
    result = hourString.substring(11, hourString.length - 3);
  }
  return result;
}