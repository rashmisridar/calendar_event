import 'package:atem_interview/home_screen/product/prod_utils/product_pojo.dart';
import 'package:atem_interview/home_screen/product/product_provider.dart';
import 'package:atem_interview/utils/coonst_color.dart';
import 'package:atem_interview/utils/coonst_string.dart';
import 'package:atem_interview/utils/custom_style/custom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:atem_interview/utils/custom_style/progress_indicator.dart';
import 'package:extended_image/extended_image.dart';
import '../../utils/coonst_dimen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

double deviceHeight = 0.0;
double deviceWidth = 0.0;

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductProvider>(context);
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CoonstColor.blue,
          title: Text(
            CoonstString.productList,
            style: CustomTextStyle()
                .fontSizeNormal(CoonstColor.white, FontWeight.w500, 20),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: productList.getAllData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data != null &&
                (snapshot.data as List<dynamic>).length > 0) {
              return productBodyWidget(snapshot.data);
            } else if (!snapshot.hasData ||
                (snapshot.data as List<dynamic>).isEmpty) {
              return Indicator().progressIndicator();
            } else {
              return Container(child: Text("Error"));
            }
          },
        ));
  }

  Widget productBodyWidget(List<Product> productList) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          childAspectRatio: 0.65, //0.5card height
          crossAxisSpacing: 3.0,
        ),
        itemBuilder: (context, index) {
          return Card(
            //color: CoonstColor.grey,
            elevation: CoonstDimen.cardElev,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              margin: const EdgeInsets.all(10),
              // height: deviceHeight / 1, //3.65
              child: Column(
                children: [
                  AspectRatio(
                      aspectRatio: 2 / 1.6, // 4/1.6
                      child: ExtendedImage.network(
                        "${productList[index].image}",
                        width: double.infinity,
                        fit: BoxFit.contain,
                        enableLoadState: true,
                        timeRetry: Duration(milliseconds: 100),
                        retries: 3,
                        cache: false,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      '${productList[index].title}',
                      style: CustomTextStyle().fontSizeNormal(
                          CoonstColor.black, FontWeight.w400, 14.0),
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${CoonstString.indianRupees} ${productList[index].price}',
                        style: CustomTextStyle().fontSizeNormal(
                            CoonstColor.black, FontWeight.w600, 20.0),
                        maxLines: 4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    child: Text(
                      '${productList[index].category}',
                      style: CustomTextStyle().fontSizeNormal(
                          CoonstColor.black, FontWeight.w400, 14.0),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: deviceWidth / 2,
                    child: RatingBarIndicator(
                      rating:
                          double.parse("${productList[index].rating!.rate}"),
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount:
                          int.parse("${productList[index].rating!.count}"),
                      itemSize: deviceWidth / 50,
                      direction: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
