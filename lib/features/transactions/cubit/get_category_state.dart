
abstract class GetCategoryState {}

class GetCategoryIdle extends GetCategoryState {}

class GetCategoryLoading extends GetCategoryState {}

class GetCategoryError extends GetCategoryState {
  final String message;

  GetCategoryError({required this.message});
}
