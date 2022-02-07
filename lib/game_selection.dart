import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goplay/game_mode.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameSelection extends StatefulWidget {
  const GameSelection({Key? key}) : super(key: key);

  @override
  _GameSelectionState createState() => _GameSelectionState();
}

class _GameSelectionState extends State<GameSelection> {

  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      backgroundColor: Color(0xFF1C1F2A),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 220),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x507169E2),
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
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 80),
            child: Text(
              AppLocalizations.of(context)!.selectGame,
              style: TextStyle(
                color: Color(0x99FFFFFF),
                fontSize: 22,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          PageView(
            controller: controller,
            onPageChanged: (int page){
              if (page > controller.page!) {
                setState(() {
                  currentPage++;
                });
              }
              else {
                setState(() {
                  currentPage--;
                });
              }
            },
            children: [
              getPage(),
              getPage(),
              getPage(),
              getPage(),
              getPage(),
            ],
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left: 19, bottom: 83),
            child: SmoothPageIndicator(
              controller: controller,
              count: 5,
              effect: const ExpandingDotsEffect(
                spacing:  6.0,
                radius: 100.0,
                dotWidth:  6.0,
                dotHeight:  6.0,
                expansionFactor: 7,
                paintStyle:  PaintingStyle.fill,
                strokeWidth:  1,
                dotColor:  Colors.white,
                activeDotColor:  Color(0xFF7169E2),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 19, bottom: 100),
            child: Text(
              currentPage.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: Color(0xFF7169E2),
                fontSize: 24,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GameMode()));
              },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                SvgPicture.asset('assets/images/game_selection/button_start_game.svg',),
                Container(
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(bottom: 80, right: 31,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.startGame,
                          style: TextStyle(
                            color: Color(0xFF1C1F2A),
                            fontSize: 14,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: const Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Color(0xFF1C1F2A),
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget getPage(){
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 140, left: 15),
            alignment: Alignment.topLeft,
            child: SvgPicture.asset('assets/images/game_selection/glasses.svg',),
          ),
          Container(
            padding: EdgeInsets.only(top: 7, left: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)!.gameName0,
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12, left: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)!.gameDescription0,
              style: TextStyle(
                color: Color(0x80FFFFFF),
                fontSize: 14,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
