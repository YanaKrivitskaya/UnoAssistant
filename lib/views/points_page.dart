import 'package:flutter/material.dart';
import 'package:uno_assistant/helpers/styles.dart';

import '../helpers/colors.dart';
import '../helpers/router.dart';

class PointsPage extends StatefulWidget{
  const PointsPage({super.key});


  @override
  State<StatefulWidget> createState() {
    return _PointsPageState();
  }
}


class _PointsPageState extends State<PointsPage>{
  TextEditingController? _roundPointsController;  

  @override
  void initState() {
    super.initState();
    _roundPointsController = TextEditingController(text: "0");    
  }

  @override
  void dispose() {
    _roundPointsController!.dispose();   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,    
        centerTitle: true,
        title: Text('Round points', style:encodeStyle(fontSize: smallHeaderFontSize)),
        backgroundColor: ColorsPalette.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsPalette.black),
          onPressed: (){
            Navigator.pop(context);
          },
        ),        
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Row(children: [
            Text("Enter points:", style: encodeStyle(fontSize: accentFontSize)),
            SizedBox(width: sizerWidthsm),
            SizedBox(width: formWidth40,
              child: TextFormField(     
                keyboardType: TextInputType.number,  
                textAlign: TextAlign.center,         
                style:  encodeStyle(fontSize: accentFontSize),
                decoration: InputDecoration(
                  border: InputBorder.none,                  
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
                controller: _roundPointsController
              ),
            ),
          ],),
          SizedBox(height: sizerHeight),
          const Divider(color: ColorsPalette.blueGrey),         
          SizedBox(height: sizerHeight),
          Text("...or select cards:", style: encodeStyle(fontSize: accentFontSize)),
          SizedBox(height: sizerHeight),
          Container(
            width: viewWidth80,
            child: Column(children: [
              Wrap(children: [
                Image.asset('assets/card_0.png', height: cardHeight),
                Image.asset('assets/card_1.png', height: cardHeight),
                Image.asset('assets/card_2.png', height: cardHeight),
                Image.asset('assets/card_3.png', height: cardHeight),
                Image.asset('assets/card_4.png', height: cardHeight),
                Image.asset('assets/card_5.png', height: cardHeight),
                Image.asset('assets/card_6.png', height: cardHeight),
                Image.asset('assets/card_7.png', height: cardHeight),
                Image.asset('assets/card_8.png', height: cardHeight),
                Image.asset('assets/card_9.png', height: cardHeight),
                Image.asset('assets/card_custom.png', height: cardHeight),
                Image.asset('assets/card_reverse.png', height: cardHeight),
                Image.asset('assets/card_skip.png', height: cardHeight),
                Image.asset('assets/card_take_four.png', height: cardHeight),
                Image.asset('assets/card_take_two.png', height: cardHeight),
                Image.asset('assets/card_wild.png', height: cardHeight),
              ], alignment: WrapAlignment.center,)
            ],),
          ),
          SizedBox(height: sizerHeightlg),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _submitPointsButton(context),
          ]),
        ],)
      ),
    );
  }

  Widget _submitPointsButton(BuildContext context) => TextButton(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(120.0)),      
      backgroundColor: MaterialStateProperty.all<Color>(ColorsPalette.desire),
      foregroundColor: MaterialStateProperty.all<Color>(ColorsPalette.white)
    ),
    onPressed: () {
      Navigator.pushNamed(context, currentGameRoute).then((value) {} /*context.read<TripsBloc>().add(GetAllTrips())*/);
    },
    child: const Text("Submit")
  );
}