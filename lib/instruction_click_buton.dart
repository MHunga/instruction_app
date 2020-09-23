import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:instruction_app/main.dart';
import 'package:instruction_app/utils.dart';
import 'package:instruction_app/widget_instruction_details.dart';

class InstructionClickButton extends StatefulWidget {
  List<Model> models;
  InstructionClickButton({Key key, this.models}) : super(key: key);
  @override
  _InstructionClickButtonState createState() => _InstructionClickButtonState();
}

class _InstructionClickButtonState extends State<InstructionClickButton> with TickerProviderStateMixin{
Widget _widget = Container();
List<Widget> listDetailsWidget;
double _width = 200;
double _height = 100;
double widthChild,heightChild;
double dx,dy;
int i =0;
bool _isDone = true;
@override
  void initState() {
    super.initState();
    dx = widget.models[0].position.dx;
    dy = widget.models[0].position.dy;
    widthChild = widget.models[0].size.width;
    heightChild = widget.models[0].size.height;
    Timer(Duration(seconds: 1), () {
      setState(() {
        _isDone = false;
        _widget = InstructionDetails(key: ValueKey(0),callback: callbackChange,title: widget.models[i].title,button: "Tiếp",);
      });
    });

  }

  callbackChange(){
    i++;
  if(i<widget.models.length){
    setState(() {
      if(i == widget.models.length-1){
        _widget = InstructionDetails(key: ValueKey(i), callback: callbackChange,title: widget.models[i].title,button: "Xong",);
      }else{
        _widget = InstructionDetails(key: ValueKey(i), callback: callbackChange,title: widget.models[i].title,button: "Tiếp",);
      }
      dx = widget.models[i].position.dx;
      dy = widget.models[i].position.dy;
      widthChild = widget.models[i].size.width;
      heightChild = widget.models[i].size.height;
    });
  }else{
    setState(() {
      _isDone = true;
      _widget = Container();
      Utils.setInstruction(true);
    });
  }

  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 700),
          height: _isDone?0:MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.3),
        ),
        Positioned(
            top: 100,
            left: 10,
            right: 10,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 800),
               reverseDuration: Duration(milliseconds: 200),
               transitionBuilder: (Widget child,Animation<double> animation){
              return ScaleTransition(scale: animation, child: child,);
            },
              child: _widget,
            )),
       _isDone?Container(): AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          top: dy-(_height-heightChild)/2,left: dx-(_width-widthChild)/2,
            child: Container(
              height: _height,
              width: _width,
              child: FlareActor("assets/flr/ins_click.flr", animation: "click", fit: BoxFit.fitHeight,),

          ),
        ),
      ],
    );
  }
}

class Model {
  Offset position;
  Size size;
  String title;
  Model({this.position,this.title,this.size});
}
