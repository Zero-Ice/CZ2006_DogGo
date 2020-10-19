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

// Get weather code
String getWeatherCodeFromForecast(String forecast) {
  String weatherCode = "";
  switch (forecast) {
    case "ForecastEnum.CLOUDY":
      weatherCode = 'wi-day-cloudy';
      break;
    case "ForecastEnum.HEAVY_THUNDERY_SHOWERS_WITH_GUSTY_WINDS":
      weatherCode = 'wi-day-thunderstorm';
      break;
    case "ForecastEnum.LIGHT_RAIN":
      weatherCode = 'wi-day-rain';
      break;
    case "ForecastEnum.MODERATE_RAIN":
      weatherCode = 'wi-day-rain-wind';
      break;
    case "ForecastEnum.THUNDERY_SHOWERS":
      weatherCode = 'wi-thunderstorm';
      break;
    default:
      weatherCode = 'wi-day-cloudy';
  }

  return weatherCode;
}