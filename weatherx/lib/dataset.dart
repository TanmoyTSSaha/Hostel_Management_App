import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather {
  final int? max;
  final int? min;
  final int? current;
  final String? name;
  final String? day;
  final int? wind;
  final int? humidity;
  final int? chanceRain;
  final String? image;
  final String? time;
  final String? location;

  Weather({
    this.max,
    this.min,
    this.current,
    this.name,
    this.day,
    this.wind,
    this.humidity,
    this.chanceRain,
    this.image,
    this.time,
    this.location,
  });
}

String appId = "9e8c4f7652c78eafdd1fe21de5f5c30d";

Future<List> fetchData(String lat, String lon, String city) async {
  var url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$appId";
  var response = await http.get(Uri.parse(url));
  DateTime date = DateTime.now();
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    // Current Temp
    var current = res["current"];
    Weather currentTemp = Weather(
      current: current["temp"]?.round() ?? 0,
      name: current["weather"][0]["main"].toString(),
      day: DateFormat("EEEE dd MMMM").format(date),
      wind: current["wind_speed"]?.round() ?? 0,
      humidity: current["humidity"]?.round() ?? 0,
      chanceRain: current["uvi"]?.round() ?? 0,
      location: city,
      image: findIcon(current["weather"][0]["main"].toString(), true),
    );

    //Today Hourly Weather
    List<Weather> todayWeather = [];
    int hour = int.parse(DateFormat("hh").format(date));
    for (var i = 0; i < 4; i++) {
      var temp = res["hourly"];
      var hourly = Weather(
        current: temp[i]["temp"]?.round() ?? 0,
        image: findIcon(temp[i]["weather"][0]["main"].toString(), false),
        time: Duration(hours: hour + i + 1).toString().split(":")[0] + ":00",
      );
      todayWeather.add(hourly);
    }

    //Tomorrow Weather
    var daily = res["daily"][0];
    Weather tomorrowTemp = Weather(
      max: daily["temp"]["max"]?.round() ?? 0,
      min: daily["temp"]["min"]?.round() ?? 0,
      image: findIcon(daily["weather"][0]["main"].toString(), true),
      name: daily["weather"][0]["main"].toString(),
      wind: daily["wind_speed"]?.round() ?? 0,
      humidity: daily["rain"]?.round() ?? 0,
      chanceRain: daily["uvi"]?.round() ?? 0,
    );

    List<Weather> sevenDay = [];
    for (var i = 1; i < 8; i++) {
      String day = DateFormat("EEEE")
          .format(DateTime(date.year, date.month, date.day + i + 1))
          .substring(0, 3);
      var temp = res["daily"][i];
      var hourly = Weather(
        max: daily["temp"]["max"]?.round() ?? 0,
        min: daily["temp"]["min"]?.round() ?? 0,
        image: findIcon(temp["weather"][0]["main"].toString(), false),
        name: daily["weather"][0]["main"].toString(),
        day: day,
      );
      sevenDay.add(hourly);
    }
    return [currentTemp, todayWeather, tomorrowTemp, sevenDay];
  }
  return [null, null, null, null];
}

//Find Icon
String findIcon(String name, bool type) {
  if (type) {
    switch (name) {
      case "Clouds":
        return "assets/sunny.png";
        break;
      case "Rain":
        return "assets/rainy.png";
        break;
      case "Drizzle":
        return "assets/rainy.png";
        break;
      case "Thunderstorm":
        return "assets/thunder.png";
        break;
      case "Snow":
        return "assets/snow.png";
        break;
      default:
        return "assets/sunny.png";
    }
  } else {
    switch (name) {
      case "Clouds":
        return "assets/sunny_2d.png";
        break;
      case "Rain":
        return "assets/rainy_2d.png";
        break;
      case "Drizzle":
        return "assets/rainy_2d.png";
        break;
      case "Thunderstorm":
        return "assets/thunder_2d.png";
        break;
      case "Snow":
        return "assets/snow_2d.png";
        break;
      default:
        return "assets/sunny_2d.png";
    }
  }
}

class CityModel {
  final String? name;
  final String? lat;
  final String? lon;
  CityModel({this.lat, this.lon, this.name});
}

var cityJSON;

Future<CityModel?> fetchCity(String cityName) async {
  if (cityJSON == null) {
    String link =
        "https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json";
    var response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      cityJSON = json.decode(response.body);
    }
  }
  for (var i = 0; i < cityJSON.toString().length; i++) {
    if (cityJSON[i]["name"].toString().toLowerCase() ==
        cityName.toLowerCase()) {
      return CityModel(
        name: cityJSON[i]["name"].toString(),
        lat: cityJSON[i]["latitude"].toString(),
        lon: cityJSON[i]["longitude"].toString(),
      );
    }
  }
  return null;
}

// List<Weather> todayWeather = [
//   Weather(current: 23, image: "assets/rainy_2d.png", time: "10:00"),
//   Weather(current: 21, image: "assets/thunder_2d.png", time: "11:00"),
//   Weather(current: 22, image: "assets/rainy_2d.png", time: "12:00"),
//   Weather(current: 19, image: "assets/snow_2d.png", time: "01:00")
// ];

// Weather currentTemp = Weather(
//   current: 21,
//   image: "assets/thunder_2d.png",
//   name: "ThunderStorm",
//   day: "Monday, 17th May",
//   wind: 13,
//   humidity: 24,
//   chanceRain: 87,
//   location: "Tripura",
// );

// Weather tomorrowTemp = Weather(
//   max: 20,
//   min: 17,
//   image: "assets/sunny.png",
//   name: "Sunny",
//   wind: 9,
//   humidity: 31,
//   chanceRain: 20,
// );

// List<Weather> sevenDay = [
//   Weather(
//     max: 20,
//     min: 14,
//     image: "assets/rainy_2d.png",
//     day: "Mon",
//     name: "Rainy",
//   ),
//   Weather(
//     max: 22,
//     min: 16,
//     image: "assets/thunder_2d.png",
//     day: "Tue",
//     name: "Thunder",
//   ),
//   Weather(
//     max: 19,
//     min: 13,
//     image: "assets/rainy_2d.png",
//     day: "Wed",
//     name: "Rainy",
//   ),
//   Weather(
//     max: 18,
//     min: 12,
//     image: "assets/snow_2d.png",
//     day: "Thus",
//     name: "Snow",
//   ),
//   Weather(
//     max: 23,
//     min: 19,
//     image: "assets/sunny_2d.png",
//     day: "Fri",
//     name: "Sunny",
//   ),
//   Weather(
//     max: 25,
//     min: 17,
//     image: "assets/rainy_2d.png",
//     day: "Sat",
//     name: "Rainy",
//   ),
//   Weather(
//     max: 21,
//     min: 18,
//     image: "assets/thunder_2d.png",
//     day: "Sun",
//     name: "Thunder",
//   ),
// ];
