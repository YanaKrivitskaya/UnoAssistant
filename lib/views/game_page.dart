import 'package:flutter/material.dart';
import 'package:uno_assistant/helpers/router.dart';
import 'package:uno_assistant/helpers/styles.dart';
import 'package:d_chart/d_chart.dart';

import '../helpers/colors.dart';

class GamePage extends StatefulWidget{
  const GamePage({super.key});


  @override
  State<StatefulWidget> createState() {
    return _GamePageState();
  }
}

class _GamePageState extends State<GamePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,    
        centerTitle: true,
        //title: Text('New Game', style:encodeStyle(fontSize: smallHeaderFontSize)),
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
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Text("Score to win: 300", style: encodeStyle(fontSize: accentFontSize)),
          ],),
          const Divider(color: ColorsPalette.blueGrey),         
          SizedBox(height: sizerHeight),
          
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Text("Yana", style: encodeStyle(fontSize: accentFontSize)),
            SizedBox(
              height: chartBarHeight,
              width: formWidth70,
              child: DChartSingleBar(
                  forgroundColor: ColorsPalette.gloomyPurple,
                  forgroundLabel: Text("120", style: encodeStyle(color: ColorsPalette.white, weight: FontWeight.bold)),
                  forgroundLabelPadding: EdgeInsets.only(right: 10.0),
                  backgroundLabel: Text("300", style: encodeStyle(color: ColorsPalette.black, weight: FontWeight.bold)),
                  backgroundLabelPadding: EdgeInsets.only(right: 10.0),
                  value: 120,
                  max: 300,
                ),
          )
          ],),
          SizedBox(height: sizerHeight),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Text("SP", style: encodeStyle(fontSize: accentFontSize)),
            SizedBox(
              height: chartBarHeight,
              width: formWidth70,
              child: DChartSingleBar(
                  forgroundColor: ColorsPalette.highBlue,
                  forgroundLabel: Text("150", style: encodeStyle(color: ColorsPalette.white, weight: FontWeight.bold)),
                  forgroundLabelPadding: EdgeInsets.only(right: 10.0),
                  backgroundLabel: Text("300", style: encodeStyle(color: ColorsPalette.black, weight: FontWeight.bold)),
                  backgroundLabelPadding: EdgeInsets.only(right: 10.0),
                  value: 150,
                  max: 300,
                ),
          )
          ],),
          const Divider(color: ColorsPalette.blueGrey),    
          SizedBox(height: sizerHeight),
          Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Text("Round", style: encodeStyle(fontSize: accentFontSize, weight: FontWeight.bold)),
              Text("Winner", style: encodeStyle(fontSize: accentFontSize, weight: FontWeight.bold)),
              Text("Points", style: encodeStyle(fontSize: accentFontSize, weight: FontWeight.bold)),
            ],),
            const Divider(color: ColorsPalette.blueGrey),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Text("1", style: encodeStyle(fontSize: accentFontSize)),
              Text("Yana", style: encodeStyle(fontSize: accentFontSize)),
              Text("50", style: encodeStyle(fontSize: accentFontSize)),
            ],),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Text("2", style: encodeStyle(fontSize: accentFontSize)),
              Text("SP", style: encodeStyle(fontSize: accentFontSize)),
              Text("70", style: encodeStyle(fontSize: accentFontSize)),
            ],),
          ],)
          /*AspectRatio(aspectRatio: 16/9, child: 
          DChartLine(
            data: [
                {
                    'id': 'Line 1',
                    'data': [
                        {'domain': 0, 'measure': 0},
                        {'domain': 1, 'measure': 50},
                        {'domain': 2, 'measure': 50},
                        {'domain': 3, 'measure': 50},
                        {'domain': 4, 'measure': 120},
                    ],
                },
                {
                    'id': 'Line 2',
                    'data': [
                        {'domain': 0, 'measure': 0},
                        {'domain': 1, 'measure': 0},
                        {'domain': 2, 'measure': 90},
                        {'domain': 3, 'measure': 120},
                        {'domain': 4, 'measure': 150},
                    ],
                },
            ],
            lineColor: (lineData, index, id) {
              return id == 'Line 1'
                  ? ColorsPalette.gloomyPurple
                  : ColorsPalette.highBlue;
            },
            includePoints: true,
            includeArea: true,
        ),
          )*/
        ]),
      ),
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: (){          
          Navigator.pushNamed(context, roundPointsRoute).then((value) {});
        },
        tooltip: 'End Round',
        backgroundColor: ColorsPalette.flirtatious,
        label: Text("End Round", style: encodeStyle(color: ColorsPalette.white),),
        //icon: const Icon(Icons.add, color: ColorsPalette.white),
      ),
    );
  }

}