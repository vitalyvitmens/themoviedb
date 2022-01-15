import 'package:flutter/material.dart';
import 'package:themoviedb/resources/resources.dart';

class MoviedetailsMainScreenCastWidget extends StatelessWidget {
  const MoviedetailsMainScreenCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Series Cast',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 350,
            child: Scrollbar(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 20,
                itemExtent: 120, //! ширина
                scrollDirection: Axis
                    .horizontal, //! что бы скролить в горизонтальном напрвалении
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white, //! цвет внутри рамки (контейнера)
                        border: Border.all(
                            color: Colors.black.withOpacity(
                                0.2)), //! цвет рамки и её процент прозрачности = 0.2
                        borderRadius: const BorderRadius.all(Radius.circular(
                            10)), //! скругление углов рамки = 10
                        boxShadow: [
                          BoxShadow(
                            //! задаём тень элемента
                            color: Colors.black.withOpacity(
                                0.1), //! задаем тень рамки с прозрачностью 0.1
                            blurRadius: 8, //! размывает тень из под элемента
                            offset: const Offset(0,
                                2), //! сдвиг тени из под элемента по оси х = 0 (+вправо, -влево), по оси у = 2 (+вниз, -вверх)
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(
                            8)), //! скругляем фото вверхних углах
                        clipBehavior: Clip
                            .hardEdge, //!  что бы не сильно било по производительности
                        child: Column(
                          children: [
                            const Image(image: AssetImage(AppImages.actor)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Michael B. Jordan',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                  ),
                                  const SizedBox(height: 7),
                                  const Text(
                                    'Mark Grayson / Invincible (voice)',
                                    maxLines: 4,
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    '70 Episodes',
                                    maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[500],
                                    fontSize: 14,
                                  ),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextButton(
                onPressed: () {}, child: const Text('Full Cast & Crew')),
          ),
        ],
      ),
    );
  }
}
