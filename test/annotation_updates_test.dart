// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:apple_maps_flutter_plus/apple_maps_flutter.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_maps_controllers.dart';

Set<Annotation> _toSet({Annotation? m1, Annotation? m2, Annotation? m3}) {
  final Set<Annotation> res = Set<Annotation>.identity();
  if (m1 != null) {
    res.add(m1);
  }
  if (m2 != null) {
    res.add(m2);
  }
  if (m3 != null) {
    res.add(m3);
  }
  return res;
}

Widget _mapWithAnnotations(Set<Annotation>? annotations) {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  return Directionality(
    textDirection: TextDirection.ltr,
    child: AppleMap(
      initialCameraPosition: const CameraPosition(target: LatLng(10.0, 15.0)),
      annotations: annotations,
    ),
  );
}

void main() {
  final FakePlatformViewsController fakePlatformViewsController =
      FakePlatformViewsController();

  setUpAll(() {
    SystemChannels.platform_views.setMockMethodCallHandler(
        fakePlatformViewsController.fakePlatformViewsMethodHandler);
  });

  setUp(() {
    fakePlatformViewsController.reset();
  });

  testWidgets('Initializing an annotation', (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final Annotation m1 =
        Annotation(annotationId: AnnotationId("annotation_1"));
    await tester.pumpWidget(_mapWithAnnotations(_toSet(m1: m1)));

    final FakePlatformAppleMap platformAppleMap =
        fakePlatformViewsController.lastCreatedView!;
    expect(platformAppleMap.annotationsToAdd!.length, 1);

    final Annotation initializedAnnotation =
        platformAppleMap.annotationsToAdd!.first;
    expect(initializedAnnotation, equals(m1));
    expect(platformAppleMap.annotationIdsToRemove!.isEmpty, true);
    expect(platformAppleMap.annotationsToChange!.isEmpty, true);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("Adding an annotation", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final Annotation m1 =
        Annotation(annotationId: AnnotationId("annotation_1"));
    final Annotation m2 =
        Annotation(annotationId: AnnotationId("annotation_2"));

    await tester.pumpWidget(_mapWithAnnotations(_toSet(m1: m1)));
    await tester.pumpWidget(_mapWithAnnotations(_toSet(m1: m1, m2: m2)));

    final FakePlatformAppleMap platformAppleMap =
        fakePlatformViewsController.lastCreatedView!;
    expect(platformAppleMap.annotationsToAdd!.length, 1);

    final Annotation addedAnnotation = platformAppleMap.annotationsToAdd!.first;
    expect(addedAnnotation, equals(m2));
    expect(platformAppleMap.annotationIdsToRemove!.isEmpty, true);

    // Unchanged annotations (m1) are not re-sent across the channel.
    expect(platformAppleMap.annotationsToChange!.isEmpty, true);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("Removing an annotation", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final Annotation m1 =
        Annotation(annotationId: AnnotationId("annotation_1"));

    await tester.pumpWidget(_mapWithAnnotations(_toSet(m1: m1)));
    await tester.pumpWidget(_mapWithAnnotations(null));

    final FakePlatformAppleMap platformAppleMap =
        fakePlatformViewsController.lastCreatedView!;
    expect(platformAppleMap.annotationIdsToRemove!.length, 1);
    expect(
        platformAppleMap.annotationIdsToRemove!.first, equals(m1.annotationId));

    expect(platformAppleMap.annotationsToChange!.isEmpty, true);
    expect(platformAppleMap.annotationsToAdd!.isEmpty, true);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("Updating an annotation", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final Annotation m1 =
        Annotation(annotationId: AnnotationId("annotation_1"));
    final Annotation m2 =
        Annotation(annotationId: AnnotationId("annotation_1"), alpha: 0.5);

    await tester.pumpWidget(_mapWithAnnotations(_toSet(m1: m1)));
    await tester.pumpWidget(_mapWithAnnotations(_toSet(m1: m2)));

    final FakePlatformAppleMap platformAppleMap =
        fakePlatformViewsController.lastCreatedView!;
    expect(platformAppleMap.annotationsToChange!.length, 1);
    expect(platformAppleMap.annotationsToChange!.first, equals(m2));

    expect(platformAppleMap.annotationIdsToRemove!.isEmpty, true);
    expect(platformAppleMap.annotationsToAdd!.isEmpty, true);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("Updating an annotation", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final Annotation m1 =
        Annotation(annotationId: AnnotationId("annotation_1"));
    final Annotation m2 = Annotation(
      annotationId: AnnotationId("annotation_1"),
      infoWindow: const InfoWindow(snippet: 'changed'),
    );

    await tester.pumpWidget(_mapWithAnnotations(_toSet(m1: m1)));
    await tester.pumpWidget(_mapWithAnnotations(_toSet(m1: m2)));

    final FakePlatformAppleMap platformAppleMap =
        fakePlatformViewsController.lastCreatedView!;
    expect(platformAppleMap.annotationsToChange!.length, 1);

    final Annotation update = platformAppleMap.annotationsToChange!.first;
    expect(update, equals(m2));
    expect(update.infoWindow.snippet, 'changed');
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("Multi Update", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    Annotation m1 = Annotation(annotationId: AnnotationId("annotation_1"));
    Annotation m2 = Annotation(annotationId: AnnotationId("annotation_2"));
    final Set<Annotation> prev = _toSet(m1: m1, m2: m2);
    m1 = Annotation(annotationId: AnnotationId("annotation_1"), alpha: 0.5);
    m2 =
        Annotation(annotationId: AnnotationId("annotation_2"), draggable: true);
    final Set<Annotation> cur = _toSet(m1: m1, m2: m2);

    await tester.pumpWidget(_mapWithAnnotations(prev));
    await tester.pumpWidget(_mapWithAnnotations(cur));

    final FakePlatformAppleMap platformAppleMap =
        fakePlatformViewsController.lastCreatedView!;

    expect(platformAppleMap.annotationsToChange, cur);
    expect(platformAppleMap.annotationIdsToRemove!.isEmpty, true);
    expect(platformAppleMap.annotationsToAdd!.isEmpty, true);
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets("Multi Update", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    Annotation m2 = Annotation(annotationId: AnnotationId("annotation_2"));
    final Annotation m3 =
        Annotation(annotationId: AnnotationId("annotation_3"));
    final Set<Annotation> prev = _toSet(m2: m2, m3: m3);

    // m1 is added, m2 is updated, m3 is removed.
    final Annotation m1 =
        Annotation(annotationId: AnnotationId("annotation_1"));
    m2 =
        Annotation(annotationId: AnnotationId("annotation_2"), draggable: true);
    final Set<Annotation> cur = _toSet(m1: m1, m2: m2);

    await tester.pumpWidget(_mapWithAnnotations(prev));
    await tester.pumpWidget(_mapWithAnnotations(cur));

    final FakePlatformAppleMap platformAppleMap =
        fakePlatformViewsController.lastCreatedView!;

    expect(platformAppleMap.annotationsToChange!.length, 1);
    expect(platformAppleMap.annotationsToAdd!.length, 1);
    expect(platformAppleMap.annotationIdsToRemove!.length, 1);

    expect(platformAppleMap.annotationsToChange!.first, equals(m2));
    expect(platformAppleMap.annotationsToAdd!.first, equals(m1));
    expect(
        platformAppleMap.annotationIdsToRemove!.first, equals(m3.annotationId));
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets(
    "Partial Update",
    (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final Annotation m1 =
          Annotation(annotationId: AnnotationId("annotation_1"));
      Annotation m2 = Annotation(annotationId: AnnotationId("annotation_2"));
      final Set<Annotation> prev = _toSet(m1: m1, m2: m2);
      m2 = Annotation(
          annotationId: AnnotationId("annotation_2"), draggable: true);
      final Set<Annotation> cur = _toSet(m1: m1, m2: m2);

      await tester.pumpWidget(_mapWithAnnotations(prev));
      await tester.pumpWidget(_mapWithAnnotations(cur));

      final FakePlatformAppleMap platformAppleMap =
          fakePlatformViewsController.lastCreatedView!;

      expect(platformAppleMap.annotationsToChange, _toSet(m2: m2));
      expect(platformAppleMap.annotationIdsToRemove!.isEmpty, true);
      expect(platformAppleMap.annotationsToAdd!.isEmpty, true);
      debugDefaultTargetPlatformOverride = null;
    },
    skip: true,
  );

  testWidgets("Unchanged annotations are not re-sent", (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final Set<Annotation> prev = _toSet(
      m1: Annotation(annotationId: AnnotationId("annotation_1")),
    );
    // Same content, new instances: nothing should cross the channel.
    final Set<Annotation> cur = _toSet(
      m1: Annotation(annotationId: AnnotationId("annotation_1")),
    );

    await tester.pumpWidget(_mapWithAnnotations(prev));
    await tester.pumpWidget(_mapWithAnnotations(cur));

    final FakePlatformAppleMap platformAppleMap =
        fakePlatformViewsController.lastCreatedView!;

    expect(platformAppleMap.annotationsToChange!.isEmpty, true);
    expect(platformAppleMap.annotationsToAdd!.isEmpty, true);
    expect(platformAppleMap.annotationIdsToRemove!.isEmpty, true);
    debugDefaultTargetPlatformOverride = null;
  });

  test('Clustering identifier participates in equality and copyWith', () {
    final Annotation base = Annotation(annotationId: AnnotationId('a1'));
    expect(base.clusteringIdentifier, isNull);

    final Annotation clustered = base.copyWith(
      clusteringIdentifierParam: 'cluster-1',
    );
    expect(clustered.clusteringIdentifier, 'cluster-1');
    expect(clustered == base, false);
    expect(
      clustered,
      Annotation(
        annotationId: AnnotationId('a1'),
        clusteringIdentifier: 'cluster-1',
      ),
    );
  });

  test('SnapshotOptions carries mapType through serialization', () {
    const SnapshotOptions options = SnapshotOptions(
      mapType: MapType.hybridFlyover,
    );
    expect(options.mapType, MapType.hybridFlyover);
    expect(
      SnapshotOptions.fromMap(<String, dynamic>{
        'showBuildings': true,
        'showPointsOfInterest': true,
        'showAnnotations': true,
        'showOverlays': true,
        'mapType': MapType.hybridFlyover.index,
      })?.mapType,
      MapType.hybridFlyover,
    );
  });
}
