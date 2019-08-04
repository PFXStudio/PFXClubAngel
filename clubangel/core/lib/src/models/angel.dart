import 'package:kt_dart/collection.dart';

import 'comment.dart';
import 'content_descriptor.dart';
import 'board.dart';
import 'gallery_image.dart';

class Angel {
  Angel({
    this.id,
    this.eventId,
    this.title,
    this.originalTitle,
    this.ageRating,
    this.ageRatingUrl,
    this.url,
    this.presentationMethod,
    this.theaterAndAuditorium,
    this.start,
    this.end,
    this.images,
    this.contentDescriptors,
    this.youtubeTrailers,
    this.galleryImages,
    this.comments,
    this.shortSynopsis,
    this.synopsis,
  });

  final String id;
  final String eventId;
  final String title;
  final String originalTitle;
  final String ageRating;
  final String ageRatingUrl;
  final String url;
  final String presentationMethod;
  final String theaterAndAuditorium;
  final DateTime start;
  final DateTime end;
  final BoardImageData images;
  final KtList<ContentDescriptor> contentDescriptors;
  final KtList<String> youtubeTrailers;
  final KtList<GalleryImage> galleryImages;
  final KtList<Comment> comments;
  final String shortSynopsis;
  final String synopsis;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Angel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          eventId == other.eventId &&
          title == other.title &&
          originalTitle == other.originalTitle &&
          ageRating == other.ageRating &&
          ageRatingUrl == other.ageRatingUrl &&
          url == other.url &&
          presentationMethod == other.presentationMethod &&
          theaterAndAuditorium == other.theaterAndAuditorium &&
          start == other.start &&
          end == other.end &&
          images == other.images &&
          contentDescriptors == other.contentDescriptors;

  @override
  int get hashCode =>
      id.hashCode ^
      eventId.hashCode ^
      title.hashCode ^
      originalTitle.hashCode ^
      ageRating.hashCode ^
      ageRatingUrl.hashCode ^
      url.hashCode ^
      presentationMethod.hashCode ^
      theaterAndAuditorium.hashCode ^
      start.hashCode ^
      end.hashCode ^
      images.hashCode ^
      contentDescriptors.hashCode;
}
