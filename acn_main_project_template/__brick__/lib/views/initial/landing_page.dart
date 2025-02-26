import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'package:{{project_file_name}}/core/local_storage/shared_preference.dart';
import 'package:{{project_file_name}}/utils/constants/assets_manager.dart';
import 'package:{{project_file_name}}/views/login_page/login_page.dart';
import 'package:{{project_file_name}}/widget_dialogs/widgets/customs/custom_appbars/appbar.dart';
import 'package:tuple/tuple.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController pageController = PageController();
  ValueNotifier<int> indexNotifier = ValueNotifier(0);
  List<Tuple3<String, String, String>> landingPages = [
    const Tuple3("Kolay Müşteri Yönetimi!", ImageAssets.landing1,
        "Müşteri bilgilerini hızlıca görüntüleyin, poliçe durumlarını takip edin ve işlemleri tek bir ekrandan yönetin."),
    const Tuple3("Gerçek Zamanlı Performans İzleme!", ImageAssets.landing2,
        "Acentenizin performansını anlık olarak izleyin, hedeflerinize ulaşmak için gerekli adımları hızlıca atın."),
    const Tuple3("Hızlı ve Güvenli Teklif Oluşturma!", ImageAssets.landing3,
        "Müşterilerinize en uygun teklifleri saniyeler içinde hazırlayın ve paylaşın.")
  ];

  @override
  void dispose() {
    indexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarPrimary(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (val){
                    indexNotifier.value=(val % landingPages.length);
                  },
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    itemBuilder: (_, index) => _Page(
                          isLast:index % landingPages.length==2,
                          onNext: () {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.linear);
                          },
                          landingData: landingPages[index % landingPages.length],
                        )),
              ),
              ValueListenableBuilder<int>(
                  valueListenable: indexNotifier,
                  builder: (context, value, _) {
                    return Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                            landingPages.length,
                                (index) => circle(index == value,
                                    size: 16))
                      ],
                    );
                  })
            ],
          ),
        ));
  }

  Widget circle(bool isActive, {required double size}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: size/2),
        child: SizedBox(
          width: size,
          height: size,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : Colors.grey))),
        ),
      );
}

class _Page extends StatelessWidget {
  final bool isLast;
  final VoidCallback onNext;
  final Tuple3<String, String, String> landingData;

  const _Page({super.key, required this.landingData, required this.onNext,this.isLast=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          const Spacer(),
          Expanded(
            flex: 10,
            child: LayoutBuilder(builder: (_, constraint) {
              final height = constraint.maxHeight;
              return TweenAnimationBuilder(
                key: ValueKey(landingData),
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                builder: (_, value, __) {
                  return Column(
                    children: [
                      Transform.translate(
                        offset: Offset(-(1 - value) * 300, 0),
                        child: Text(
                          landingData.item1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: (height * .035).clamp(1, 32),
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withOpacity(value)),
                        ),
                      ),
                      Expanded(
                        child: Transform.translate(
                          offset: Offset((1 - value) * 200, 0),
                          child: Center(
                            child: Image.asset(
                              opacity: AlwaysStoppedAnimation(value),
                              landingData.item2,
                              height: height * .5,
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(-(1 - value) * 300, 0),
                        child: Text(
                          landingData.item3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withOpacity(value),
                              fontSize: (height * .025).clamp(1, 24)),
                        ),
                      ),
                      (height * .035).heightDoubleMargin,
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(fontSize: (height * .025).clamp(1, 24)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 44),
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),

                                //border radius equal to or more than 50% of width
                              )),
                          onPressed: onNext,
                          child: Text(isLast?"Tekrar":"İlerle")),
                      TextButton(
                          style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: (height * .025).clamp(1, 24)),
                              foregroundColor: Theme.of(context).primaryColor),
                          onPressed: () {
                            StorageManager.setLandingShow();
                            Get.off(() => const LoginPage(),transition: Transition.rightToLeft);
                          },
                          child: const Text("Geç")),
                    ],
                  );
                },
              );
            }),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
