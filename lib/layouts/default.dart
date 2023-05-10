import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linguaotter/components/theme_app.dart';

class NormalLayout extends StatelessWidget {
  const NormalLayout({Key? key, this.body, this.head, this.paddingHead, this.betweenHeadAndBody})
      : super(key: key);

  final List<Widget>? head;
  final List<Widget>? body;
  final double? paddingHead;
  final double? betweenHeadAndBody;

  @override
  Widget build(BuildContext context) {
    List<Widget>? currentHead = head;
    List<Widget>? currentBody = body;
    double? paddingHeadDefault = 0;
    double? between = 0;


    if (head == null) {

      currentHead = [LimitedBox(
        maxWidth: 0.0,
        maxHeight: 0.0,
        child: ConstrainedBox(constraints: const BoxConstraints.expand()),
      )];

      paddingHeadDefault = 0;
    } else if (paddingHead == null) {
      paddingHeadDefault = 30;
    } else {paddingHeadDefault = paddingHead;}

    if (betweenHeadAndBody == null) {
      between = 30;
    } else {between = paddingHead;}

    if (body == null) {
      currentBody = [LimitedBox(
        maxWidth: 0.0,
        maxHeight: 0.0,
        child: ConstrainedBox(constraints: const BoxConstraints.expand()),
      )];
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: ThemeApp.background(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: paddingHeadDefault),
                Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child:
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: currentHead!,
                  )
                  ,
                ),
                SizedBox(height: between),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                          children: currentBody!,
                        )))
              ],
            ),
          )),
    );
  }
}
