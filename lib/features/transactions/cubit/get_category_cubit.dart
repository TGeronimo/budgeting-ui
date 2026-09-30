
import 'package:flutter_app_test/features/transactions/cubit/get_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCategoryCubit extends Cubit<GetCategoryState> {


  GetCategoryCubit() :  super(GetCategoryIdle()); // define o estado inicial chamando o construtor de Cubit



  @override
  Future<void> close() {

    return super.close();
  }

}