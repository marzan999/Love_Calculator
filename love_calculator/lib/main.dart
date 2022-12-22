import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  final TextEditingController _hisname = TextEditingController();
  final TextEditingController _hername = TextEditingController();

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 6)
    );
    _animationController.addListener(() {
      setState(() {

      });
    });
    _animationController.repeat();
    super.initState();
  }

  void reset()
  {
    setState(() {
      _hisname.text = "";
      _hername.text = "";
    });
  }
  @override
  Widget build(BuildContext context) {

    final percentage = _animationController.value*100;

    void press()
    {
      final text1 = _hisname.text;
      final text2 = _hername.text;

      if(text1 != "" && text2 != "")
      {
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: LiquidCustomProgressIndicator(
                        direction: Axis.vertical,
                        shapePath: _buildHeartPath(),
                        center: Text('${percentage.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),),
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                        value: _animationController.value,
                        backgroundColor: Colors.pinkAccent,
                      ),
                    ),
                    SizedBox(height: 25,),
                    Container(
                      child: Text("$text1 ❤ $text2"),
                    )
                  ],
                ),
              );
            });
      }
      else{
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Enter The Details"),
              );
            });
      }
      reset();
    }

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Image.network('https://i.pinimg.com/originals/1f/eb/81/1feb816930ae264c2b2a55e099cc1352.jpg',
              height: double.infinity,
              fit: BoxFit.cover,
              ),
              Column(
                children: [
                  SizedBox(height: 100,),

                  Text('Calculate your Love', style: GoogleFonts.rubikGlitch(fontSize: 45),),
                  
                    SizedBox(height: 60,),
                  Container(
                    margin: EdgeInsets.only(left: 25,right: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 2)
                    ),
                    child: TextField(
                      controller: _hisname,
                      decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.male),
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                      hintText: "HIS NAME",
                      contentPadding: EdgeInsets.only(left: 20,top: 12),
                      border: InputBorder.none
                    ),),
                  ),
                  SizedBox(height: 25,),
                  Container(
                    margin: EdgeInsets.only(left: 25,right: 25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 2)
                    ),
                    child: TextField(
                      controller: _hername,
                      decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.female),
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                            fontSize: 18
                        ),
                        hintText: "HER NAME",
                        contentPadding: EdgeInsets.only(left: 20,top: 12),
                        border: InputBorder.none
                    ),),
                  ),
                 
                 
                  SizedBox(height: 500,),
                  InkWell(
                    onTap: () => press(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 127, 155, 179),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 2,color: Colors.yellow)
                      ),
                      child: Text("Calculate",
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 18
                      ),),
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
  Path _buildHeartPath() {
    return Path()
      ..moveTo(55, 15)
      ..cubicTo(55, 12, 50, 0, 30, 0)
      ..cubicTo(0, 0, 0, 37.5, 0, 37.5)
      ..cubicTo(0, 55, 20, 77, 55, 95)
      ..cubicTo(90, 77, 110, 55, 110, 37.5)
      ..cubicTo(110, 37.5, 110, 0, 80, 0)
      ..cubicTo(65, 0, 55, 12, 55, 15)
      ..close();
  }
}