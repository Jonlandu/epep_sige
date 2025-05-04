import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:epsp_sige/controllers/UserController.dart';
import 'package:epsp_sige/pages/introduction/DiscoverPage.dart';
import 'package:flutter/foundation.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final PageController _pageController = PageController();
  double _currentPage = 0.0;

  // Paramètres de taille de texte configurables
  double get titleFontSize => 28.0; // Taille de police des titres
  double get bodyFontSize => 16.0;  // Taille de police du corps
  double get buttonFontSize => 16.0; // Taille de police des boutons

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, () {
        var userCtrl = context.read<UserController>();
        bool firstTime = true;
        userCtrl.isFirstTimeBienvenue = firstTime;
      });
    });

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => DiscoverPage()),
    );
  }

  Widget _buildAnimatedImage(String assetName, int pageIndex) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: _currentPage >= pageIndex - 0.5 && _currentPage <= pageIndex + 0.5 ? 1.0 : 0.5,
      child: AnimatedScale(
        duration: Duration(milliseconds: 500),
        scale: _currentPage >= pageIndex - 0.5 && _currentPage <= pageIndex + 0.5 ? 1.0 : 0.9,
        child: Image.asset(
          'assets/$assetName',
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.4,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildFullscreenImage() {
    return Stack(
      children: [
        Image.asset(
          'assets/onbording1.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.6),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomDot(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 16 : 14,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF3366FF) : Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: titleFontSize,
        fontWeight: FontWeight.w800,
        height: 1.3,
      ),
      bodyTextStyle: TextStyle(
        fontSize: bodyFontSize,
        height: 1.5,
      ),
      bodyPadding: EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top: 40, bottom: 40),
      titlePadding: EdgeInsets.only(top: 40, bottom: 16),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            IntroductionScreen(
              key: introKey,
              pages: [
                PageViewModel(
                  title: "Collectez des données\nen temps réel",
                  body: "Accédez à toutes les informations nécessaires directement sur votre appareil mobile où que vous soyez.",
                  image: _buildAnimatedImage('onbording1.jpg', 0),
                  decoration: pageDecoration.copyWith(
                    imageFlex: 4,
                    bodyFlex: 2,
                  ),
                ),
                PageViewModel(
                  title: "Analyses\net rapports intelligents",
                  body: "Générez automatiquement des rapports détaillés et des analyses pertinentes pour une meilleure prise de décision.",
                  image: _buildAnimatedImage('dat.jpeg', 1),
                  decoration: pageDecoration.copyWith(
                    imageFlex: 6,
                    bodyFlex: 3,
                  ),
                ),
                PageViewModel(
                  title: "Synchronisation\nsécurisée",
                  body: "Toutes vos données sont cryptées et synchronisées en temps réel avec nos serveurs hautement sécurisés.",
                  image: _buildAnimatedImage('data2.jpeg', 2),
                  decoration: pageDecoration.copyWith(
                    imageFlex: 5,
                    bodyFlex: 2,
                  ),
                ),
                PageViewModel(
                  title: "Prêt ?",
                  body: "Commençons l'utilisation..",
                  image: _buildAnimatedImage('ready.jpeg', 3),
                  decoration: pageDecoration.copyWith(
                    imageFlex: 5,
                    bodyFlex: 2,
                  ),
                ),
              ],
              onDone: () => _onIntroEnd(context),
              onSkip: () => _onIntroEnd(context),
              showSkipButton: true,
              skipOrBackFlex: 0,
              nextFlex: 0,
              showBackButton: false,
              skip: Text(
                'Passer',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: buttonFontSize,
                ),
              ),
              next: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Color(0xFF336699),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF3366FF).withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
              done: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF3366FF),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF3366FF).withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Commencer',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: buttonFontSize,
                  ),
                ),
              ),
              curve: Curves.fastOutSlowIn,
              controlsMargin: EdgeInsets.only(bottom: 40),
              controlsPadding: EdgeInsets.all(16),
              dotsDecorator: DotsDecorator(
                size: Size(8, 8),
                activeSize: Size(24, 8),
                color: Colors.grey[300]!,
                activeColor: Color(0xFF336699),
                spacing: EdgeInsets.symmetric(horizontal: 4),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              dotsContainerDecorator: ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              globalBackgroundColor: Colors.white,
              freeze: false,
            ),
            // Navigation en haut
            Positioned(
              top: 16,
              right: 16,
              child: Image.asset(
                'assets/logo_esige_large.png',
                width: 100,
              ),
            ),
          ],
        ),
      ),
      // Bouton de démarrage en bas
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: ElevatedButton(
            onPressed: () => _onIntroEnd(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF336699),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              shadowColor: Color(0xFFFFFFFF).withOpacity(0.3),
            ),
            child: Text(
              'Commencer maintenant',
              style: TextStyle(
                color: Colors.white,
                fontSize: buttonFontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}