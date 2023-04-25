

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_assistant/helpers/widgets.dart';
import 'package:uno_assistant/views/home/cubit/home_cubit.dart';

import '../../helpers/colors.dart';
import '../../helpers/router.dart';

class HomeView extends StatefulWidget{
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state){
          if(state.status == HomeStatus.initial || state.status == HomeStatus.loading){
            return loadingWidget(ColorsPalette.maxBlueGreen);
          }else{
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [          
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset('assets/UNO_Logo.png', height: 150,)
                ]),
                const SizedBox(height: 50.0,),
                if(state.currentGame != null) 
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    _continueGameButton(context, state.currentGame!.id!),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    _newGameButton(context),
                ]),
              ]);
          }          
        }
      )
    );
  }

  Widget _newGameButton(BuildContext context) => TextButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(120.0)),      
      backgroundColor: MaterialStateProperty.all<Color>(ColorsPalette.maxBlueGreen),
      foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.white)
    ),
    onPressed: () {
      Navigator.pushNamed(context, newGameRoute).then((value) {
        context.read<HomeCubit>().getCurrentGame();
      });
    },
    child: const Text("New Game")
  );

  Widget _continueGameButton(BuildContext context, int gameId) => TextButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(120.0)),      
      backgroundColor: MaterialStateProperty.all<Color>(ColorsPalette.flirtatious),
      foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.white)
    ),
    onPressed: () {
      Navigator.pushNamed(context, currentGameRoute, arguments: gameId).then((value) {
        context.read<HomeCubit>().getCurrentGame();
      });
    },
    child: const Text("Continue")
  );
}