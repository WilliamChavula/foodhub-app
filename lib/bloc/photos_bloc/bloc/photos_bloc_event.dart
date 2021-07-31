part of 'photos_bloc_bloc.dart';

@immutable
abstract class PhotosBlocEvent {}

class PhotosLoadingEvent extends PhotosBlocEvent {
  final String photosReference;

  PhotosLoadingEvent({@required this.photosReference})
      : assert(photosReference != null);
}

class PhotosLoadedEvent extends PhotosBlocEvent {}
