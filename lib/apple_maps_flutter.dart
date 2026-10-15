// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library;

// NOTE: these imports are consumed by the `part` files below. The
// `unnecessary_import` lint cannot see part usage, hence the ignore.
// ignore: unnecessary_import
import 'dart:async';
// ignore: unnecessary_import
import 'dart:typed_data';
// ignore: unnecessary_import
import 'dart:ui';

// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
// ignore: unnecessary_import
import 'package:flutter/gestures.dart';
// ignore: unnecessary_import
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';

part 'src/annotation.dart';
part 'src/annotation_updates.dart';
part 'src/apple_map.dart';
part 'src/bitmap.dart';
part 'src/cap.dart';
part 'src/callbacks.dart';
part 'src/camera.dart';
part 'src/circle.dart';
part 'src/circle_updates.dart';
part 'src/controller.dart';
part 'src/joint_type.dart';
part 'src/location.dart';
part 'src/pattern_item.dart';
part 'src/polyline.dart';
part 'src/polyline_updates.dart';
part 'src/polygon.dart';
part 'src/polygon_updates.dart';
part 'src/ui.dart';
part 'src/snapshot_options.dart';
