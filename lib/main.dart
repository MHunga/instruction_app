import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:instruction_app/instruction_click_buton.dart';
import 'package:instruction_app/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AfterLayoutMixin<MyHomePage>{
  Widget instructionWidget = new Container();
  List<GlobalKey> listKey = List();
  List<Model> models = List();
  bool checkInstruction = true;
  @override
  void initState() {
    listKey = [new GlobalKey(),new GlobalKey(),new GlobalKey()];
    getBoolCheckInstruction();
    super.initState();

  } //add key to your widget, which position you need to find
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  key: listKey[0],
                  onPressed:(){
                    print("Do something");
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  color: Colors.blue,
                  child: Container(
                    alignment: Alignment.center,
                    width: 90,
                    height: 50,
                    child: Text("Button 1", style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      key: listKey[1],
                      onPressed: (){
                        print("Do something");
                      },
                      backgroundColor: Colors.green,
                    child: Text("2"),
                    ),
                    SizedBox(height: 20,),
                    FloatingActionButton(
                      key: listKey[2],
                      onPressed: (){
                        print("Do something");
                      },
                      backgroundColor: Colors.red,
                      child: Text("3"),),
                  ],
                ),

              ],
            ),
          ),
       checkInstruction? instructionWidget : Container(),
        ],
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  @override
  void afterFirstLayout(BuildContext context) {
   getPositionAndSizeButton();
  }

  getPositionAndSizeButton(){
    for(int i=0; i<listKey.length;i++){
      RenderBox box = listKey[i].currentContext.findRenderObject();
      Offset position = box.localToGlobal(Offset.zero); //this is global position
      Size size = box.size;
      String title = "Button $i to do something \n to do something \n do something";
      models.add(new Model(title: title, position: position, size: size,));
    }
    setState(() {
      instructionWidget = InstructionClickButton(models: models,);
    });
  }

  getBoolCheckInstruction(){
     Utils.getInstruction().then((value) {
      if(value == null){
        Utils.setInstruction(false);
        setState(() {
          checkInstruction = false;
        });
      }
      else {
        setState(() {
          checkInstruction = value;
        });
      }
    });
  }
}


