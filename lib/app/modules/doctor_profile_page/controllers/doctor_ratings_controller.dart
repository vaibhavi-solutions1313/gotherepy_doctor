import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/model/doctor_ratings.dart';
import 'package:gotherepy_doctor/app/modules/doctor_profile_page/providers/_provider.dart';
import 'package:intl/intl.dart';

class ReviewsController extends GetxController{

  ProfileProvider _profileProvider = Get.put(ProfileProvider());
  var ratingsModel = RatingsModel().obs;

  RxInt rating = 0.obs;
  RxString avatar = "".obs;
  RxString review = "".obs;
  RxString username = "".obs;
  RxString date = "".obs;
  RxList<RatingsResult> reviews = <RatingsResult>[].obs;


  Future<void> fetchReviews(int doctorId) async{
    RatingsModel response = await _profileProvider.fetchReviews(doctorId);
    ratingsModel.value = response;
    /*try{
      RatingsModel response = await _profileProvider.fetchReviews(doctorId);
      ratingsModel.value = response;
      if(response.status == true && response.results != null){
        // final List<dynamic> responseData = response.results!;
        reviews.assignAll(response.results!);

        for(RatingsResult feedback in reviews){
          displayReviewDetails(feedback);
        }
      } else{
        Get.snackbar(
          "Failed",
          "Unable to fetch reviews.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch(error){
      print("Error: $error");
    }*/
  }

  void displayReviewDetails(RatingsResult review){
    String avatar = review.avatar ?? "";
    String username = review.username ?? "";
    int ratings = review.ratings ?? 0;
    String reviewText = review.review ?? "";
    DateTime reviewDate = review.updatedAt ?? DateTime.now();
    date.value = DateFormat.yMMMd().format(reviewDate);

    print("Avatar: $avatar");
    print("Username: $username");
    print("Ratings: $ratings");
    print("Review: $reviewText");
  }
}