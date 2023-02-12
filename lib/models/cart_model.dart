import 'package:food_delivery_app/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? quantity;
  bool? isExist;
  String? time;

  int? price;

  String? img;
  Productmodel? product;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.quantity,
      this.isExist,
      this.time,
      this.product
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    price = json['price'];

    img = json['img'];

    quantity = json['quantity'];

    isExist = json['isExist'];

    time = json['time'];
    product = Productmodel.fromJson(json['product']);
  }


  Map <String, dynamic> toJson(){
    return{
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "quantity":this.quantity,
      "isExist":this.isExist,
      "time" : this.time,
      "product": this.product!.toJson()

    };
  }
}
