import 'package:flutter/material.dart';
import 'package:weatherx/HomePage.dart';
import 'package:weatherx/dataset.dart';

class DetailView extends StatelessWidget {
  final Weather? tomorrowTemp;
  final List<Weather>? sevenDay;
  const DetailView({this.tomorrowTemp, this.sevenDay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: Column(
        children: [
          TomorrowWeather(tomorrowTemp),
          SevenDays(sevenDay),
        ],
      ),
    );
  }
}

class TomorrowWeather extends StatelessWidget {
  final Weather? tomorrowTemp;
  TomorrowWeather(this.tomorrowTemp);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff00a1ff),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 50, bottom: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: const [
                    Icon(Icons.calendar_today_outlined, color: Colors.white),
                    Text(
                      " 7 Days",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Icon(Icons.more_vert_outlined, color: Colors.white),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: MediaQuery.of(context).size.width / 2.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(tomorrowTemp!.image!),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Tomorrow",
                      style: TextStyle(
                          fontSize: 30,
                          height: 0.1,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 105,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            tomorrowTemp!.max!.toString(),
                            style: const TextStyle(
                                fontSize: 100, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "/" + tomorrowTemp!.min!.toString() + "\u00B0",
                            style: TextStyle(
                                color: Colors.black54.withOpacity(0.3),
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      " " + tomorrowTemp!.name!,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, right: 50, left: 50),
            child: Column(
              children: [
                Divider(color: Colors.white),
                SizedBox(height: 10),
                ExtraWeather(tomorrowTemp!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  final List<Weather>? sevenDay;

  SevenDays(this.sevenDay);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: sevenDay!.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sevenDay![index].day!,
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  width: 135,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage(sevenDay![index].image!),
                        width: 40,
                      ),
                      SizedBox(height: 15, width: 10),
                      Text(
                        sevenDay![index].name!,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "+" + sevenDay![index].max!.toString() + "\u00B0C",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "+" + sevenDay![index].min!.toString() + "\u00B0C",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
