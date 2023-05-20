


import 'package:flutter/material.dart';

import 'jewel_data.dart';



class PageDetail extends StatelessWidget {

  JewelSnapshot jewelSnapshot;

  PageDetail({
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
        title: Text(jewelSnapshot.jewel.name, style: const TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        //thuộc tính elevation(độ cao) tạo hiệu ứng bóng(shadow effect) cho nút.
        elevation: 8.0,
        // nút quay lại trang chính
        leading: const BackButton( color:  Colors.black,),
        actions: [
          //Stackwidget cho phép chúng ta xếp chồng nhiều layer lên nhau.
          // Widget có nhiều children và sắp xếp chúng từ dưới lên trên.
          // Vì vậy, mục đầu tiên là dưới cùng và cuối cùng là trên cùng.
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  // di chuyển qua trang giỏ hàng
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => ()));
                },
                icon: const Icon(
                  Icons.shopping_cart_rounded,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              // vi trí của icon số lượng trong giỏ hàng
              Positioned(
                top: 4,
                left: 3,
                child: Container(
                    height: 22,
                    width: 22,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                    ),
                    child:const Center(
                      child:Text(
                        "0",
                        style: TextStyle( fontSize: 12,fontWeight: FontWeight.bold),
                      ),
                    ),
                )
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Image.network(
            jewelSnapshot.jewel.image,
              //tự động căn chỉnh ảnh khi kích thước diện thoại thay đổi
            height: MediaQuery.of(context).size.height * 0.4,//40%
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
                   // nút add mặt hàng vào giỏ hàng
                    Center(
                      child: SizedBox(
                        width: 200,
                        height:  48,
                        child: ElevatedButton(
                            onPressed:(){ } ,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange ,
                                shape: const StadiumBorder(),
                            ),
                            child: const Text("ADD TO CART")),
                        ),
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
