import 'package:alpha_work/Utils/color.dart';
import 'package:alpha_work/ViewModel/profileViewModel.dart';
import 'package:alpha_work/Widget/CommonAppbarWidget/commonappbar.dart';
import 'package:alpha_work/Widget/appLoader.dart';
import 'package:alpha_work/Widget/dateFormatter.dart';
import 'package:alpha_work/Widget/errorImage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ProductReviewDetailScreen extends StatefulWidget {
  const ProductReviewDetailScreen({super.key, required this.id});
  final String id;

  @override
  State<ProductReviewDetailScreen> createState() =>
      _ProductReviewDetailScreenState();
}

class _ProductReviewDetailScreenState extends State<ProductReviewDetailScreen> {
  final String data =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,";
  late ProfileViewModel reviewPro;
  @override
  void initState() {
    reviewPro = Provider.of<ProfileViewModel>(context, listen: false);
    reviewPro.ReviewDetailData(product_id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    reviewPro = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommanAppbar(appbarTitle: "Product Rating & Review"),
      body: reviewPro.isLoading
          ? appLoader()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        reviewPro.reviewDetailData.averageRating
                            .toString()
                            .substring(0, 3),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montreal"),
                      ),
                      RatingBar.readOnly(
                        alignment: Alignment.center,
                        size: 25,
                        halfFilledIcon: Icons.star_half,
                        isHalfAllowed: true,
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        initialRating: double.parse(reviewPro
                            .reviewDetailData.averageRating
                            .toString()
                            .substring(0, 3)),
                        maxRating: 5,
                      ),
                      Text(
                        "${reviewPro.reviewDetailData.totalReviews.toString()} Global Average Rating",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: colors.greyText,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Excellent",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: colors.greyText),
                          ),
                          Spacer(),
                          LinearPercentIndicator(
                            percent: double.parse(reviewPro
                                    .reviewDetailData.rating[0]
                                    .toString()) *
                                .2,
                            animation: true,
                            width: width * .45,
                            barRadius: Radius.circular(10),
                            progressColor: colors.buttonColor,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Good",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: colors.greyText),
                          ),
                          Spacer(),
                          LinearPercentIndicator(
                            percent: double.parse(reviewPro
                                    .reviewDetailData.rating[1]
                                    .toString()) *
                                .2,
                            animation: true,
                            width: width * .45,
                            barRadius: Radius.circular(10),
                            progressColor: Colors.green,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Average",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: colors.greyText),
                          ),
                          Spacer(),
                          LinearPercentIndicator(
                            percent: double.parse(reviewPro
                                    .reviewDetailData.rating[2]
                                    .toString()) *
                                .2,
                            animation: true,
                            width: width * .45,
                            barRadius: Radius.circular(10),
                            progressColor: Colors.yellow,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Below Average",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: colors.greyText),
                          ),
                          Spacer(),
                          LinearPercentIndicator(
                            animation: true,
                            percent: double.parse(reviewPro
                                    .reviewDetailData.rating[3]
                                    .toString()) *
                                .2,
                            width: width * .45,
                            barRadius: Radius.circular(10),
                            progressColor: Colors.amber,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Poor",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: colors.greyText),
                          ),
                          Spacer(),
                          LinearPercentIndicator(
                            percent: double.parse(reviewPro
                                    .reviewDetailData.rating[4]
                                    .toString()) *
                                .2,
                            width: width * .45,
                            animation: true,
                            barRadius: Radius.circular(10),
                            progressColor: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(color: colors.lightGrey),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.transparent),
                      shrinkWrap: true,
                      itemCount: reviewPro.reviewDetailData.reviews.length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (dctx) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: CachedNetworkImage(
                                      imageUrl: reviewPro.reviewDetailData
                                          .reviews[index].customer!.image
                                          .toString(),
                                    ),
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: (height / width) * 15,
                                  backgroundColor: colors.lightGrey,
                                  backgroundImage: NetworkImage(reviewPro
                                      .reviewDetailData
                                      .reviews[index]
                                      .customer!
                                      .image
                                      .toString()),
                                  onBackgroundImageError:
                                      (exception, stackTrace) =>
                                          ErrorImageWidget(height: 65),
                                ),
                              ),
                              VerticalDivider(width: 5),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reviewPro.reviewDetailData.reviews[index]
                                        .customer!.name
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  RatingBar.readOnly(
                                    size: 20,
                                    halfFilledIcon: Icons.star_half,
                                    isHalfAllowed: true,
                                    filledIcon: Icons.star,
                                    emptyIcon: Icons.star_border,
                                    initialRating: double.parse(reviewPro
                                        .reviewDetailData.reviews[index].rating
                                        .toString()),
                                    maxRating: 5,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    CustomDateFormat.formatDateOnly(reviewPro
                                        .reviewDetailData
                                        .reviews[index]
                                        .createdAt
                                        .toString()),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: colors.greyText,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          AutoSizeText(
                            reviewPro.reviewDetailData.reviews[index].comment
                                .toString(),
                            maxFontSize: 14,
                            minFontSize: 12,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: colors.greyText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
