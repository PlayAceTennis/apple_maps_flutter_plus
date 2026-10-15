# apple_maps_flutter_plus

Maintained fork of [`apple_maps_flutter`](https://github.com/fluttercommunity/apple_maps_flutter) (upstream `1.4.0`).

Maintained by **Ace Labs UG (haftungsbeschränkt)** — GitHub: [PlayAceTennis](https://github.com/PlayAceTennis).

Why this fork:
- Upstream is unmaintained (~17 months without release, open SPM/Xcode issues)
- Adds **Swift Package Manager (SPM)** support alongside CocoaPods (required since Flutter 3.44; CocoaPods trunk goes read-only Dec 2, 2026)
- Dart 3 / Flutter `>=3.24` compatibility, `toARGB32` / `==` / immutability fixes
- iOS deployment target 15.0, Swift 5.9

## Original description

A Flutter plugin that provides an Apple Maps widget (iOS only, based on `MKMapView` / `google_maps_flutter` architecture).

## iOS setup

Add to `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Show current location on map</string>
```

The old `io.flutter.embedded_views_preview` flag is no longer needed on current Flutter.

## Install

```yaml
dependencies:
  apple_maps_flutter_plus: ^2.0.0
```

```dart
import 'package:apple_maps_flutter_plus/apple_maps_flutter_plus.dart';

AppleMap(
  onMapCreated: (c) => mapController = c,
  initialCameraPosition: const CameraPosition(target: LatLng(0, 0)),
)
```

## Migration from `apple_maps_flutter`

1. `apple_maps_flutter:` → `apple_maps_flutter_plus:` in `pubspec.yaml`
2. `package:apple_maps_flutter/apple_maps_flutter.dart` → `package:apple_maps_flutter_plus/apple_maps_flutter_plus.dart`
3. `flutter pub get`, iOS rebuild picks up SPM automatically.

No API changes in 2.0.0.

## Native layout (CocoaPods + SPM)

- SPM: `ios/apple_maps_flutter_plus/Package.swift` + `Sources/apple_maps_flutter_plus/`
- CocoaPods fallback: `ios/apple_maps_flutter_plus.podspec` (same sources)

## License

BSD-2-Clause. Original copyright Luis Thein (2019), fork copyright Ace Labs UG (haftungsbeschränkt) (2026). See `LICENSE`.
