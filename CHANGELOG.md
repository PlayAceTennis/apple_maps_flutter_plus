# Changelog

## 2.1.1

* Zero analyzer issues (`flutter analyze`), clean `dart format`, modernized
  test bindings. No API changes.

## 2.1.0

Crash fixes and parity features (thanks to upstream contributors whose PRs
these are adapted from: #24, #42/#63, #71, #82, #84, #86, #88):

* Fixed crash on dispose / method calls after dispose: method channel handler
  uses `weak self` and is cleared in `deinit` (#84, issues #55/#61/#46)
* Fixed `MKPuckAccuracyLayer` crash: no longer runs `CLLocationManager`
  updates alongside `showsUserLocation` (#82, issue #81)
* Fixed per-map camera state: zoom/pitch/heading limits are now stored per
  map view instead of globally, so multiple maps on one screen no longer
  interfere (issue #44)
* Fixed `getVisibleRegion` returning swapped coordinates (#24)
* Fixed radius-only circle updates being dropped; polyline/polygon point
  updates are now detected too (issue #64)
* Fixed `onDragEnd` never firing: native drag-end is now reported and the
  Dart callback invoked (issue #49)
* Unchanged annotations are no longer re-sent across the platform channel on
  every diff (perf, helps issue #57)
* Added native MapKit clustering via `Annotation.clusteringIdentifier`;
  tapping a cluster zooms into its members (#88, issue #73)
* Added `AppleMap.colorScheme` (system/light/dark) (#63, issues #77/#29)
* Added map types `satelliteFlyover`, `hybridFlyover`, `mutedStandard`
  (#71) and snapshot `mapType` (#43)
* Added `AppleMapController.getLatLng` (screen point to coordinate, issue #37)
* Added `CameraUpdate.scrollBy` (issue #26)
* Added `AppleMap.showPointsOfInterest` (issue #36)

## 2.0.0

* Maintained fork by Ace Labs UG (haftungsbeschränkt) / PlayAceTennis, renamed to `apple_maps_flutter_plus`
* Added Swift Package Manager support (`ios/apple_maps_flutter_plus/Package.swift`), kept CocoaPods fallback
* iOS deployment target 15.0, Swift 5.9
* Pure-Swift plugin (removed ObjC shim; mixed ObjC+Swift is unsupported in SPM)
* Added missing `import Flutter` to all Swift files (required outside CocoaPods)
* Replaced deprecated `authorizationStatus()` and snapshot `showsPointsOfInterest` (iOS 17 `preferredConfiguration`, iOS 15 fallback)
* Example app is SPM-only (CocoaPods deintegrated)
* Dart `>=3.0 <4.0`, Flutter `>=3.24`
* Fixed `Color.value` → `toARGB32`, `==` parameter types, `Annotation.zIndex` final
* No API changes; drop-in migration via import rename

## 1.4.0

* Flutter 3.27.1 compatibility, replace `ui.hash*` with `Object.hash*

## 1.3.0

* Animate marker position changes instead of removing and re-adding
* Fix Fatal error: Attempted to read an unowned reference but the object was already deallocated
* Fixed an issue where onCameraMove was not invoked by double-tapping
* Added insetsLayoutMarginsFromSafeArea

## 1.2.0

* Added a `markerAnnotationWithHue()` and `pinAnnotationWithHue()` method to allow custom marker/pin colors

## 1.1.0

* Added Annotation zIndex
* Added posibility to take snapshots of the map

## 1.0.3

* Fixes an issue where mapController.moveCamera would animate the camera transition
* To animate a camera movement, mapController.animateCamera should be used instead

## 1.0.2

* Removed Android folder to fix build failures

## 1.0.1

* Fixes memory leak
* Adds ability to take snapshots of the map
## 1.0.0

Thanks to @jonbhanson
* Adds null safety.
* Refreshes the example app.
* Updates .gitignore and removes files that should not be tracked.

## 0.1.4

* Animate to bounds was added. (Thanks to @nghiashiyi)
* Fixed an issue where the user location was only displayed in `authorizationInUse` status. (Thanks to @zgosalvez)

* minor fixes

## 0.1.3

* Thanks to @maxiundtesa the getter for the current zoomLevel was added
* iOS build failure for Flutter modules was fixed

## 0.1.2+5

* Fixed build failure
* Added anchor param to Annotation
* Added missing comparison of Overlay coordinates, which caused
  Circles, Annotations, Polylines and Ploygons to not update correctly
  on coordinate changes.

## 0.1.2+4

* Added configurable Anchor for infoWindows

## 0.1.2+3

* Fixed the offset of custom markers

## 0.1.2+2

* Fixed the onTap event for Annotation Callouts

## 0.1.2+1

* Added custom annotation icons from byte data
* Fixed scaling of icons from assets => see: https://flutter.dev/docs/development/ui/assets-and-images#declaring-resolution-aware-image-assets

## 0.1.2

* Annotation rework:
   * onTap for InfoWindow added
   * Multiline InfoWindow subtitle support
   * Overall Annotation handling refactored
   * Correct UserTracking Button added

## 0.1.1+2

* Fixed map freezing when setState is being called

## 0.1.1+1

* Fixed Polygon and Circle Tap events.

## 0.1.1

* Added markerAnnotation as selectable annotation type.

## 0.1.0

* Added ability to place circles on the map.

## 0.0.7

* Added ability to place polygons on the map.

## 0.0.6+4

* Fixed build issues

## 0.0.6+3

* Fixes issue #6, location permission is only requested if it's actually used.

## 0.0.6+2

* Converted iOS code to swift 5.

## 0.0.6+1

* Changed annotation initialisation, fixes custom annotation icons not showing up on the map.

## 0.0.6

* Added ability to add padding to the map

## 0.0.5

* Added ability to place polylines.

## 0.0.4

* Fixed error when updating Annotations on map.

## 0.0.3

* Added getter for visible map region.

## 0.0.2

* Added zoomBy functionality.
* Added setter for min and max zoom levels.

## 0.0.1

* Initial release.
