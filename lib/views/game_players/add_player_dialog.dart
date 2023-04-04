

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno_assistant/helpers/colors.dart';
import 'package:uno_assistant/models/player.dart';
import 'package:uno_assistant/views/game_players/cubit/game_players_cubit.dart';

class AddPlayerDialog extends StatefulWidget{  

  AddPlayerDialog();

  @override
  _AddPlayerDialogState createState() => new _AddPlayerDialogState();
}

class _AddPlayerDialogState extends State<AddPlayerDialog>{
  TextEditingController? _usernameController;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController(text: '');
    //_usernameController!.addListener(_onUsernameChanged);
  }

  @override
  void dispose(){
    _usernameController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamePlayersCubit, GamePlayersState>(
      builder: (context, state){
        return AlertDialog(
          title: const Text('New Player'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if(_usernameController!.text != ''){

                  Player newPlayer = Player(name: _usernameController!.text);

                  context.read<GamePlayersCubit>().addPlayer(newPlayer);
                }
                Navigator.pop(context);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.only(left: 25.0, right: 25.0)),            
                foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.maxBlueGreen)
              ),
              child: const Text('Done'),  
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.only(left: 25.0, right: 25.0)),            
                foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.maxBlueGreen)
              ),
              child: const Text('Cancel'),                  
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _usernameTextField(_usernameController, state),
                ],
            ),
          ),
        );
      }
    );
  }

  Widget _usernameTextField(TextEditingController? usernameController, GamePlayersState state) => TextFormField(
    decoration: const InputDecoration(
        labelText: 'Name',
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
            color: ColorsPalette.maxBlueGreen, width: 1),
        ),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(
            color: ColorsPalette.maxBlueGreen, width: 1),
        )
    ),
    keyboardType: TextInputType.text,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (_) {
      //return !state.isUsernameValid ? 'Invalid Name' : null;
    },
    autofocus: false,
    controller: usernameController,
  );
}