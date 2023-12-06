import 'package:flutter/material.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_result.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_stage3.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_widgets.dart';
import 'package:mungshinsa/petsonal_color_test_page/test_info.dart';

import '../loading.dart';
import '../providers/petsnal_color_api.dart';

List<String> clearChoices = [
  'Glossy하고 라인이 깔끔해보인다.',
  '조금 gloss하고 라인 깔끔해보인다.',
  'Oily하고 주름이 두드러진다.'
];
List<String> dullChoices = [
  '톤이 고르고 윤곽이 매끈해보인다',
  '조금 고르고 매끈.',
  '매트하고 탄력이 부족해보인다'
];

class Stage2Question1 extends StatelessWidget {
  const Stage2Question1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 0, choices: clearChoices, nextPage: const Stage2Question2());
  }
}

class Stage2Question2 extends StatelessWidget {
  const Stage2Question2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 1, choices: dullChoices, nextPage: Stage2Question3());
  }
}

class Stage2Question3 extends StatelessWidget {
  const Stage2Question3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 2, choices: clearChoices, nextPage: Stage2Question4());
  }
}

class Stage2Question4 extends StatelessWidget {
  const Stage2Question4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 3, choices: dullChoices, nextPage: Stage2Question5());
  }
}

class Stage2Question5 extends StatelessWidget {
  const Stage2Question5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 4, choices: clearChoices, nextPage: Stage2Question6());
  }
}

class Stage2Question6 extends StatelessWidget {
  const Stage2Question6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
        imageNum: 5,
        choices: dullChoices,
        nextPage: AdditinalQuestionOrNextStageOrResult());
  }
}

class AdditinalQuestionOrNextStageOrResult extends StatelessWidget {
  const AdditinalQuestionOrNextStageOrResult({super.key});

  @override
  Widget build(BuildContext context) {
    if (testInfo.currentStage == 2) {
      if (testInfo.warmClearLow == testInfo.coolDullHigh) {
        return AdditionalQuestion(imageNum: 6, nextPage: Stage3Q1());
      } else {
        print('clear: ${testInfo.warmClearLow} dull: ${testInfo.coolDullHigh}');
        print(testInfo.currentStage);
        print(testInfo.resultList);
        return FutureBuilder<Map<dynamic, dynamic>>(
          future: petsnalColorProvider.PetsnalColorStage(
              testInfo.currentStage, 1, testInfo.resultList),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 비동기 작업이 완료될 때까지 로딩 인디케이터나 다른 로딩 UI를 표시합니다.
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // 에러를 처리합니다.
              print('Error: ${snapshot.error}');
              return SizedBox(); // 기본 위젯을 반환하거나 에러 케이스를 처리합니다.
            } else {
              // 비동기 작업이 완료되었을 때의 로직을 처리합니다.
              testInfo.images = snapshot.data!;
              testInfo.currentStage = snapshot.data!['nextStage'];
              testInfo.clearScore();
              testInfo.clearResultList();

              return Stage3Q1();
            }
          },
        );
      }
    } else {
      if (testInfo.warmClearLow == testInfo.coolDullHigh) {
        // 쿨이고 clear, dull 점수 같은 경우
        return AdditionalQuestion(imageNum: 6, nextPage: PetColResult());
      } else {
        // 쿨이고 clear, dull 점수 다른 경우
        print(testInfo.currentStage);
        return FutureBuilder<Map<dynamic, dynamic>>(
          future: petsnalColorProvider.PetsnalColorStage(
              testInfo.currentStage, 1, testInfo.resultList),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return SizedBox();
            } else {
              testInfo.images = snapshot.data!;
              testInfo.currentStage = snapshot.data!['nextStage'];
              testInfo.clearScore();
              testInfo.clearResultList();

              return Loading(nextPage: PetColResult());
            }
          },
        );
      }
    }
  }
}
