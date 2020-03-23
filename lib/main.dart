import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/src/screens/pageTest.dart';
import 'src/locations.dart' as locations;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Trips AngelLira'),
              backgroundColor: Colors.blue[900],
            ),
            body: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: const LatLng(0, 0),
                zoom: 2,
              ),
              markers: _markers.values.toSet(),
            ),
            drawer: Drawer(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    color: Colors.blue[900],
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 30,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://gravatar.com/avatar/4d33af4c05bfb8a707a920cfe038be37?s=400&d=robohash&r=x'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Text(
                          'Usuário AngelLira',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          'usuario@angellira.com.br',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
                  ),
                  ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Profile',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      onTap: null                    

                      ),
                  ListTile(
                    leading: Icon(Icons.directions_bus),
                    title: Text('Trips Made',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.flash_on),
                    title: Text('Next Trips',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_back),
                    title: Text('Logout',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: null,
                  )
                ],
              ),
            )),
      );
}
