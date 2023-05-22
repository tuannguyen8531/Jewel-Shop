import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jewel_project/firebase/cart_data.dart';
import 'package:jewel_project/firebase/sidemenu.dart';

class PageCart extends StatelessWidget {
  const PageCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: SvgPicture.asset("assets/icons/menu.svg"),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Jewel Store",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/notification.svg"),
            ),
          ],
        ),
        body: StreamBuilder<List<ProductItemSnapshot>>(
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
                var listProducts = snapshot.data!;
                return Column(
                  children: [
                    Expanded(child:  ListView.separated(
                      itemBuilder: (context, index) => Padding(
                        padding:  const EdgeInsets.all(0.0),
                        child: Container(
                          height: 130,
                          margin: const EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 224, 224, 224),
                                  borderRadius:  BorderRadius.circular(100),
                                ),
                                child: Image.network(listProducts[index].productItem.image),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      listProducts[index].productItem.name,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight:  FontWeight.bold,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                    Text(
                                      "${listProducts[index].productItem.size} Carat",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight:  FontWeight.bold,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                    Text(
                                      listProducts[index].productItem.price.toString(),
                                      style: const TextStyle(
                                        fontSize: 16 ,
                                        fontWeight:  FontWeight.bold,
                                        color: Color(0xFFFD725A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding:const EdgeInsets.symmetric( vertical: 5),
                                child: Column(
                                  crossAxisAlignment:  CrossAxisAlignment.end,
                                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      color:  Colors.redAccent,
                                      iconSize: 20,
                                      icon: const Icon( Icons.delete),
                                      onPressed: () {
                                        listProducts[index].delete();
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding:  const EdgeInsets.all(1.0),
                                          decoration:  BoxDecoration(
                                            color:  const Color(0xFFF7F8FA),
                                            borderRadius:  BorderRadius.circular(20),
                                          ),
                                          child:
                                          IconButton(
                                            color:  Colors.redAccent,
                                            iconSize: 17,
                                            icon: const Icon( Icons.remove),
                                            onPressed: () async {
                                              var amount = listProducts[index].productItem.amount-1;
                                              if(amount==0) {
                                                listProducts[index].delete();
                                              }
                                              else {
                                                ProductItem product = ProductItem(
                                                  id: listProducts[index].productItem.id,
                                                  name: listProducts[index].productItem.name,
                                                  size: listProducts[index].productItem.size,
                                                  image: listProducts[index].productItem.image,
                                                  price: listProducts[index].productItem.price,
                                                  amount: amount,
                                                );
                                                await listProducts[index].update(product);
                                              }
                                            },
                                          ),
                                        ),
                                        Text(
                                          listProducts[index].productItem.amount.toString(),
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight:  FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox( width: 0,),
                                        //---------nút thêm  số lượng sản phẩm
                                        Container(
                                          padding:  const EdgeInsets.all(1),
                                          decoration:  BoxDecoration(
                                            color:  const Color(0xFFF7F8FA),
                                            borderRadius:  BorderRadius.circular(20),
                                          ),
                                          child:
                                          IconButton(
                                            color:  Colors.redAccent,
                                            iconSize: 17,
                                            icon: const Icon( Icons.add),
                                            onPressed: () async {
                                              var amount = listProducts[index].productItem.amount+1;
                                              ProductItem product = ProductItem(
                                                id: listProducts[index].productItem.id,
                                                name: listProducts[index].productItem.name,
                                                size: listProducts[index].productItem.size,
                                                image: listProducts[index].productItem.image,
                                                price: listProducts[index].productItem.price,
                                                amount: amount,
                                              );
                                              await listProducts[index].update(product);
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider( thickness: 0,),
                      itemCount: listProducts.length,
                    ),
                    ),
                    Container(
                      padding: const EdgeInsets.only( top:1),
                      child:  Row(
                        children: [
                          Padding(
                            padding:  const EdgeInsets.symmetric( horizontal: 10),
                            child:  Row(
                              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total: ",
                                  style:  TextStyle(
                                    fontSize: 20,
                                    fontWeight:  FontWeight.w600,
                                  ),),
                                Text(
                                  getTotal(listProducts).toString(),
                                  style:  const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20,
                                    fontWeight:  FontWeight.w600,
                                  ),),
                              ],
                            ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: SizedBox(
                          width: 200,
                          height:  48,
                          child: ElevatedButton(
                              onPressed:(){ } ,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange ,
                                  shape: const StadiumBorder(),
                              ),
                              child: const Text("Pay"),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
    );
  }
}

int getTotal(List<ProductItemSnapshot> list) {
  int total = 0;
  for(var item in list) {
    total = total + item.productItem.amount * item.productItem.price;
  }
  return total;
}

