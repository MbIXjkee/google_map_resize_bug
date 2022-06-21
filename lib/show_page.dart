import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowPage extends StatefulWidget {
  const ShowPage({
    super.key,
  });

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              color: Colors.red,
            ),
            const Expanded(
              child: _Body(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: [
        _ResizableMap(),
        _Bottom(),
      ],
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          for (final n in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])
            Container(
              height: 100,
              color: n.isEven ? Colors.blue : Colors.amber,
            )
        ],
      ),
    );
  }
}

class _ResizableMap extends StatelessWidget {
  const _ResizableMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 500,
      flexibleSpace: _Map(),
    );
  }
}

class _Map extends StatefulWidget {
  const _Map({Key? key}) : super(key: key);

  @override
  State<_Map> createState() => _MapState();
}

class _MapState extends State<_Map> {
  final UniqueKey _mapKey = UniqueKey();
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GoogleMap(
        key: _mapKey,
        zoomControlsEnabled: false,
        gestureRecognizers: const {Factory(EagerGestureRecognizer.new)},
        onMapCreated: (controller) {
          _mapController?.dispose();
          _mapController = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            0,
            0,
          ),
        ),
      ),
    );
  }
}

class SimpleSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;
  final Widget child;

  SimpleSliverPersistentHeaderDelegate({
    this.minExtent = 0,
    this.maxExtent = 0,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double offset = maxExtent - shrinkOffset;
    final double percentageExpanded = offset / maxExtent;
    final double height =
        minExtent + (maxExtent - minExtent) * percentageExpanded;
    return SizedBox(
      height: height,
      child: child,
    );
  }

  @override
  bool shouldRebuild(SimpleSliverPersistentHeaderDelegate oldDelegate) =>
      minExtent != oldDelegate.minExtent ||
      maxExtent != oldDelegate.maxExtent ||
      child != oldDelegate.child;
}
