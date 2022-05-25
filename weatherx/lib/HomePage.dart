import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherx/dataset.dart';
import 'package:weatherx/detailView.dart';

Weather? currentTemp;
Weather? tomorrowTemp;
List<Weather>? todayWeather;
List<Weather>? sevenDay;
String lat = "24";
String lon = "92";
String city = "Raipur";

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getData() async {
    fetchData(lat, lon, city).then((value) {
      currentTemp = value[0];
      todayWeather = value[1];
      tomorrowTemp = value[2];
      sevenDay = value[3];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: currentTemp == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  CurrentWeather(getData),
                  TodayWeather(),
                ],
              ),
            ),
    );
  }
}

class CurrentWeather extends StatefulWidget {
  final Function() updateData;
  CurrentWeather(this.updateData);
  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  bool searchBar = false;
  bool updating = false;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchBar) {
          setState(() {
            searchBar = false;
          });
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height - 200,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.only(
          top: 50,
          left: 30,
          right: 30,
        ),
        decoration: BoxDecoration(
          color: Color(0xff00a1ff).withOpacity(1),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
          ),
        ),
        child: Column(
          children: [
            Container(
              child: searchBar
                  ? TextField(
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Color(0xff030317),
                        filled: true,
                        hintText: "Enter a City Name",
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) async {
                        CityModel? temp = await fetchCity(value);
                        if (temp == null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color(0xff030317),
                                title: const Text("City not found"),
                                content: const Text(
                                    "Please check the city you have entered!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Okay"),
                                  ),
                                ],
                              );
                            },
                          );
                          searchBar = false;
                          return;
                        }
                        city = temp.name!;
                        lat = temp.lat!;
                        lon = temp.lon!;
                        updating = true;
                        setState(() {});
                        widget.updateData();
                        searchBar = false;
                        updating = false;
                        setState(() {});
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          CupertinoIcons.square_grid_2x2,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.map_fill,
                              color: Colors.white,
                            ),
                            GestureDetector(
                              onTap: () {
                                searchBar = true;
                                setState(() {});
                                focusNode.requestFocus();
                              },
                              child: Text(
                                " " + city,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ],
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(width: 0.2, color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                updating ? "Updating" : "Updated",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 300,
              child: Stack(
                children: [
                  SizedBox(
                    height: 175,
                    width: 175,
                    child: Image(
                      image: AssetImage(currentTemp!.image!),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            currentTemp!.current.toString() + "\u00B0",
                            style: TextStyle(
                              height: 0.1,
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            currentTemp!.name!,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 5),
                          Text(
                            currentTemp!.day!,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 1,
            ),
            SizedBox(height: 10),
            ExtraWeather(currentTemp!),
          ],
        ),
      ),
    );
  }
}

class TodayWeather extends StatelessWidget {
  const TodayWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DetailView(tomorrowTemp: tomorrowTemp, sevenDay: []),
                    ),
                  );
                },
                child: Row(
                  children: const [
                    Text(
                      "7 Days",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherWidget(todayWeather![0]),
                WeatherWidget(todayWeather![1]),
                WeatherWidget(todayWeather![2]),
                WeatherWidget(todayWeather![3]),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  WeatherWidget(this.weather);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(width: 0.2, color: Colors.white),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        children: [
          Text(
            weather.current.toString() + "\u00B0C",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
          Image(
            image: AssetImage(weather.image!),
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 5),
          Text(
            weather.time!,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class ExtraWeather extends StatelessWidget {
  final Weather temp;
  // const ExtraWeater({Key? key, this.temp}) : super(key: key);
  ExtraWeather(this.temp);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              CupertinoIcons.wind,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              temp.wind.toString() + " Km/h",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Wind",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.wind,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              temp.chanceRain.toString() + " %",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Rain",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.wind,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              temp.humidity.toString() + " %",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Humidity",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
