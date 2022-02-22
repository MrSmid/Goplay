import 'dart:math';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goplay/game.dart';
import 'assets/colors/colors.dart' as colors;

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
      backgroundColor: const Color(colors.BG),
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
                      color: Color(colors.white60),
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
                        color: Color(colors.gray),
                      ),
                    ),
                    child: ListTile(
                      onTap: (){
                        setState(() {
                          players.add(Player("new name", PlayerGender.male));
                          textEditControllers.add(new TextEditingController(text: players[players.length - 1].name));
                        });
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(68)),
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
                      trailing: SvgPicture.asset('lib/assets/images/icons/add.svg'),
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
                          color: Color(colors.gray),
                          borderRadius: BorderRadius.circular(68),
                        ),
                        child: ListTile(
                          leading: GestureDetector(
                            child: players[index].gender == PlayerGender.male ? SvgPicture.asset('lib/assets/images/icons/male.svg') : SvgPicture.asset('lib/assets/images/icons/female.svg'),
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
                                players.removeAt(index);
                                textEditControllers.removeAt(index);
                              });
                            },
                            child: SvgPicture.asset('lib/assets/images/icons/clear.svg'),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 27),
                  child:ElevatedButton.icon(
                    onPressed: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Game()));
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
                    icon: SvgPicture.asset('lib/assets/images/icons/emoji_happy.svg'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 55, vertical: 18),
                      primary: Color(colors.violet),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(44),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 48),
                  child: Ink(
                    child: InkWell(
                      onTap: (){
                        _refreshPlayers();
                      },
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000.0)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              AppLocalizations.of(context)!.randomOrder,
                              style: TextStyle(
                                color: Color(colors.white50),
                                fontSize: 14,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 13, top: 5, right: 10, bottom: 5),
                            child: SvgPicture.asset('lib/assets/images/icons/refresh.svg',),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 15, top: 81),
            child: GestureDetector(
              child: SvgPicture.asset('lib/assets/images/icons/arrow_left.svg'),
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
      for (int i = players.length - 1; i >= 1; i--)
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



