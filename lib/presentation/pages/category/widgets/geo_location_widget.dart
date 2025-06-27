import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/presentation/pages/category/widgets/location_widget.dart';

class GeoLocationWidget extends StatefulWidget {
  final int providerId;
  final LatLng latLng;
  const GeoLocationWidget({super.key, required this.latLng, required this.providerId});

  @override
  State<GeoLocationWidget> createState() => _GeoLocationWidgetState();
}

class _GeoLocationWidgetState extends State<GeoLocationWidget> {
  late final GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'Location',
            style: context.textStyle.sfProBold.copyWith(
              color: context.colors.whiteColor,
              fontSize: 20,
              height: 25 / 20,
            ),
          ),
          const Gap(16),

          SizedBox(
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(target: widget.latLng, zoom: 13),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                markers: {
                  Marker(
                    alpha: 1,
                    markerId: MarkerId('${widget.providerId}'),
                    position: widget.latLng,
                  ),
                },
              ),
            ),
          ),
          const Gap(10),
          LocationWidget(needsPadding: false, textColor: context.colors.whiteColor),
        ],
      ),
    );
  }
}
