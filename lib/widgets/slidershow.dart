import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final double bulletPrimario;
  final double bulletSecundario;

  const Slideshow(
      {required this.slides,
      required this.puntosArriba,
      this.colorPrimario = const Color(0xFF50A6FD),
      this.colorSecundario = Colors.grey,
      this.bulletPrimario = 12.0,
      this.bulletSecundario = 12.0,});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (BuildContext context) {
              Provider.of<_SlideshowModel>(context).colorPrimario =
                  colorPrimario;
              Provider.of<_SlideshowModel>(context).colorSecundario =
                  colorSecundario;

              Provider.of<_SlideshowModel>(context).bulletPrimario =
                  bulletPrimario;
              Provider.of<_SlideshowModel>(context).bulletSecundario =
                  bulletSecundario;

              return _CrearEstructuraSlideShow(
                  puntosArriba: puntosArriba, slides: slides);
            },
          ),
        ),
      ),
    );
  }
}

class _CrearEstructuraSlideShow extends StatelessWidget {
  const _CrearEstructuraSlideShow({
    Key? key,
    required this.puntosArriba,
    required this.slides,
  }) : super(key: key);

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (puntosArriba) _Dots(slides.length),
        Expanded(child: _Slides(slides)),
        if (!puntosArriba) _Dots(slides.length),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;

  const _Dots(this.totalSlides);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (i) => _Dot(i)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideshowModel>(context);
    double tamano;
    Color color;

    if (ssModel.currentPage >= index - 0.5 &&
        ssModel.currentPage < index + 0.5) {
      tamano = ssModel.bulletPrimario;
      color = ssModel.colorPrimario;
    } else {
      tamano = ssModel.bulletSecundario;
      color = ssModel.colorSecundario;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: tamano,
      height: tamano,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides(this.slides);

  @override
  State<_Slides> createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      //Actualizar el provider, sliderModel
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PageView(
      controller: pageViewController,
      children: widget.slides.map((slide) => _Slide(slide)).toList(),
    ));
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: slide,
    );
  }
}

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _colorPrimario = const Color(0xffff6389);
  Color _colorSecundario = const Color.fromARGB(202, 44, 44, 44);
  double _bulletPrimario = 12;
  double _bulletSecundario = 12;
  Icon _back = const Icon(Icons.arrow_back_sharp);
  Icon _forward = const Icon(Icons.arrow_forward_sharp);

  double get currentPage => this._currentPage;

  set currentPage(double pagina) {
    this._currentPage = pagina;
    notifyListeners();
  }

  Color get colorPrimario => _colorPrimario;

  set colorPrimario(Color colorPrimario) {
    _colorPrimario = colorPrimario;
    //notifyListeners();  //Se ha eliminado el notifyListener al incluir le builder en el build del Slider
  }

  Color get colorSecundario => _colorSecundario;

  set colorSecundario(Color colorSecundario) {
    _colorSecundario = colorSecundario;
    //notifyListeners();
  }

  double get bulletPrimario => this._bulletPrimario;

  set bulletPrimario(double tamano) {
    _bulletPrimario = tamano;
  }

  double get bulletSecundario => this._bulletSecundario;

  set bulletSecundario(double tamano) {
    _bulletSecundario = tamano;
  }

  Icon get back => _back;

  set back(Icon back) {
    _back = back;
  }

  Icon get forward => _forward;

  set forward(Icon forward) {
    _forward = forward;
  }
}

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
          Color(0xFF50A6FD),
          Color(0xFFA9EFE3),
          Color(0xFFA9EFE3),
        ],
                stops: [
          0,
          0.9,
          1
        ])));
  }
}

class HeaderCurvo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderCurvoPainter(),
      ),
    );
  }
}

class _HeaderCurvoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint(); //Este sería nuestro "lapiz" para pintar.

    //Propiedades
    paint.color = Colors.white;
    paint.style = PaintingStyle
        .fill; //stroke para dibujar los bordes, fill para dibujar el relleno.
    paint.strokeWidth = 5.0; //definir el grosor del "lapiz"

    final path = Path();

    //Dibujar con el lapiz (la parte de arriba)

    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.80);
    //path.lineTo(size.width, size.height * 0.25);

    //Las dos primeras coordenadas es el ángulo de curvatura.
    //Las dos últimas coordenadas apuntan a donde termina la línea (el margen derecho en este caso)

    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.90, size.width, size.height * 0.80);

    path.lineTo(size.width, size.height);

    //Si queremos la curva invertida
    //el size.height del quadratic tiene que se menor que size.height * 0.25
    //path.lineTo(0, size.height * 0.25);

    //path.quadraticBezierTo(size.width* 0.5, size.height * 0.15 , size.width, size.height * 0.25);

    //path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ValuePorpose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      child: Column(
        children: [
          const Text(
            'CHEMICAL KNOWLEDGE',
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.w800),
          ),
          RichText(text: const TextSpan(
            text: 'One of the main ways to understand and transform the physical world',
            style: TextStyle(fontSize: 18),   
          ),
          textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
