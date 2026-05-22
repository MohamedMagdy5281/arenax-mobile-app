import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:arenax_mobile_app/core/utils/colors.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/core/widgets/custom_button.dart';
import 'package:arenax_mobile_app/features/Authentication/presentation/manager/locationRiverpod/location_notifier_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

class LocationViewBody extends ConsumerStatefulWidget {
  const LocationViewBody({super.key});

  @override
  ConsumerState<LocationViewBody> createState() => _LocationViewBodyState();
}

class _LocationViewBodyState extends ConsumerState<LocationViewBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(locationNotifierProvider);
    final notifier = ref.read(locationNotifierProvider.notifier);

    if (state.currentPosition == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              if (!state.mapController.isCompleted) {
                state.mapController.complete(controller);
              }
            },
            onTap: (argument) async {
              await notifier.updateTargetPosition(argument);
            },
            initialCameraPosition: CameraPosition(
              target: state.currentPosition!,
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: MarkerId("_userPosition"),
                icon: state.customMarker ?? BitmapDescriptor.defaultMarker,
                position: LatLng(
                  state.currentPosition!.latitude,
                  state.currentPosition!.longitude,
                ),
              ),
            },
          ),
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(12),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .searchNewAddress,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 12,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: const Icon(
                                Icons.search,
                                color: kPrimaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  notifier.clearSuggestions();
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                                    border: Border(
                                      right: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: globals.appLang == "en"
                                      ? Icon(Iconsax.arrow_left_2)
                                      : Icon(Iconsax.arrow_right_2),
                                ),
                              ),
                            ),
                            onChanged: (value) async {
                              if (value.trim().isEmpty) {
                                notifier.clearSuggestions();
                                return;
                              }

                              final suggestions =
                                  await notifier.placeAutocomplete(value);

                              notifier.setSuggestions(suggestions);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async {
                          final pos = state.currentPosition;
                          if (pos != null) {
                            final controller = await state.mapController.future;
                            controller.animateCamera(
                              CameraUpdate.newLatLng(
                                LatLng(pos.latitude, pos.longitude),
                              ),
                            );
                            await notifier.updateTargetPosition(pos);
                          }
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.my_location,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 👇 DROPDOWN FIX HERE
                  if (state.suggestions.isNotEmpty)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        margin: const EdgeInsets.only(top: 6),
                        constraints: const BoxConstraints(maxHeight: 250),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.suggestions.length,
                          itemBuilder: (context, index) {
                            final suggestion = state.suggestions[index];

                            return ListTile(
                              title: Text(suggestion.description),
                              onTap: () async {
                                final location = await notifier
                                    .getPlaceLocation(suggestion.placeId);

                                await notifier.updateTargetPosition(location);

                                notifier.clearSuggestions();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 16,
            right: 16,
            child: CustomButton(
              text: AppLocalizations.of(context)!.add,
              itemCallBack: () {},
            ),
          ),
        ],
      ),
    );
  }
}
