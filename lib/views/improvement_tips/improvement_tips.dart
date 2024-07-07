import 'package:fitness_care/consts/imports.dart';
import 'package:fitness_care/consts/strings.dart';
import 'package:fitness_care/views/improvement_tips/widgets/text_and_picture.dart';

class ImprovementTips extends StatelessWidget {
  const ImprovementTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child:
                  "Improvement Tips".text.fontFamily(bebasNeue).size(30).make(),
            ),
          ),
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          elevation: 10,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_outlined),
          ).paddingOnly(top: 10)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Regular Exercise
            textAndPicture(
                topic: RegularExercise,
                heading1: CardioWorkoutss,
                heading1Detail: CardioWorkoutssDetals,
                tipOrExample1: CardioWorkoutssExammple,
                heading2: StrengthTraining,
                heading2Detail: StrengthTrainingDetails,
                tipOrExample2: StrengthTrainingExample,
                postImage1: const AssetImage(gymRunning),
                topicImage: const AssetImage(exerciseImage),
                // postImage: const AssetImage(strengthTraining)
            ),

            //Healthy Diet
            textAndPicture(
                topic: HealthyDiet,
                heading1: WaterIntake,
                heading1Detail: WaterIntakeDetails,
                tipOrExample1: WaterIntakeTip,
                tipBool1: true,
                heading2: LimitAlcohol,
                heading2Detail: LimitAlcoholDetail,
                tipOrExample2: LimitAlcoholAlternative,
                tipBool2: true,
                topicImage: const AssetImage(healthyDietImage),
                preImage2: const AssetImage(limitAlcohol)
                
            
            ),

            // Stress Management
            textAndPicture(
                topic: StressManagement,
                heading1: RelaxationTechniques,
                heading1Detail: RelaxationTechniquesDetuls,
                tipOrExample1: RelaxationTechniquesExample,
                heading2: AdequateSleep,
                heading2Detail: AdequateSleepDetails,
                tipOrExample2: AdequateSleepTips,
                tipBool2: true , 
                topicImage: const AssetImage(stressManagement)
            
             ),

            // Healthy Weight
            textAndPicture(
                topic: MaintainHealthyWeight,
                heading1: WeightManagement,
                heading1Detail: WeightManagementDetail,
                tipOrExample1: WeightManagementTip,
                tipBool1: true,
                heading2: TrackProgress,
                heading2Detail: TrackProgressDetail,
                tipOrExample2: TrackProgressExmple,
                topicImage: const AssetImage(weightManagement)
            ),

          ],
        ),
      ),
    );
  }
}
