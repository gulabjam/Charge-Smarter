import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;

class FlutterMap extends StatefulWidget {
  const FlutterMap({super.key});

  @override
  State<FlutterMap> createState() => _FlutterMapState();
}

class _FlutterMapState extends State<FlutterMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Location _locationcontroller = Location();
  LatLng? _currentP;
  Set<Marker> _markers = {};
  List<LatLng> _routePoints = [];
  static const String _apikey = "";

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
              polylines: {
                if (_routePoints.isNotEmpty)
                  Polyline(
                    polylineId: const PolylineId('route'),
                    points: _routePoints,
                    color: Colors.blue,
                    width: 5,
                  ),
              },
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 16);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationcontroller.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationcontroller.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _locationcontroller.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationcontroller.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _locationcontroller.onLocationChanged.listen((LocationData currentLocation) async {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        final newLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);

        if (_currentP == null || _currentP != newLocation) {
          setState(() {
            _currentP = newLocation;
          });

          await _cameraToPosition(newLocation);
          await _fetchAndDisplayChargingStations(newLocation.latitude, newLocation.longitude);
        }
      }
    });
  }

  Future<void> _fetchAndDisplayChargingStations(double latitude, double longitude) async {
    try {
      final stations = await _fetchChargingStations(latitude, longitude);
      setState(() {
        _markers = stations.map((station) {
          return Marker(
            markerId: MarkerId(station['id']),
            position: LatLng(station['latitude'], station['longitude']),
            infoWindow: InfoWindow(
              title: station['name'],
              snippet: "EV Charging Station",
            ),
          );
        }).toSet();

        _markers.add(
          Marker(
            markerId: const MarkerId("currentLocation"),
            position: _currentP!,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: const InfoWindow(title: "Your Location"),
          ),
        );
      });

      if (stations.isNotEmpty) {
        _routeToNearestStation(stations);
      }
    } catch (e) {
      debugPrint("Error fetching stations: $e");
    }
  }

  Future<void> _routeToNearestStation(List<Map<String, dynamic>> stations) async {
    final nearestStation = stations.reduce((a, b) {
      final distA = _calculateDistance(_currentP!, LatLng(a['latitude'], a['longitude']));
      final distB = _calculateDistance(_currentP!, LatLng(b['latitude'], b['longitude']));
      return distA < distB ? a : b;
    });

    final directions = await _fetchRoute(_currentP!, LatLng(nearestStation['latitude'], nearestStation['longitude']));
    setState(() {
      _routePoints = directions;
    });
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const p = 0.017453292519943295; 
    final a = 0.5 -
        cos((end.latitude - start.latitude) * p) / 2 +
        cos(start.latitude * p) *
            cos(end.latitude * p) *
            (1 - cos((end.longitude - start.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a)); 
  }

  Future<List<LatLng>> _fetchRoute(LatLng start, LatLng end) async {
    final url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$_apikey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final points = data['routes'][0]['overview_polyline']['points'];
      return PolylinePoints().decodePolyline(points).map((point) {
        return LatLng(point.latitude, point.longitude);
      }).toList();
    } else {
      throw Exception("Failed to fetch route");
    }
  }

  Future<List<Map<String, dynamic>>> _fetchChargingStations(double latitude, double longitude) async {
    final radius = 5000; // Search within 5km
    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=charging_station&key=$_apikey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results'].map((place) => {
            "id": place['place_id'],
            "name": place['name'],
            "latitude": place['geometry']['location']['lat'],
            "longitude": place['geometry']['location']['lng'],
          }));
    } else {
      throw Exception("Failed to fetch charging stations");
    }
  }
}
