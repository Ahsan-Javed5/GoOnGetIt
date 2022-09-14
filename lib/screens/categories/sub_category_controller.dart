import 'package:get/get.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/network/remote_repository.dart';

class SubCategoryController extends GetxController {
  RxList subCategoryList = [].obs;

  var isLoading = false.obs;

  Future<void> fetchSubCategories({String? categoryId}) async {
    Future.delayed(100.milliseconds, (){
      isLoading.value = true;
    });
    var location = MyHive.getLocation();
    Map<String, dynamic> queryParams = {
      'lat': location.latitude,
      'lng': location.longitude,
      'category_id': categoryId
    };
    Future.delayed(500.milliseconds, () async {
      try {
        subCategoryList.value =
            await RemoteRepository.fetchSubCategoryList(queryParams) ?? [];
        print({'$subCategoryList'});
      } finally {
        isLoading.value = false;
        print('Reached');
      }
    });
  }
}
