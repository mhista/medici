import 'dart:async';

import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/appbar/searchBar.dart';
import 'package:medici/data/services/map_services/map_sevices.dart';
import 'package:medici/features/main_app/controller/map_controller.dart';
import 'package:medici/features/main_app/models/map/auto_complete_result.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

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
  int markerIdCounter = 1;
// DEBOUNCER TO THROTTLE ASYNC CALLS DURING SEARCH
  Timer? _debounce;

// Initial map position
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final TextEditingController searchController = TextEditingController();
  final TextEditingController originController = TextEditingController();

  final TextEditingController destinationController = TextEditingController();
  void _setMarker(point) {
    var counter = markerIdCounter++;
    final Marker marker = Marker(
        markerId: MarkerId('marker _$counter'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker);
    setState(() {
      _markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isDark = PHelperFunctions.isDarkMode(context);

    final allSearchResults = ref.watch(mapController);
    final searchFlag = ref.watch(searchToggleProvider);

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
                    color: isDark ? PColors.dark : PColors.light,
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
                                  _markers = {};
                                  ref
                                      .read(searchToggleProvider.notifier)
                                      .toggleSearch;
                                });
                              },
                              icon: const Icon(Icons.cancel_outlined)),
                          onChanged: (value) {
                            if (_debounce?.isActive ?? false) {
                              _debounce?.cancel();

                              _debounce = Timer(
                                  const Duration(milliseconds: 700), () async {
                                if (value.length > 2) {
                                  if (!searchFlag) {
                                    ref
                                        .read(searchToggleProvider.notifier)
                                        .toggleSearch;
                                    _markers = {};
                                  }
                                  List<AutoCompleteResult> searchResults =
                                      await MapServices().searchPlaces(value);
                                  ref
                                      .read(mapController.notifier)
                                      .setResults(searchResults);
                                } else {
                                  ref
                                      .read(mapController.notifier)
                                      .setResults([]);
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  searchFlag
                      ? allSearchResults.isNotEmpty
                          ? Positioned(
                              top: 100,
                              left: 15,
                              child: Container(
                                height: 200,
                                width: responsive.screenWidth - 30.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                child: ListView(
                                  children: [
                                    ...allSearchResults.map((e) =>
                                        buildListItem(e, searchFlag, context))
                                  ],
                                ),
                              ))
                          : Positioned(
                              top: 100,
                              left: 15,
                              child: Container(
                                  height: 200,
                                  width: responsive.screenWidth - 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text('No result to show'),
                                      const SizedBox(
                                        height: PSizes.spaceBtwItems,
                                      ),
                                      SizedBox(
                                        width: 125,
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Close This')),
                                      )
                                    ],
                                  )),
                            )
                      : Container(),
                  getDirection
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(15, 40, 15, 5),
                          child: Column(
                            children: [
                              Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: MSearchBar(
                                    hintText: 'Origin',
                                    textController: originController,
                                  )),
                              SizedBox(height: PSizes.spaceBtwItems),
                              Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MSearchBar(
                                  hintText: 'Destination',
                                  textController: destinationController,
                                  useSuffix: true,
                                  textFieldWidget: SizedBox(
                                    width: 96,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                searchToggle = false;
                                                destinationController.text = '';
                                                originController.text = '';
                                              });
                                            },
                                            icon: Icon(Icons.search)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.cancel_outlined))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container()
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
                  onPressed: () => setState(() {
                        searchToggle = false;
                        radiusSlider = false;
                        pressedNear = false;
                        cardTapped = false;
                        getDirection = true;
                      }),
                  icon: const Icon(Iconsax.location1)),
            ]));
  }

  Future<void> goToSearchedPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));
  }

  Widget buildListItem(
      AutoCompleteResult placeItem, searchFlag, BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
          onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onTap: () async {
            var place = await MapServices().getPlace(placeItem.placeId);
            goToSearchedPlace(place['geometry']['location']['lat'],
                place['geometry']['location']['lat']);
            ref.read(searchToggleProvider.notifier).toggleSearch;
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.green,
                size: 25.0,
              ),
              const SizedBox(
                width: PSizes.spaceBtwItems,
              ),
              SizedBox(
                height: 40.0,
                width: responsive.screenWidth - 75.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(placeItem.description ?? ''),
                ),
              )
            ],
          )),
    );
  }
}
