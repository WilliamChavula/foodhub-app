import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../services/firebase_storage_service.dart';

part 'photos_bloc_event.dart';
part 'photos_bloc_state.dart';

class PhotosBlocBloc extends Bloc<PhotosBlocEvent, PhotosBlocState> {
  PhotosBlocBloc({@required this.storageService})
      : assert(storageService != null),
        super(PhotosBlocInitial());

  final StorageService storageService;

  @override
  Stream<PhotosBlocState> mapEventToState(
    PhotosBlocEvent event,
  ) async* {
    if (event is PhotosLoadingEvent) {
      yield PhotosBlocLoading();
      try {
        final imagesCollection =
            await storageService.getImageURL(event.photosReference);
        yield PhotosBlocLoaded(collection: imagesCollection);
      } on SocketException catch (_) {
        yield PhotosBlocError(
            errorMessage: "No Internet connection. Please try again later.");
      } catch (e) {
        yield PhotosBlocError(errorMessage: e.message);
      }
    }
  }
}
