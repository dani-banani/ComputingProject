import 'package:flutter/material.dart';
import '../../widgets/footer_navbar_widget.dart';

class HomePage extends StatelessWidget {
  final ColorScheme colorScheme;
  const HomePage({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          buildShelfRow(constraints),
          buildClockRow(constraints),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: constraints.maxHeight * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Container(
                    height: constraints.maxHeight * 0.175,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 35,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.brown[800],
                          ),
                        ),
                        Positioned(
                            bottom: (constraints.maxHeight * 0.15 / 2) - 30,
                            left: constraints.maxWidth * 0.3,
                            right: constraints.maxWidth * 0.3,
                            child: Column(
                              children: [
                                CustomPaint(
                                  foregroundPainter: DesktopBasePainter(),
                                  willChange: false,
                                  child: Container(
                                    height: 40,
                                  ),
                                ),
                                Container(
                                  color: Colors.black,
                                  height: 10,
                                ),
                              ],
                            )),
                        Positioned(
                            top: 0,
                            bottom: (constraints.maxHeight * 0.15 / 2),
                            left: constraints.maxWidth * 0.45,
                            right: constraints.maxWidth * 0.45,
                            child: Container(color: Colors.black)),
                      ],
                    )),
              ],
            ),
          ),
          buildTableLegRow(constraints)
        ],
      );
    });
  }

  Container buildTableLegRow(BoxConstraints constraints) {
    return Container(
      color: Colors.brown[500],
      height: constraints.maxHeight * 0.15,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        color: colorScheme.surface,
      ),
    );
  }

  Container buildClockRow(BoxConstraints constraints) {
    return Container(
      color: Colors.red,
      height: constraints.maxHeight * 0.15,
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: SizedBox.square(
              dimension: constraints.maxHeight * 0.15 - 40,
              child: Container(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                child: Text("I am A clock that is a circle"),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(
                      (constraints.maxHeight * 0.15 - 40) / 2),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 40,
            child: SizedBox.square(
              dimension: (constraints.maxHeight * 0.15 - 40) / 1.5,
              child: Container(
                alignment: Alignment.center,
                color: Colors.green,
                child: Text("I am TourGuide"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildShelfRow(BoxConstraints constraints) {
    return Container(
      color: Colors.brown,
      height: constraints.maxHeight * 0.15,
      padding: const EdgeInsets.all(20),
      child: Container(
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: constraints.maxHeight * 0.15 - 40,
              child: Container(
                alignment: Alignment.center,
                color: Colors.green,
                child: Text("I am Books"),
              ),
            ),
            SizedBox.square(
              dimension: constraints.maxHeight * 0.15 - 40,
              child: Container(
                alignment: Alignment.center,
                color: Colors.greenAccent,
                child: Text("I am Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DesktopBasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    Path path = Path();
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.grey;

    path
      ..moveTo(0, height)
      ..lineTo(20, 0)
      ..lineTo(width - 20, 0)
      ..lineTo(width, height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
