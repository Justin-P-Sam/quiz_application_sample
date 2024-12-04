// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_application_1/u/color_const.dart';
import 'package:quiz_application_1/view/chemistry_screen/chemistry_result.dart';
import 'package:quiz_application_1/view/dummydb.dart';
import 'package:quiz_application_1/view/quiz_screen/results_screen.dart';


class ChemistryScreen extends StatefulWidget {
  const ChemistryScreen({super.key});

  @override
  State<ChemistryScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<ChemistryScreen> {
  int currentQuestionIndex = 0;
  int? selectedAnsIndex;
  int rightAnsCount = 0;
  int remainingTime = 30; // Countdown duration in seconds
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  // Function to start the countdown
  void startCountdown() {
    remainingTime = 10; // Reset the countdown to 30 seconds at the start of each question
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        // Timer finished
        _timer.cancel();
        // Move to the next question automatically after timer ends
        nextQuestion();
      }
    });
  }

  // Function to move to the next question
  void nextQuestion() {
    if (currentQuestionIndex < DummyDb.Chemistry.length - 1) {
      currentQuestionIndex++;
      selectedAnsIndex = null;
      startCountdown(); // Restart countdown for next question
    } else {
      // navigate to results screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            rightAnsCount: rightAnsCount,
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: ColorConstants.offWhite,
        actions: [Text('${currentQuestionIndex + 1}/${DummyDb.Chemistry.length}')],
        title: Text("chemistry questions"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                
                decoration: BoxDecoration(
                    color: ColorConstants.darkBlue,
                    borderRadius: BorderRadius.circular(15),
                    ) ,
                height: 100,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                      CircularProgressIndicator(
                  value: remainingTime / 10, // Normalize progress based on 30 seconds
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.lightGreen),
                ),
                Positioned(
                  left: 9,
                  top: 4,
                  child: Text(
                    "$remainingTime", // Display countdown time in the center
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.lightGreen,
                    ),
                  ),
                ),
    
      
                    if(selectedAnsIndex == 
                    DummyDb.Chemistry[currentQuestionIndex]["answerIndex"])
                    Align(
                      alignment: Alignment.center,
                      child: Lottie.asset("assets/animations/popper_animation.json")),
                    Align(
                      alignment: Alignment.center,
                      child: Text(DummyDb.Chemistry[currentQuestionIndex]["question"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ColorConstants.lightGreen,
                          )),
                    ),
                  ],
                ),
                    
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(
                4,
                (optionIndex) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: () {
                      if (selectedAnsIndex == null) {
                        selectedAnsIndex = optionIndex;
                        if (selectedAnsIndex ==
                            DummyDb.Chemistry[currentQuestionIndex]
                                ["answerIndex"]) {
                          rightAnsCount++;
                          log("right ans count = $rightAnsCount");
                        }
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: getColor(optionIndex)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                                DummyDb.Chemistry[currentQuestionIndex]
                                    ["options"][optionIndex],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: ColorConstants.lightGreen,
                                )),
                          ),
                          Icon(
                            Icons.circle_outlined,
                            color: ColorConstants.lightGreen,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (selectedAnsIndex != null)
              InkWell(
                onTap: () {
                  if (currentQuestionIndex < DummyDb.Chemistry.length - 1) {
                    currentQuestionIndex++;
                    selectedAnsIndex = null;
                    setState(() {});
                  } else {
                    // navigate to results screen
                    print("results screen");

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChemistryResult(
                            rightAnsCount: rightAnsCount,
                          ),
                        ));
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.warmBrown,
                  ),
                  alignment: Alignment.center,
                  child: Text("Next",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ColorConstants.darkBlue,
                      )),
                ),
              ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

// to set color for option seciton based on selected answer
  Color getColor(int optionIndex) {
    // to check whether an answer is selected or not
    if (selectedAnsIndex != null) {
      //to check whether the option is right or not
      if (DummyDb.Chemistry[currentQuestionIndex]["answerIndex"] ==
          optionIndex) {
        return Colors.green;
      }
    }

//to check whether to the selected ansewer is equal to builder index
    if (selectedAnsIndex == optionIndex) {
      //to check whether the  selected answer is right or not
      if (selectedAnsIndex ==
          DummyDb.Chemistry[currentQuestionIndex]["answerIndex"]) {
        // if answer is right (green color)
        return Colors.green;
      } else {
        // if answer is wrong (red color)
        return ColorConstants.red;
      }
    } else {
      // default return  blue colors
      return ColorConstants.darkBlue;
    }
  }
}