import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:odm/constants/color_store.dart';

class DetailHeader extends StatefulWidget {
  final int totalCount;
  final List<String>? images;

  const DetailHeader({Key? key, required this.totalCount, this.images})
      : super(key: key);

  @override
  State<DetailHeader> createState() => _DetailHeaderState();
}

class _DetailHeaderState extends State<DetailHeader> {
  CarouselController buttonCarouselController = CarouselController();
  int currentImageIndex = 1;
  void imageChanged(index, reason) {
    setState(() {
      currentImageIndex = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: buttonCarouselController,
          items: widget.images?.map((String imageUrl) {
            return Builder(builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              );
            });
          }).toList(),
          options: CarouselOptions(
            height: 500,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            onPageChanged: imageChanged,
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            height: 26,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black.withOpacity(0.6),
            ),
            child: Center(
              child: Text.rich(
                TextSpan(
                  text: '$currentImageIndex',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                  children: [
                    TextSpan(
                        text: '/${widget.totalCount}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: ColorStore.colorAF,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
