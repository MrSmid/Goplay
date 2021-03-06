import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goplay/who_plays.dart';
import 'assets/colors/colors.dart' as colors;

class GameMode extends StatefulWidget {
  const GameMode({Key? key}) : super(key: key);

  @override
  _GameModeState createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {

  int selectedMode = -1;
  List<String> titles = [];
  List<String> subtitles = [];

  @override
  Widget build(BuildContext context) {
    titles = [
      AppLocalizations.of(context)!.gameMode0,
      AppLocalizations.of(context)!.gameMode1,
      AppLocalizations.of(context)!.gameMode2,
      AppLocalizations.of(context)!.gameMode3,
    ];
    subtitles = [
      AppLocalizations.of(context)!.gameModeDescription0,
      AppLocalizations.of(context)!.gameModeDescription1,
      AppLocalizations.of(context)!.gameModeDescription2,
      AppLocalizations.of(context)!.gameModeDescription3
    ];
    return Scaffold(
      backgroundColor: const Color(colors.BG),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(colors.violet30),
                    blurRadius: 500.0,
                    spreadRadius: 150,
                  ),
                ],
              ),
              width: 0,
              height: 0,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  alignment: Alignment.topCenter,
                  child: Text(
                    AppLocalizations.of(context)!.selectGameMode,
                    style: TextStyle(
                      color: Color(colors.white60),
                      fontSize: 22,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: _getRadioListObjects(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 75),
            child: ElevatedButton(
              onPressed: ()  {
                if (selectedMode >= 0)
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WhoPlays()));
              },
              child: Text(
                AppLocalizations.of(context)!.continueButton,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 69, vertical: 21.5),
                primary: Color(colors.violet),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(44),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 81, right: 20),
            child: GestureDetector(
              child: SvgPicture.asset('lib/assets/images/icons/clear.svg',),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _getRadioListObjects(){
    List<Widget> radioListObgects = [];
    for(int i = 0; i < 4; i++){
      radioListObgects.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selectedMode == i ? const Color(colors.violet) : Color(colors.gray),
            ),
          ),
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 16),
          child: ListTile(
            minVerticalPadding: 0,
            title: Container(
              margin: const EdgeInsets.only(bottom: 6,),
              child: Text(
                titles[i],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Text(
              subtitles[i],
              style: const TextStyle(
                color: Color(colors.white50),
                fontSize: 14,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              setState(() {
                selectedMode = i;
              });
            },
            leading: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: selectedMode == i ?
                  SvgPicture.asset('lib/assets/images/game_mode/radio_selected.svg',) :
                  SvgPicture.asset('lib/assets/images/game_mode/radio_unselected.svg',)
                ),
                Radio(
                  value: i,
                  groupValue: selectedMode,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedMode = newValue!;
                    });
                  },
                  fillColor: MaterialStateColor.resolveWith((states) => Color(0x00000000)),
                ),
              ],
            ),
            tileColor: const Color(colors.gray),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.only(top: 16, bottom: 16),
          ),
        ),
      );
    }
    return radioListObgects;
  }
}