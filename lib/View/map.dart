import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controller/payment_helper.dart';
import 'chat_view.dart';

class GPSMapPage extends StatefulWidget {
  GPSMapPage({super.key, required this.title});
  final String title;

  @override
  State<GPSMapPage> createState() => _GPSMapPageState();
}

class _GPSMapPageState extends State<GPSMapPage> {
  CameraPosition initCamera =
  CameraPosition(target: LatLng(48.781681, 1.9957494), zoom: 14);
  Completer<GoogleMapController> completer = Completer();
  Set<Marker> allMarkers = Set();

  init() {
    setState(() {
      allMarkers.add(Marker(
        markerId: MarkerId("Marker"),
        position: LatLng(48.7852356, 2.3722614),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          markers: {
            Marker(
              markerId: MarkerId('Versailles'), // anya
              position: LatLng(48.800411, 2.134795),
              onTap: () {
                makePayment(context, "Anya", "ub_2");
              },
            ),
            Marker(
              markerId: MarkerId('Plaisir'), // nezuku
              position: LatLng(48.815052, 1.956954),
              onTap: () {
                makePayment(context, "Nezuku", "ub_1");
              },
            ),
            Marker(
              markerId: MarkerId('Saint Quentin en Yveline'), // ikuzu
              position: LatLng(48.776689, 1.9871664),
              onTap: () {
                makePayment(context, "Izuku", "ub_3");
              },
            ),
            /*
            Marker(
              markerId: MarkerId('Vélizy'),
              position: LatLng(48.782204, 2.1897268),
              onTap: () {
                makePayment(context, );
              },
            ),
            Marker(
              markerId: MarkerId('Boulognes-Billancourt'),
              position: LatLng(48.832217, 2.2250891),
              onTap: () {
                makePayment(context);
              },
            ),
            Marker(
              markerId: MarkerId('Nanterre'),
              position: LatLng(48.892564, 2.206893),
              onTap: () {
                makePayment(context);
              },
            )
             */
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: initCamera,
          onMapCreated: (controller) {
            completer.complete(controller);
          },
        ));
  }

  void makePayment(BuildContext context, String uberName, String uberId){
    MyPaymentHelper().makePayment(context: context, amount: '24', currency: 'eur', uberName: uberName, uberId: uberId);
  }

}