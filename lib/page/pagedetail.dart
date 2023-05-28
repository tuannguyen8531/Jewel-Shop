import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewel_project/data/cart_data.dart';
import 'package:jewel_project/data/jewel_data.dart';
import 'package:jewel_project/page/component.dart';
import 'package:jewel_project/page/pagecart.dart';



class PageDetail extends StatelessWidget {


  final JewelSnapshot jewelSnapshot;

  const PageDetail({
    super.key,
    required this.jewelSnapshot,
  });
  @override
  Widget build(BuildContext context) {
    var type = "";
    switch(jewelSnapshot.jewel.idType) {
      case "ER" : type = "Emerald"; break;
      case "DA" : type = "Diamond"; break;
      case "RB" : type = "Ruby"; break;
      case "SP" : type = "Sapphire"; break;
      default : type = "Gemstone"; break;
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              jewelSnapshot.jewel.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        //thuộc tính elevation(độ cao) tạo hiệu ứng bóng(shadow effect) cho nút.
        elevation: 8.0,
        // nút quay lại trang chính
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.left_chevron,
            color: Colors.black,
          ),
        ),
        actions: [
          //Stackwidget cho phép chúng ta xếp chồng nhiều layer lên nhau.
          // Widget có nhiều children và sắp xếp chúng từ dưới lên trên.
          // Vì vậy, mục đầu tiên là dưới cùng và cuối cùng là trên cùng.

          // Bọc Stack trong StreamBuilder để hiển thị
          // số lượng mặt hàng trong giỏ hàng
          StreamBuilder<List<ProductItemSnapshot>>(
            stream: ProductItemSnapshot.getAllProductItem(),
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return const Center(
                  child: Text("Error!"),
                );
              }
              else {
                if(!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else {
                  var list = snapshot.data!;
                  return Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PageCart(icon: BackIcon()),),);
                        },
                        icon: const Icon(
                          Icons.shopping_cart_rounded,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      // vi trí của icon số lượng trong giỏ hàng
                      Positioned(
                          top: 4,
                          left: 25,
                          child: Container(
                            height: 22,
                            width: 22,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange,
                            ),
                            child: Center(
                              child: Text(
                                list.length.toString(),
                                style: const TextStyle( fontSize: 12,fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Image.network(
            jewelSnapshot.jewel.image,
              //tự động căn chỉnh ảnh khi kích thước diện thoại thay đổi
            height: ScreenSize.getScreenHeight(context) * 0.35,//35%
            fit:  BoxFit.cover,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB( 30 ,30, 30, 20),
              decoration: const BoxDecoration(
                  color:  Colors.white,
                  borderRadius:  BorderRadius.only(
                    topLeft:  Radius.circular(10 *3),
                    topRight:  Radius.circular(10 *3),
                  ),
              ),
              child: Column(
                children: [
                    Row(
                      children: [
                        // hiển thị tên sản phẩm
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffe6e6e6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left:10, bottom: 10, right: 10, top:10), //apply padding to some sides only
                            child: Text(type, style: Theme.of(context).textTheme.titleLarge),
                          ),
                        ),
                        const SizedBox( width: 20,),
                        // hiển thị giá sản phẩm
                        Row(
                          children: [
                            const Icon(Icons.sell),
                            const SizedBox( width: 10,),
                            Text(
                              "\$${jewelSnapshot.jewel.price.toString()}",
                              style: const TextStyle(fontWeight: FontWeight.bold ,color: Colors.orange ,fontSize: 21),
                            ),
                          ],
                        )
                      ],
                    ),
                    // phần giới thiệu sản phẩm
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          jewelSnapshot.jewel.description,
                          style: const TextStyle( color: Color(0xff8c8c8c) , fontSize: 17),
                        ),
                    ),
                    const SizedBox( height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:  Colors.orange,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5), //apply padding to some sides only
                                child: Text("Weight", style: TextStyle( color: Colors.black , fontSize: 19)),
                              ),
                            ),
                            const SizedBox( height: 10,),
                            Text(
                              "${jewelSnapshot.jewel.weight} Carat",
                              style: const TextStyle( color: Colors.black , fontSize: 19),
                            ),
                          ],
                        ),
                        const SizedBox( width: 25,),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orange,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5),//apply padding to some sides only
                                child: Text(
                                  "Origin",
                                  style: TextStyle( color: Colors.black , fontSize: 19),
                                ),
                              ),
                            ),
                            const SizedBox( height: 10,),
                            Text(
                              jewelSnapshot.jewel.origin,
                              style: const TextStyle( color: Colors.black , fontSize: 19),
                            ),
                          ],
                        ),
                        const SizedBox( width: 25,),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orange,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left:5, bottom: 5, right: 5, top:5), //apply padding to some sides only
                                child: Text(
                                  "Size",
                                  style: TextStyle( color: Colors.black , fontSize: 19),
                                ),
                              ),
                            ),
                            const SizedBox( height: 10,),
                            Text(
                              "${jewelSnapshot.jewel.size} mili",
                              style: const TextStyle( color: Colors.black , fontSize: 19),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox( height: 25,),

                    // Bọc nút ADD TO CART trong StreamBuilder để kiểm tra
                    // xem mặt hàng này đã có trong giỏ hàng hay chưa
                    StreamBuilder<List<ProductItemSnapshot>>(
                      stream: ProductItemSnapshot.getAllProductItem(),
                      builder: (context, cart) {
                        if(cart.hasError) {
                          return const Center(
                            child: Text("Error"),
                          );
                        }
                        else {
                          if(!cart.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          else {
                            bool isAdded = false;
                            var list = cart.data!;
                            // Chạy vòng lặp kiểm tra danh sách trong cart
                            for(var item in list) {
                              if(item.productItem.id == jewelSnapshot.jewel.id) {
                                isAdded = true;
                                break;
                              }
                            }
                            // Nếu đã có mặt hàng này
                            if(isAdded) {
                              return Center(
                                child: SizedBox(
                                  width: 200,
                                  height:  48,
                                  child: ElevatedButton(
                                    onPressed:(){
                                      showSnackBar(context, "This product has already been added!", 2);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey ,
                                      shape: const StadiumBorder(),
                                    ),
                                    child: const Text("ADDED"),
                                  ),
                                ),
                              );
                            }
                            // Nếu chưa có mặt hàng này
                            else {
                              return Center(
                                child: SizedBox(
                                  width: 200,
                                  height:  48,
                                  child: ElevatedButton(
                                    onPressed:(){
                                      // Tạo ra một mặt hàng mới với thông tin từ
                                      // JewelSnapshot được truyền vào PageDetail
                                      ProductItem product = ProductItem(
                                        id: jewelSnapshot.jewel.id,
                                        name: jewelSnapshot.jewel.name,
                                        size: jewelSnapshot.jewel.size,
                                        image: jewelSnapshot.jewel.image,
                                        price: jewelSnapshot.jewel.price,
                                        amount: 1,
                                      );
                                      ProductItemSnapshot.add(product);
                                      showSnackBar(context, "Added the product successfully!", 2);
                                    } ,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange ,
                                      shape: const StadiumBorder(),
                                    ),
                                    child: const Text("ADD TO CART"),
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}
