import 'dart:math';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum PlayerGender{
  male,
  female
}

class Player {
  String name;
  PlayerGender gender = PlayerGender.male;

  Player(this.name, this.gender,);

}

class WhoPlays extends StatefulWidget {
  const WhoPlays({Key? key}) : super(key: key);

  @override
  _WhoPlaysState createState() => _WhoPlaysState();
}

class _WhoPlaysState extends State<WhoPlays> {
  List<Player> players = [
    Player("Aндрей", PlayerGender.male,),
    Player("Вика", PlayerGender.female,),
    Player("Джонсон", PlayerGender.male,),
    Player("Конфета", PlayerGender.female,),

  ];
  List<TextEditingController> textEditControllers = [];


  @override
  void initState() {
    for (int i = 0; i < (players.length); i++) {
      textEditControllers.add(new TextEditingController(text: players[i].name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF1C1F2A),
      body: Stack(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  alignment: Alignment.topCenter,
                  child: Text(
                    AppLocalizations.of(context)!.whoPlays,
                    style: TextStyle(
                      color: Color(0x99FFFFFF),
                      fontSize: 22,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 + MediaQuery.of(context).size.width * 0.08,
                  child: Container(
                    margin: EdgeInsets.only(left: 15, top: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(68),
                      border: Border.all(
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          AppLocalizations.of(context)!.addPlayer,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            players.add(Player("new name", PlayerGender.male));
                            textEditControllers.add(new TextEditingController(text: players[players.length - 1].name));
                          });
                        },
                        child: SvgPicture.asset('assets/images/icons/add.svg'),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  margin: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: players.length,
                    shrinkWrap: true,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: 15, right: 15, bottom: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFF2D3142),
                          borderRadius: BorderRadius.circular(68),
                        ),
                        child: ListTile(
                          leading: GestureDetector(
                            child: players[index].gender == PlayerGender.male ? SvgPicture.asset('assets/images/icons/male.svg') : SvgPicture.asset('assets/images/icons/female.svg'),
                            onTap: (){
                              setState(() {
                                if (players[index].gender == PlayerGender.male)
                                  players[index].gender = PlayerGender.female;
                                else
                                  players[index].gender = PlayerGender.male;
                              });
                            },
                          ),
                          title: TextFormField(
                            //initialValue: players[index].name,
                            controller: textEditControllers[index],
                            onChanged: (String name) {players[index].name = name;},
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration.collapsed(hintText: ''),
                            cursorColor: Colors.white,
                          ),
                          trailing: GestureDetector(
                            onTap: (){
                              setState(() {
                                for(int i = 0; i < players.length; i++) {
                                  print(i);
                                  print(players[i].name);
                                }
                                players.removeAt(index);
                                textEditControllers.removeAt(index);
                                print("//");
                                print("removed $index");
                                for(int i = 0; i < players.length; i++) {
                                  print(i);
                                  print(players[i].name);
                                }
                              });
                            },
                            child: SvgPicture.asset('assets/images/icons/clear.svg'),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 29),
                  child:ElevatedButton.icon(
                    onPressed: ()  {
                      print("продолжить");
                    },
                    label: Text(
                      AppLocalizations.of(context)!.startGame,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    icon: SvgPicture.asset('assets/images/icons/emoji_happy.svg'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 55, vertical: 18),
                      primary: Color(0xFF7169E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(44),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 57),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 13),
                        child: Text(
                          AppLocalizations.of(context)!.randomOrder,
                          style: TextStyle(
                            color: Color(0x80FFFFFF),
                            fontSize: 14,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          _refreshPlayers();
                        },
                        child: SvgPicture.asset('assets/images/icons/refresh.svg'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 15, top: 81),
            child: GestureDetector(
              child: SvgPicture.asset('assets/images/icons/arrow_left.svg'),
              onTap: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }

  void _refreshPlayers(){
    Random random = Random();
    setState(() {
      for (int i = 0; i < players.length; i++)
      {
        int j = random.nextInt(i + 1);
        var tmp_player = players[j];
        players[j] = players[i];
        players[i] = tmp_player;
        var tmp_controller = textEditControllers[j];
        textEditControllers[j] = textEditControllers[i];
        textEditControllers[i] = tmp_controller;
      }
    });
  }


}



