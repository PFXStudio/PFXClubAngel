class GalleryImage {
  GalleryImage({
    this.location,
    this.thumbnailLocation,
  });

  final String location;
  final String thumbnailLocation;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryImage &&
          runtimeType == other.runtimeType &&
          location == other.location &&
          thumbnailLocation == other.thumbnailLocation;

  @override
  int get hashCode => location.hashCode ^ thumbnailLocation.hashCode;
}
