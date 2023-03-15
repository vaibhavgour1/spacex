import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makeb/ui/detailScreen/bloc/detail_screen_bloc.dart';
import 'package:makeb/ui/detailScreen/bloc/detail_screen_event.dart';
import 'package:makeb/ui/detailScreen/bloc/detail_screen_state.dart';
import 'package:makeb/utility/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:makeb/widget/text_view.dart';

class DetailScreen extends StatefulWidget {
  dynamic id;

  DetailScreen({Key? key, this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late PageController _pageController;

  List<String> images = [
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];

  int activePage = 1;
  DetailScreenBloc detailScreenBloc = DetailScreenBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    detailScreenBloc.add(GetDetailScreenEvent(id: widget.id!));
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return BlocProvider<DetailScreenBloc>(
        create: (context) => detailScreenBloc,
        child: SafeArea(
          child: Scaffold(body:
              BlocBuilder<DetailScreenBloc, DetailScreenState>(
                  builder: (context, state) {
            log("====>$state");
            if (state is LoadingState) {
              return Container(
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            if (state is FailureState) {
              Future.delayed(const Duration(seconds: 2)).then((value) {
                showAlert(context);
              });
            }
            if (state is GetDetailScreenState) {
              return Container(
                width: deviceWidth,
                height: deviceHeight,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Colors.white,
                  ],
                )),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText(data: "Name:${state.detailScreenModel.name}"),
                      SizedBox(
                        height: 200,
                        child: PageView.builder(
                            itemCount:
                                state.detailScreenModel.flickrImages!.length,
                            pageSnapping: true,
                            padEnds: false,
                            controller: _pageController,
                            onPageChanged: (page) {
                              setState(() {
                                activePage = page;
                              });
                            },
                            itemBuilder: (context, pagePosition) {
                              bool active = pagePosition == activePage;
                              return slider(
                                  state.detailScreenModel.flickrImages!,
                                  pagePosition,
                                  active);
                            }),
                      ),
                      titleText(
                          data:
                              "Active Stats:${state.detailScreenModel.active}",
                          fontSize: 16),
                      titleText(
                          data:
                              "Cost per Launch :${state.detailScreenModel.costPerLaunch}",
                          fontSize: 16),
                      titleText(
                          data:
                              "Success Rate percent:${state.detailScreenModel.successRatePct}",
                          fontSize: 16),
                      titleText(
                          data:
                              "Description:${state.detailScreenModel.description}",
                          fontSize: 14,
                          maxLines: 6),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          //style: defaultText,
                          text: "Wikipedia link.",
                          style: TextStyle(fontSize: 14,color: Colors.black)),
                        TextSpan(
                            // style: linkText,
                            text: "${state.detailScreenModel.wikipedia}",
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                String p = "";
                                log("===>${state.detailScreenModel.wikipedia.toString().split("https://en.wikipedia.org/wiki/").last}");

                                _launchURL("en.wikipedia.org",state.detailScreenModel.wikipedia.toString().split("https://en.wikipedia.org/wiki/").last);
                              }),
                      ])),
                      titleText(
                          data:
                              "Height & Diameter in Feet/Inches:${state.detailScreenModel.height!.feet}" +
                                  "/" +
                                  "${state.detailScreenModel.height!.meters}",
                          fontSize: 14),
                    ]),
              );
            }
            return Container();
          })),
        ));
  }

  Future<void> _launchURL(String url,last) async {
    final Uri uri = Uri(scheme: "https", host: url, path: "/wiki/Falcon_1");
    log("uri-->$uri");
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  showAlert(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Might Be An Error Please Retry"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    detailScreenBloc.add(GetDetailScreenEvent(id: widget.id));
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }
}

AnimatedContainer slider(images, pagePosition, active) {
  double margin = active ? 0 : 15;

  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    child: Image.network(
      images[pagePosition],
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    ),
  );
}
// images[pagePosition],
