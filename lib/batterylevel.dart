import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:sample_app/map.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BatteryLevel extends StatefulWidget {
  const BatteryLevel({super.key});

  @override
  State<BatteryLevel> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BatteryLevel> {
  Battery b = Battery();
  int showBatterLevel = 0;
  BatteryState state = BatteryState.discharging;
  bool broadcastBattery = true;

  Color COLOR_RED = Colors.red;
  Color COLOR_GREEN = Color.fromARGB(255, 0, 169, 181);
  Color COLOR_GREY = Colors.grey;

  @override
  void initState() {
    super.initState();
    _broadcastBatteryLevels();
    b.onBatteryStateChanged.listen((event) {
      setState(() {
        state = event;
      });
    });
  }

  _broadcastBatteryLevels() async {
    broadcastBattery = true;
    while (broadcastBattery) {
      var blvls = await b.batteryLevel;
      setState(() {
        showBatterLevel = blvls;
      });
      await Future.delayed(Duration(seconds: 3));
    }
  }

  @override
  void dispose() {
    super.dispose();
    setState(() {
      broadcastBattery = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("battery_background.jpeg"), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          spreadRadius: -5,
                          offset: Offset(4, 4),
                          color: COLOR_GREY)
                    ]),
                child: SfRadialGauge(
                  axes: [
                    RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      startAngle: 270,
                      endAngle: 270,
                      showLabels: false,
                      showTicks: false,
                      axisLineStyle: AxisLineStyle(
                          thickness: 1,
                          color:
                              showBatterLevel <= 10 ? COLOR_RED : COLOR_GREEN,
                          thicknessUnit: GaugeSizeUnit.factor),
                      pointers: <GaugePointer>[
                        RangePointer(
                          value: double.parse(showBatterLevel.toString()),
                          width: 0.3,
                          color: Colors.white,
                          pointerOffset: 0.1,
                          cornerStyle: showBatterLevel == 100
                              ? CornerStyle.bothFlat
                              : CornerStyle.endCurve,
                          sizeUnit: GaugeSizeUnit.factor,
                        )
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          positionFactor: 0.01,
                          angle: 90,
                          widget: Text(
                            showBatterLevel == 0
                                ? '0'
                                : showBatterLevel.toString() + "%",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        batteryContainer(
                            70,
                            Icons.power,
                            40,
                            showBatterLevel <= 10 ? COLOR_RED : COLOR_GREEN,
                            state == BatteryState.charging),
                        batteryContainer(
                            70,
                            Icons.power_off,
                            40,
                            showBatterLevel <= 10 ? COLOR_RED : COLOR_GREEN,
                            state == BatteryState.discharging),
                        batteryContainer(
                            70,
                            Icons.battery_charging_full,
                            40,
                            showBatterLevel <= 10 ? COLOR_RED : COLOR_GREEN,
                            state == BatteryState.full),
                      ],
                    ),
                  )),
              Container(
                child: TextButton(
                  onPressed: () async {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FlutterMap()));
                  },
                  child: Text(
                    'Route To your nearest charging station',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget batteryContainer(double size, IconData icon, double iconSize,
      Color iconColor, bool hasGlow) {
    return Container(
      width: size,
      height: size,
      child: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            hasGlow
                ? BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 0),
                    color: iconColor)
                : BoxShadow(
                    blurRadius: 7,
                    spreadRadius: -5,
                    offset: Offset(2, 2),
                    color: COLOR_GREY)
          ]),
    );
  }
}
