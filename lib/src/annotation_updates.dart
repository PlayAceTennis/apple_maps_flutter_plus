// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of '../apple_maps_flutter.dart';

/// [Annotation] update events to be applied to the [AppleMap].
///
/// Used in [AppleMapController] when the map is updated.
class _AnnotationUpdates {
  /// Computes [_AnnotationUpdates] given previous and current [Annotation]s.
  _AnnotationUpdates.from(Set<Annotation>? previous, Set<Annotation>? current) {
    previous ??= Set<Annotation>.identity();

    current ??= Set<Annotation>.identity();

    final Map<AnnotationId, Annotation> previousAnnotations =
        _keyByAnnotationId(previous);
    final Map<AnnotationId, Annotation> currentAnnotations =
        _keyByAnnotationId(current);

    final Set<AnnotationId> prevAnnotationIds =
        previousAnnotations.keys.toSet();
    final Set<AnnotationId> currentAnnotationIds =
        currentAnnotations.keys.toSet();

    Annotation idToCurrentAnnotation(AnnotationId id) {
      return currentAnnotations[id]!;
    }

    annotationIdsToRemove = prevAnnotationIds.difference(currentAnnotationIds);

    annotationsToAdd = currentAnnotationIds
        .difference(prevAnnotationIds)
        .map(idToCurrentAnnotation)
        .toSet();

    // Only include annotations whose content actually changed. Otherwise every
    // annotation present in both sets would be re-serialized across the
    // platform channel on every diff.
    annotationsToChange = currentAnnotationIds
        .intersection(prevAnnotationIds)
        .map(idToCurrentAnnotation)
        .where((Annotation current) =>
            current != previousAnnotations[current.annotationId])
        .toSet();
  }

  late Set<Annotation> annotationsToAdd;
  late Set<AnnotationId> annotationIdsToRemove;
  late Set<Annotation> annotationsToChange;

  Map<String, dynamic> _toMap() {
    final Map<String, dynamic> updateMap = <String, dynamic>{};

    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        updateMap[fieldName] = value;
      }
    }

    addIfNonNull('annotationsToAdd', _serializeAnnotationSet(annotationsToAdd));
    addIfNonNull(
        'annotationsToChange', _serializeAnnotationSet(annotationsToChange));
    addIfNonNull(
        'annotationIdsToRemove',
        annotationIdsToRemove
            .map<dynamic>((AnnotationId m) => m.value)
            .toList());

    return updateMap;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! _AnnotationUpdates) return false;
    final _AnnotationUpdates typedOther = other;
    return setEquals(annotationsToAdd, typedOther.annotationsToAdd) &&
        setEquals(annotationIdsToRemove, typedOther.annotationIdsToRemove) &&
        setEquals(annotationsToChange, typedOther.annotationsToChange);
  }

  @override
  int get hashCode =>
      Object.hash(annotationsToAdd, annotationIdsToRemove, annotationsToChange);

  @override
  String toString() {
    return '_AnnotationUpdates{annotationsToAdd: $annotationsToAdd, '
        'annotationIdsToRemove: $annotationIdsToRemove, '
        'annotationsToChange: $annotationsToChange}';
  }
}
