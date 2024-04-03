import 'dart:async';

import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/appbar/searchBar.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../utils/constants/colors.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

// Toggling UI as needed
  bool searchToggle = false;
  bool radiusSlider = false;
  bool pressedNear = false;
  bool cardTapped = false;
  bool getDirection = false;

// MARKERS SET
  Set<Marker> _markers = <Marker>{};
// DEBOUNCER TO THROTTLE ASYNC CALLS DURING SEARCH
  Timer? _debounce;

// Initial map position
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: responsive.screenHeight,
                    width: responsive.screenWidth,
                    child: GoogleMap(
                      initialCameraPosition: _kGooglePlex,
                      markers: _markers,
                      mapType: MapType.normal,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                  // SEARCH BAR
                  if (searchToggle)
                    Positioned(
                      top: 50,
                      child: SizedBox(
                        width: responsive.screenWidth,
                        child: MSearchBar(
                          textController: searchController,
                          hintText: 'Search..',
                          usePrefixSuffix: true,
                          textFieldWidget: IconButton(
                              onPressed: () {
                                setState(() {
                                  searchToggle = false;
                                  searchController.text = '';
                                });
                              },
                              icon: const Icon(Icons.cancel_outlined)),
                          onChanged: (value) {
                            if (_debounce?.isActive ?? false) {
                              _debounce?.cancel();

                              _debounce =
                                  Timer(Duration(milliseconds: 700), () async {
                                if (value.length > 2) {}
                              });
                            }
                          },
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FabCircularMenuPlus(
            alignment: Alignment.bottomLeft,
            fabColor: PColors.primary,
            fabOpenColor: PColors.warning,
            ringWidth: 60.0,
            ringColor: Colors.blue.shade50,
            ringDiameter: 340.0,
            fabSize: 60.0,
            fabMargin: const EdgeInsets.all(30),
            children: [
              const SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () => setState(() {
                        searchToggle = true;
                        radiusSlider = false;
                        pressedNear = false;
                        cardTapped = false;
                        getDirection = false;
                      }),
                  icon: const Icon(Iconsax.search_normal)),
              IconButton(
                  onPressed: () => setState(() {}),
                  icon: const Icon(Iconsax.location1)),
            ]));
  }
}
