import 'dart:io';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home:App()));

class App extends StatefulWidget {
  createState() {
    return MyApp();
  }
}

class MyApp extends State<App> {
  int counter=1;
  List values=[[' ',' ',' '],[' ',' ',' '],[' ',' ',' ']];
  int win=0;

  setZero() {
    counter=1;
    values=[[' ',' ',' '],[' ',' ',' '],[' ',' ',' ']];
    win=0;
  }

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
          title: Text('Tic Tac Toe'),
          backgroundColor: Color.fromRGBO(1, 88, 107, 5),
        ),
        body: Container(
          decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(1, 88, 107, 100),width:35.0)),
          child:
          Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top:115.0,left: 15.0,right: 15.0,bottom: 10.0),
                    child: Padding(
                      padding: EdgeInsets.only(top : 10.0),
                      child: player(),
                    )
                ),
                Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Table(
                        border: TableBorder(
                          verticalInside: BorderSide(color: Colors.grey, width: 5.0),
                          horizontalInside: BorderSide(color: Colors.grey, width: 5.0),
                        ),
                        children: [TableRow(children: [
                          button(0,0),button(0,1),button(0,2)
                        ]),
                          TableRow(children: [
                            button(1,0),button(1,1),button(1,2)
                          ]),
                          TableRow(children: [
                            button(2,0),button(2,1),button(2,2)
                          ]),
                        ],
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(top:20.0),
                  child: FlatButton(
                      onPressed: () {setState(() {
                        setZero();
                      });},
                      child: Text('Restart',textScaleFactor: 1.25,)
                  ),
                )

              ]
          ),
        )
      ),
    );
  }

  void popup(BuildContext context) {
    showDialog(context: context,builder: (context)
    {
      return AlertDialog(
        title: Printwinner(),
        actions: <Widget>[
          MaterialButton(
            child: Text('New Game'),
            onPressed: () {
              setState(() {
                setZero();
                Navigator.of(context).pop();
              });
            },
          ),
          MaterialButton(
            child: Text('Exit'),
            onPressed: () {
              exit(0);
            },
          )
        ],
      );
    });
  }

  void calculate() {
    for(int i=0;i<3;i++) {
      if (((values[i][0]==values[i][1]) && (values[i][1]==values[i][2]) && (values[i][2]=='X'))
          || ((values[0][i]==values[1][i]) && (values[1][i]==values[2][i]) && (values[2][i]=='X'))) {
        win=1; break;
      }
      else if (((values[i][0]==values[i][1]) && (values[i][1]==values[i][2]) && (values[i][2]=='O'))
          || ((values[0][i]==values[1][i]) && (values[1][i]==values[2][i]) && (values[2][i]=='O'))) {
        win=2; break;
      }
    }
    if ((values[0][0]==values[1][1] && values[1][1]==values[2][2] && values[2][2]=='X') || (values[0][2]==values[1][1] && values[1][1]==values[2][0] && values[2][0]=='X')) {
      win=1;
    }
    else if ((values[0][0]==values[1][1] && values[1][1]==values[2][2] && (values[2][2]=='O')) || (values[0][2]==values[1][1] && values[1][1]==values[2][0] && values[2][0]=='O')) {
      win=2;
    }
    if (win!=0 || counter>9) {
      popup(context);
    }
  }

  Widget player() {
    if(counter%2==0) {
      return Text("(O) 's Turn  ",textScaleFactor: 2.0, textAlign: TextAlign.center,);
    }
    else {
      return Text("(X) 's Turn",textScaleFactor: 2.0, textAlign: TextAlign.center,);
    }
  }

  Widget button(int x, int y) {
    color() {
      if (values[x][y] == 'X') {
        return  Colors.brown;
      } else {
        return  Color.fromRGBO(207,170,146,1);
      }
    }
    return Padding (
      padding: EdgeInsets.all(15.0),
      child: FlatButton(
        onPressed: () {
          setState(() {
            if (values[x][y]==' ') {
              if (counter % 2 == 0) {
                values[x][y] = 'O';
              } else {
                values[x][y] = 'X';
              }
              counter++;
            }
            calculate();
          }
          );
        },
        child: Text(values[x][y],textScaleFactor: 2.5,),
        color: Colors.white,
        disabledColor: Colors.white,
        textColor: color(),
        highlightColor: Colors.black12,
      ),
    );
  }

  Printwinner() {
      if (win!=0)
        if (win==1)
          return Text('(X) Won The Game!!');
        else
          return Text('(O) Won The Game!!');
      else
        return Text('Match Draw!');
  }
}
