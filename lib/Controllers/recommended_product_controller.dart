




import 'package:food_delivery_app/Data/repository/recommended_product_repo.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController{
  final RecommendedproductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});


 bool _isLoaded = false;
 bool get isLoaded => _isLoaded;

  List <dynamic> _recommendedProductList =[];
  List <dynamic> get recommendedProductList => _recommendedProductList;
  Future <void> getRecommendedProductList ()async{
  
     Response response = await recommendedProductRepo.getRecommendedProductList();

     try{
      if(response.statusCode == 200){
       print("Got product");
        _recommendedProductList =[];
       
        _recommendedProductList.addAll(Product.fromJson(response.body).products);
        //print(_popularProductList);
        _isLoaded = !_isLoaded;

        update();
     }else{
         print("Recommended product not entered");
     }

     }catch(e){
      print(e.toString());

     }
     
  }
}