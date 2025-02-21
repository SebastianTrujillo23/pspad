import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  // Aquí puedes definir las opciones del mapa y marcadores
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Demo'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.7749, -122.4194), // Ubicación inicial
          zoom: 12.0,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        onTap: (LatLng position) {
          // Agregar un marcador cuando el mapa es tocado
          setState(() {
            _markers.add(Marker(
              markerId: MarkerId(position.toString()),
              position: position,
              infoWindow: InfoWindow(title: 'Marcador', snippet: 'Descripción del lugar'),
            ));
          });
        },
      ),
    );
  }
}


