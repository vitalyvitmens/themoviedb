import 'dart:math';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'custom_paint'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: RadialPercentWidget(
            percent: 0.72,
            fillColor: Colors.black,
            lineColor: Colors.green[800]!,
            freeColor: Colors.yellow,
            lineWidth: 6,
            child: const Text(
              '72%',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadialPercentWidget extends StatelessWidget {
  final Widget child;

  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;
  
  const RadialPercentWidget({Key? key, 
  required this.child, 
  required this.percent, 
  required this.fillColor, 
  required this.lineColor, 
  required this.freeColor, 
  required this.lineWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand, //! по умолчанию виджет Stack стремиться занять минимальное пространство, а свойство expand наоборот и
      children: [           //! станет виден наш индикатор
        CustomPaint(painter: MyPainter(
          percent: percent,
          fillColor: fillColor,
          lineColor: lineColor,
          freeColor: freeColor,
          lineWidth: lineWidth,
        )),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(child: child),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;

  MyPainter({
    required this.percent, 
    required this.fillColor, 
    required this.lineColor, 
    required this.freeColor, 
    required this.lineWidth,
});
  
  @override
  void paint(Canvas canvas, Size size) { //! функция paint имеет 2 свойства: холст (canvas) и размер (size) = 100 х 100
    final arcRect = calculateArcsRect(size);

    drawBackground(canvas, size); //! что бы овал тянулся в след за изменениями размера его контейнера
    // canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);


    // paint.color = Colors.blue[800]!;
    // paint.style = PaintingStyle.stroke; //! stroke - задаёт стиль обводки фигуры, а fill - стиль заливки и они взаимоисключающиеся
    // paint.style = PaintingStyle.fill; //! fill - стиль заливки, а stroke - задаёт стиль обводки фигуры и они взаимоисключающиеся
    // paint.strokeWidth = 2; //! задает толщину линии обводки

    // canvas.drawCircle(Offset(size.width / 2, size.height / 2), 30, paint);
    // canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);
    // canvas.drawCircle(Offset.zero, 30, paint);

    // canvas.drawRect(Offset.zero & const Size(30, 30), paint);
    // canvas.drawRect(const Offset(5, 5) & const Size(30, 30), paint);
    // canvas.drawRect(const Offset(1, 1) & const Size(30, 30), paint);
    // canvas.drawLine(Offset.zero, const Offset(30, 30), paint);
    //! Создаём второй Paint:
    drawFreeArc(canvas, arcRect);
    //! Создаём третий Paint:
    drawFilledArc(canvas, arcRect);
  }

  void drawFilledArc(Canvas canvas, Rect arcRect) {
    final paint = Paint(); //! создаём отдельную переменную paint (задаёт стиль примитива) и положить в неё Paint()
    paint.color = lineColor;
    paint.style = PaintingStyle.stroke;  
    paint.strokeWidth = lineWidth;
    paint.strokeCap = StrokeCap.round; //! StrokeCap.round - скругляет концы линии (дуги нашего индикатора)
    canvas.drawArc(
      arcRect, 
      - pi / 2, 
      pi * 2 * percent, 
      false, 
      paint,
    );
  }

  void drawFreeArc(Canvas canvas, Rect arcRect) {
    final paint = Paint(); //! создаём отдельную переменную paint (задаёт стиль примитива) и положить в неё Paint()
    paint.color = freeColor;
    paint.style = PaintingStyle.stroke;  
    paint.strokeWidth = lineWidth;
    canvas.drawArc(
      arcRect, 
      pi * 2 * percent - (pi / 2), 
      pi * 2 * (1.0 - percent), 
      false, 
      paint,
    );
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint(); //! создаём отдельную переменную paint (задаёт стиль примитива) и положить в неё Paint()
    paint.color = fillColor;
    paint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint); //! что бы овал тянулся в след за изменениями размера его контейнера
    // canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  Rect calculateArcsRect(Size size) {
    const linesMargin = 3;
    final offset = lineWidth / 2 + linesMargin;
    final arcRect = Offset(offset, offset) & 
    Size(size.width - offset * 2, size.height - offset * 2);
    return arcRect;
  } 

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
