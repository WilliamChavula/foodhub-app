part of 'foodhub_bloc.dart';

// enum CategoryEvents {
//   getCategories,
// }

@immutable
abstract class FoodhubEvent {}

class LoadCategoriesEvent extends FoodhubEvent {}
