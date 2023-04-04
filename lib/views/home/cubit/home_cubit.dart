import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:uno_assistant/database/uno_repository.dart';
import 'package:uno_assistant/models/game.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : 
    _unoRepository = UnoRepository(),
    super(HomeState());

   final UnoRepository _unoRepository;

  Future<void> getCurrentGame() async{
    emit(state.copyWith(status: HomeStatus.loading));

    try{
      var game = await _unoRepository.getCurrentGame();

      emit(state.copyWith(status: HomeStatus.success, game: game));
    }on Exception {
      emit(state.copyWith(status: HomeStatus.failure));
    }
    
  }
}
