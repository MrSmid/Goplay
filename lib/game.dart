import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'assets/colors/colors.dart' as colors;

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {

  String _text1 = "🤓\nТеперь ты - секретарь игрока “Вика”! в течении раунда записывай на листочке все, что она скажет";
  String _text2 = "😀\nТеперь ты - официант игрока “Игорь”! в течении раунда записывай на листочке все, что она скажет";
  int _iterator = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;
  late Widget _mainCard;
  late Widget _movingAnimatedCard;
  late String _mainCardText = _generateGameText();
  late String _movingAnimatedCardText = "";

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this,
        reverseDuration: Duration(milliseconds: 0)
    );
    _animationController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.7;
    Tween<double> tween = Tween<double>(begin: 0, end: cardHeight,);
    _animation = tween.animate(_animationController);
    _animation.addListener(() {
      setState(() {});
    });
    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _animationController.reverse();
        _mainCardText = _movingAnimatedCardText;
      }
    });

    _mainCard = Container(
      transform: Matrix4.translationValues(0.0, 25.0, 0.0),
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: 1.0 - _animationController.value,
        child: GestureDetector(
          onVerticalDragEnd: (dragEndDetails) {
            if (dragEndDetails.primaryVelocity! < 0) {
              _animationController.forward();
              setState(() {
                _movingAnimatedCardText = _generateGameText();
              });
            }
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 19),
            height: cardHeight,
            decoration: BoxDecoration(
              color: Color(colors.gray60),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Color(colors.violet),
                width: 0.7,
              ),
            ),
            child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 26, top: 26),
              child: Text(
                _mainCardText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    _movingAnimatedCard = Positioned(
      bottom: -cardHeight + _animation.value - 25,
      left: 19,
      right: 19,
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(
          color: Color(colors.gray60),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Color(colors.violet),
            width: 0.7,
          ),
        ),
        child: Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 26, top: 26),
          child: Text(
            _movingAnimatedCardText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        ),
      ),
    );

    return  Scaffold(
        backgroundColor: const Color(colors.BG),
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
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 85, left: 19),
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: SvgPicture.asset('assets/images/icons/arrow_left.svg'),
                    onTap: () => Navigator.pop(context),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Text(
                      "Правда или действие",
                      style: TextStyle(
                        color: Color(colors.white60),
                        fontSize: 26,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 102, right: 18),
              child: SvgPicture.asset(
                'assets/images/game_selection/glasses.svg',
                width: MediaQuery.of(context).size.width * 0.55,
              ),
            ),
            _mainCard,
            _movingAnimatedCard,
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Ink(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(colors.violet), width: 1.0),
                        color: Color(colors.BG),
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(1000.0),
                        onTap: (){
                          _animationController.forward();
                          setState(() {
                            _movingAnimatedCardText = _generateGameText();
                          });
                        },
                        child: Padding(
                            padding:EdgeInsets.all(20.0),
                            child: SvgPicture.asset('lib/assets/images/icons/refresh.svg')
                        ),
                      ),
                    ),
                  ),
                  Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(colors.violet), width: 1.0),
                      color: Color(colors.BG),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(1000.0)
                    ),
                    child: InkWell(
                      onTap: (){

                      },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000.0)
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 31, right: 33),
                            child: Text(
                              "Готово",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(colors.gray),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(1000.0)
                            ),
                            padding:EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            child: SvgPicture.asset('lib/assets/images/icons/arrow_right.svg',),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }

  String _generateGameText(){
    _iterator++;
    if (_iterator % 2 == 0) return _text1;
    else return _text2;

  }

}