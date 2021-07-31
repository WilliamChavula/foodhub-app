part of 'photos_bloc_bloc.dart';

@immutable
abstract class PhotosBlocState {}

class PhotosBlocInitial extends PhotosBlocState {}

class PhotosBlocLoading extends PhotosBlocState {}

class PhotosBlocLoaded extends PhotosBlocState {
  final List<Map<String, List<dynamic>>> _imagesCollection;

  PhotosBlocLoaded({@required List<Map<String, List<dynamic>>> collection})
      : assert(collection != null),
        _imagesCollection = collection;

  List<Map<String, List<dynamic>>> get imagesCollection => _imagesCollection;
}

class PhotosBlocError extends PhotosBlocState {
  final String errorMessage;

  PhotosBlocError({@required this.errorMessage}) : assert(errorMessage != null);
}
