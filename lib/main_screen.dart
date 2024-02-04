import 'package:flutter/material.dart';

bool isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;
bool isOperator(String s) {
  return s == "x" || s == "–" || s == "÷" || s == "-" || s == "+" || s == "=";
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  GlobalKey _globalKey = GlobalKey();

  Color darkDefaultBtnColor = Color.fromARGB(255, 95, 95, 95);
  Color defaultBtnColor = Color.fromARGB(255, 118, 118, 118);
  Color changedBtnColor = Color.fromARGB(255, 253, 163, 52);

  double sol = double.infinity;
  int op = -1;

  String prevBtn = "";

  bool opPressed = false;

  // void onAnyButtonPressed(btnText) {
  //   setState(() {
  //     if ((calcBarText == "0" && isDigit(btnText, 0)) ||
  //         (opPressed && !isOperator(prevBtn))) {
  //       calcBarText = "";
  //     }

  //     if (calcBarText != "0" && !isOperator(btnText)) {
  //       opPressed = false;
  //       if (btnText == "AC") {
  //         calcBarText = "0";
  //         sol = double.infinity;
  //         op = -1;
  //         opPressed = false;
  //         prevBtn = "";
  //       } else if (isDigit(btnText, 0)) {
  //         calcBarText += btnText;
  //       } else if (btnText == "⌫") {
  //         if (calcBarText.length == 1) {
  //           calcBarText = "0";
  //         } else {
  //           calcBarText = calcBarText.substring(0, calcBarText.length - 1);
  //         }
  //       } else if (btnText == "+/-" && calcBarText != "0") {
  //         calcBarText = calcBarText.startsWith("-")
  //             ? calcBarText.substring(1)
  //             : "-" + calcBarText;
  //       } else if (btnText == "." && !calcBarText.contains(".")) {
  //         calcBarText += ".";
  //       } else if (btnText == "%") {
  //         double num = double.parse(calcBarText);
  //         calcBarText = (num * 0.01).toString();
  //       }
  //     } else if (btnText == "." && !calcBarText.contains(".")) {
  //       calcBarText += ".";
  //     } else if (!isOperator(prevBtn)) {
  //       if (sol != double.infinity) {
  //         if (op == 1) {
  //           sol += double.parse(calcBarText);
  //         } else if (op == 2) {
  //           sol -= double.parse(calcBarText);
  //         } else if (op == 3) {
  //           sol *= double.parse(calcBarText);
  //         } else if (op == 4) {
  //           sol /= double.parse(calcBarText);
  //         }
  //         calcBarText = (sol != double.infinity) ? sol.toString() : calcBarText;

  //         if (btnText == "=") {
  //           sol = double.infinity;
  //           op = -1;
  //           opPressed = false;
  //         }
  //       } else {
  //         sol = double.parse(calcBarText);
  //       }

  //       if (btnText != "=") {
  //         opPressed = true;
  //       }

  //       if (btnText == "+") {
  //         op = 1;
  //       } else if (btnText == "–") {
  //         op = 2;
  //       } else if (btnText == "x") {
  //         op = 3;
  //       } else if (btnText == "÷") {
  //         op = 4;
  //       }
  //     }

  //     prevBtn = btnText;
  //   });
  // }

  Widget placeButton(String buttonText, Color buttonColor, Color fgColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(1.5),
        child: ElevatedButton(
          onPressed: () => calculation(buttonText),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              buttonText,
              style: TextStyle(
                color: fgColor,
                fontSize: 30,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                color: Color.fromARGB(255, 68, 68, 68),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget placeButtonRow(String a, String b, String c, String d, Color ac,
      Color bc, Color cc, Color dc) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          placeButton(a, ac, Colors.white),
          placeButton(b, bc, Colors.white),
          placeButton(c, cc, Colors.white),
          placeButton(d, dc, Colors.white),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 81, 81, 81),
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: screenHeight / 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 80),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          placeButtonRow("AC", "+/-", "%", "÷", darkDefaultBtnColor,
              darkDefaultBtnColor, darkDefaultBtnColor, changedBtnColor),
          placeButtonRow("7", "8", "9", "x", defaultBtnColor, defaultBtnColor,
              defaultBtnColor, changedBtnColor),
          placeButtonRow("4", "5", "6", "–", defaultBtnColor, defaultBtnColor,
              defaultBtnColor, changedBtnColor),
          placeButtonRow("1", "2", "3", "+", defaultBtnColor, defaultBtnColor,
              defaultBtnColor, changedBtnColor),
          placeButtonRow("0", ".", "⌫", "=", defaultBtnColor, defaultBtnColor,
              defaultBtnColor, changedBtnColor),
        ],
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
