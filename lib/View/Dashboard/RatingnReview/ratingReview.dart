import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/Utils/images.dart';
import 'package:alpha_work/Utils/utils.dart';
import 'package:alpha_work/View/Dashboard/RatingnReview/productRatingNreview.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class RatingAndRewiewScreen extends StatefulWidget {
  const RatingAndRewiewScreen(
      {super.key, required this.image, required this.name});
  final String name;
  final String image;
  @override
  State<RatingAndRewiewScreen> createState() => _RatingAndRewiewScreenState();
}

class _RatingAndRewiewScreenState extends State<RatingAndRewiewScreen> {
  late ProfileViewModel reviewPro;
  @override
  void initState() {
    reviewPro = Provider.of<ProfileViewModel>(context, listen: false);
    reviewPro.ratingReviewData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    reviewPro = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Rating & Review"),
      body: reviewPro.isLoading
          ? appLoader()
          : Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => showDialog(
                                context: context,
                                builder: (dctx) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.image,
                                  ),
                                ),
                              ),
                              child: SizedBox.square(
                                dimension: (height / width) * 35,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    widget.image,
                                  ),
                                  onBackgroundImageError:
                                      (exception, stackTrace) =>
                                          ErrorImageWidget(height: 100),
                                ),
                              ),
                            ),
                            VerticalDivider(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.name,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "${reviewPro.reviewData.ratingCount} Global Rating",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: colors.greyText,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            RatingBar.readOnly(
                              size: 25,
                              halfFilledIcon: Icons.star_half,
                              isHalfAllowed: true,
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              initialRating: double.parse(
                                  reviewPro.reviewData.avgRating.toString()),
                              maxRating: 5,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${reviewPro.reviewData.avgRating.toString().substring(0, 3)} out of 5",
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: colors.lightGrey),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: ListView.builder(
                      itemCount: reviewPro.reviewData.products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () =>
                            reviewPro.reviewData.products[index].rating.isEmpty
                                ? Utils.showTost(msg: "No Reviews")
                                : Navigator.push(
                                    context,
                                    PageTransition(
                                        child: ProductReviewDetailScreen(
                                            id: reviewPro
                                                .reviewData.products[index].id
                                                .toString()),
                                        type: PageTransitionType.rightToLeft)),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.lightGrey,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  reviewPro.reviewData.products[index].thumbnail
                                      .toString(),
                                  height: height * .07,
                                  width: height * .07,
                                  fit: BoxFit.fitHeight,
                                  errorBuilder: (context, error, stackTrace) =>
                                      ErrorImageWidget(height: height * .07),
                                ),
                              ),
                              VerticalDivider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width * .38,
                                    child: AutoSizeText(
                                      reviewPro.reviewData.products[index].name
                                          .toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  RatingBar.readOnly(
                                    size: 20,
                                    halfFilledIcon: Icons.star_half,
                                    isHalfAllowed: true,
                                    filledIcon: Icons.star,
                                    emptyIcon: Icons.star_border,
                                    initialRating: reviewPro.reviewData
                                            .products[index].rating.isEmpty
                                        ? 0
                                        : double.parse(reviewPro
                                            .reviewData
                                            .products[index]
                                            .rating
                                            .first
                                            .average
                                            .toString()),
                                    maxRating: 5,
                                  ),
                                  Text(
                                    "${reviewPro.reviewData.products[index].rating.isEmpty ? 0 : reviewPro.reviewData.products[index].rating.first.average.toString().substring(0, 3)} Rating",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: colors.greyText,
                                        ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: AutoSizeText(
                                  reviewPro.reviewData.products[index].unitPrice
                                      .toString(),
                                  maxFontSize: 16,
                                  minFontSize: 14,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontFamily: "Montreal"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
