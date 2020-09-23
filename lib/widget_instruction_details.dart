import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstructionDetails extends StatelessWidget {
  String title;
  String button;
  Function callback;
   InstructionDetails({Key key, this.callback,this.title,this.button}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,),
          SizedBox(height: 20,),
          FlatButton(
            shape: CircleBorder(),
            onPressed: (){
              callback();
            },
            child: AvatarGlow(
              glowColor: Colors.green,
              endRadius: 40.0,
              duration: Duration(milliseconds: 1000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              child: Text(button, style: TextStyle(color: Colors.green.shade300, fontSize: 18, fontWeight: FontWeight.bold),)
            ),
          ),
        ],
      ),
    );
  }
}
