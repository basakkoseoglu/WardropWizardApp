import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ww_app/data/data.dart'; 

class ProductDisplayWidget extends StatefulWidget {
  final bool isKadin;

  const ProductDisplayWidget({super.key, required this.isKadin});

  @override
  _ProductDisplayWidgetState createState() => _ProductDisplayWidgetState();
}

class _ProductDisplayWidgetState extends State<ProductDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    // Kadın ya da Erkek ürünlerini filtreleme
    final filteredProducts =
        products.where((product) => product.isKadin == widget.isKadin).toList();

    return MasonryGridView.count(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      crossAxisSpacing: 15,
      crossAxisCount: 2,
      itemCount: filteredProducts.length,
      mainAxisSpacing: 10,
      itemBuilder: (context, index) {
        return singleItemWidget(filteredProducts[index], context);
      },
    );
  }

  // Tek bir ürün widget'ı
  Widget singleItemWidget(Product product, BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(
                      product.productImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 10.0,
                    ),
                    child: Row(
                      children: [
                        // Resim kısmı
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            product.productPUrl,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        // Ürün adı ve kalp simgesi yan yana
                        Expanded(
                          child: Row(
                            children: [
                              // Ürün adı
                              Expanded(
                                child: Text(
                                  product.productName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              // Kalp simgesi ve beğeni sayısı
                              GestureDetector(
                                onTap: () {
                                  // Kalp simgesine tıklanınca yapılacak işlem
                                  setState(() {
                                    product.isLiked = !product.isLiked;
                                    product.isLiked
                                        ? product.likesCount++
                                        : product.likesCount--;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      product.isLiked
                                          ? FontAwesomeIcons.solidHeart
                                          : FontAwesomeIcons.heart,
                                      color: product.isLiked
                                          ? Colors.red
                                          : Colors.grey,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      product.likesCount.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 5,
              top: 10,
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 0.5,
        ),
      ],
    );
  }
}
