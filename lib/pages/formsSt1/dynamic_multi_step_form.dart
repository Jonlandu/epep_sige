import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epsp_sige/controllers/FormService.dart';
import 'package:epsp_sige/controllers/SyncServiceController.dart';
import 'package:epsp_sige/models/DatabaseHelper.dart';
import 'package:epsp_sige/models/SchoolForm.dart';
import 'package:epsp_sige/pages/formsSt1/steps/step55.dart';
import 'package:epsp_sige/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'steps/step1.dart';
import 'steps/step2.dart';
import 'steps/step3.dart';
import 'steps/step4.dart';
import 'steps/step5.dart';
// import 'steps/contact_step.dart';
// import 'steps/history_step.dart';
import 'steps/step6.dart';

class DynamiqueMultiStepForm extends StatefulWidget {
  final int? idannee;
  final int? idetablissement;
  final Map<String, dynamic>? initialData;

  final String? userToken;

  const DynamiqueMultiStepForm({
    super.key,
    this.idannee,
    this.idetablissement,
    this.initialData,
    this.userToken,
  });

  @override
  State<DynamiqueMultiStepForm> createState() => _DynamiqueMultiStepFormState();
}

class _DynamiqueMultiStepFormState extends State<DynamiqueMultiStepForm> {
  final SyncServiceController _syncService = SyncServiceController();
  final Connectivity _connectivity = Connectivity();
  //
  var box = GetStorage();

  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  bool _isSubmitting = false;
  final ScrollController _scrollController = ScrollController();
  PageController pageController = PageController();
  final RxInt _currentIndex = 0.obs; // pour savoir où on est
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Données du formulaire
  Map<String, dynamic> formData = {};

  // Clés pour chaque étape du formulaire
  final List<GlobalKey<FormState>> _stepFormKeys =
      List.generate(8, (index) => GlobalKey<FormState>());

  final List<Map<String, dynamic>> _stepsData = [
    {'title': 'Localisation', 'icon': Icons.location_on, 'color': Colors.blue},
    {
      'title': 'Identification',
      'icon': Icons.assignment_ind,
      'color': Colors.purple
    },
    {'title': 'Type', 'icon': Icons.category, 'color': Colors.orange},
    {'title': 'Capacité', 'icon': Icons.people_outline, 'color': Colors.green},
    {'title': 'Effectifs', 'icon': Icons.school, 'color': Colors.teal},
    {'title': 'Contact', 'icon': Icons.contact_phone, 'color': Colors.pink},
    {'title': 'Historique', 'icon': Icons.history, 'color': Colors.indigo},
    {'title': 'Validation', 'icon': Icons.verified_user, 'color': Colors.red},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentStep();
      _startSyncListener();
    });
    //
    Map user = box.read('user') ?? {};
    formData = {
      'province': user['province'],
      'proved': user['proved'],
      'sousProved': user['sousproved'],
      'centreRegroupement': 'PR06CR21',
      'nomEtablissement': 'CS. DORELI',
      'nomChefEtablissement': '',
      'typeEtablissement': 'Public',
      'niveauxEnseignement': <String>[],
      'capaciteAccueil': '',
      'nombreEleves': '',
      'nombreEnseignants': '',
      'adresse': '',
      'telephone': user['phone'],
      'email': user['email'],
      'anneeCreation': '',
      'infrastructures': <String>[],
      'validation': false,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentStep() {
    if (_scrollController.hasClients) {
      final double itemWidth = 140.0;
      final double scrollOffset = _currentStep * itemWidth -
          (MediaQuery.of(context).size.width / 2 - itemWidth / 2);
      setState(() {
        pageController.nextPage(
          //scrollOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuint,
        );
        //
        setState(() {
          _currentIndex.value++;
        });
      });
    }
  }

  void _startSyncListener() {
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        await _syncService.syncPendingForms(token: widget.userToken);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.blue.shade800,
            secondary: Colors.blue.shade600,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            labelStyle: TextStyle(color: Colors.grey.shade700),
          ),
        ),
        child: Column(
          children: [
            // Barre de progression
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  7, //_stepsData.length
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    width: _currentIndex.value == index ? 12 : 8,
                    height: _currentIndex.value == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentIndex.value == index
                          ? Colors.blue
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            //_buildStepProgressBar(),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex.value = index;
                    });
                  },
                  //physics: NeverScrollableScrollPhysics(),
                  children: [
                    Step1(
                      formData: formData,
                      formKey: _stepFormKeys[0],
                      controller: pageController,
                    ),
                    Step2(
                        formData: formData,
                        formKey: _stepFormKeys[1],
                        controller: pageController),
                    Step3(
                        formData: formData,
                        formKey: _stepFormKeys[2],
                        controller: pageController),
                    Step4(
                        formData: formData,
                        formKey: _stepFormKeys[3],
                        controller: pageController),
                    Step5(
                        formData: formData,
                        formKey: _stepFormKeys[4],
                        controller: pageController),
                    // ContactStep(
                    //     formData: formData,
                    //     formKey: _stepFormKeys[5],
                    //     controller: pageController),
                    // HistoryStep(
                    //     formData: formData,
                    //     formKey: _stepFormKeys[6],
                    //     controller: pageController),
                    Step55(
                      formData: formData,
                      formKey: _stepFormKeys[7],
                      controller: pageController,
                    ),
                    Step6(
                      formData: formData,
                      formKey: _stepFormKeys[7],
                      controller: pageController,
                      send: submitForm,
                    ),
                    // Container(),
                  ],
                ),
              ),
              // Contenu du formulaire
              //_buildFormContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepProgressBar() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      // child: Scrollbar(
      //   child: ListView.builder(
      //     controller: _scrollController,
      //     scrollDirection: Axis.horizontal,
      //     itemCount: _stepsData.length,
      //     itemBuilder: (context, index) {
      //       final step = _stepsData[index];
      //       final isActive = index == _currentStep;
      //       final isCompleted = index < _currentStep;
      //       final color = step['color'] as Color;
      //       return GestureDetector(
      //         onTap: () {
      //           if (index < _currentStep ||
      //               (index > _currentStep &&
      //                   _stepFormKeys[_currentStep].currentState?.validate() ==
      //                       true)) {
      //             setState(() => _currentStep = index);
      //           }
      //         },
      //         child: Container(
      //           width: 140,
      //           padding: const EdgeInsets.symmetric(horizontal: 8),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Expanded(
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     AnimatedContainer(
      //                       duration: const Duration(milliseconds: 300),
      //                       width: isActive ? 50 : 40,
      //                       height: isActive ? 50 : 40,
      //                       decoration: BoxDecoration(
      //                         color: isActive
      //                             ? color.withOpacity(0.2)
      //                             : (isCompleted
      //                                 ? color.withOpacity(0.1)
      //                                 : Colors.grey.shade100),
      //                         shape: BoxShape.circle,
      //                         border: Border.all(
      //                           color: isActive
      //                               ? color
      //                               : (isCompleted
      //                                   ? color
      //                                   : Colors.grey.shade400),
      //                           width: isActive ? 2 : 1,
      //                         ),
      //                       ),
      //                       child: Icon(
      //                         step['icon'],
      //                         size: isActive ? 24 : 20,
      //                         color: isActive
      //                             ? color
      //                             : (isCompleted
      //                                 ? color
      //                                 : Colors.grey.shade600),
      //                       ),
      //                     ),
      //                     const SizedBox(height: 8),
      //                     Text(
      //                       step['title'],
      //                       style: TextStyle(
      //                         fontSize: isActive ? 14 : 13,
      //                         fontWeight: isActive
      //                             ? FontWeight.bold
      //                             : FontWeight.normal,
      //                         color: isActive
      //                             ? color
      //                             : (isCompleted
      //                                 ? color
      //                                 : Colors.grey.shade600),
      //                       ),
      //                       textAlign: TextAlign.center,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               AnimatedContainer(
      //                 duration: const Duration(milliseconds: 300),
      //                 height: 3,
      //                 width: isActive ? 100 : 80,
      //                 decoration: BoxDecoration(
      //                   color: isActive
      //                       ? color
      //                       : (isCompleted ? color : Colors.grey.shade300),
      //                   borderRadius: BorderRadius.circular(3),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      child: TabBar(
        dividerColor: Colors.transparent,
        tabs: List.generate(
          _stepsData.length,
          (e) {
            return Tab(
              text: '${_stepsData[e]['title']}',
              icon: Icon(_stepsData[e]['icon']),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50.withOpacity(0.3),
            Colors.white,
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SizeTransition(
                        sizeFactor: animation,
                        axis: Axis.vertical,
                        axisAlignment: -1,
                        child: child,
                      ),
                    );
                  },
                  //child: _buildCurrentStepContent(),
                ),
                const SizedBox(height: 30),
                _buildNavigationButtons(),
                if (_isSubmitting)
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      strokeWidth: 3,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          if (_currentStep != 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _cancel,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.blue.shade800, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  'Précédent',
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (_currentStep != 0) const SizedBox(width: 16),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade800,
                    Colors.blue.shade600,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade400.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  _currentStep == _stepsData.length - 1
                      ? 'Enregistrer en local'
                      : 'Suivant',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCurrentStepContent() {
  //   switch (_currentStep) {
  //     case 0:
  //       return SchoolInformationForm(
  //         formData: formData,
  //         formKey: _stepFormKeys[0],
  //         controller: pageController,
  //       );
  //     case 1:
  //       return IdentificationStep(
  //         formData: formData,
  //         formKey: _stepFormKeys[1],
  //         controller: pageController,
  //       );
  //     case 2:
  //       return TypeStep(
  //         formData: formData,
  //         formKey: _stepFormKeys[2],
  //         controller: pageController,
  //       );
  //     case 3:
  //       return CapacityStep(
  //         formData: formData,
  //         formKey: _stepFormKeys[3],
  //         controller: pageController,
  //       );
  //     case 4:
  //       return StaffingStep(
  //         formData: formData,
  //         formKey: _stepFormKeys[4],
  //         controller: pageController,
  //       );
  //     case 5:
  //       return ContactStep(
  //         formData: formData,
  //         formKey: _stepFormKeys[5],
  //         controller: pageController,
  //       );
  //     case 6:
  //       return HistoryStep(
  //         formData: formData,
  //         formKey: _stepFormKeys[6],
  //         controller: pageController,
  //       );
  //     case 7:
  //       return ValidationStep(
  //         formData: formData,
  //         formKey: _stepFormKeys[7],
  //         controller: pageController,
  //       );
  //     default:
  //       return Container();
  //   }
  // }

  void _continue() {
    //Fin du formulaire
    if (_currentStep == _stepsData.length - 1) {
      // Final submission
      if (_stepFormKeys[_currentStep].currentState!.validate() &&
          formData['validation'] == true) {
        _stepFormKeys[_currentStep].currentState!.save();
        submitForm();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                const Text('Veuillez compléter tous les champs obligatoires'),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } else {
      // Validate current step
      bool isValid = true;

      if (!_stepFormKeys[_currentStep].currentState!.validate()) {
        isValid = false;
      }

      if (isValid) {
        _stepFormKeys[_currentStep].currentState!.save();
        setState(() {
          _currentStep += 1;
          _scrollToCurrentStep();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                const Text('Veuillez compléter tous les champs obligatoires'),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;

        _currentIndex.value--;

        pageController.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuint,
        );
        //_scrollToCurrentStep();
      });
    }
  }

  Future<void> submitForm() async {
    setState(() => _isSubmitting = true);

    try {
      // Validation des étapes
      for (final key in _stepFormKeys) {
        if (!key.currentState!.validate()) {
          throw Exception('Veuillez compléter tous les champs requis');
        }
        key.currentState!.save();
      }

      if (formData['validation'] != true) {
        throw Exception('Vous devez valider le formulaire');
      }

      final form = SchoolForm(
        idannee: widget.idannee,
        idetablissement: widget.idetablissement,
        data: formData,
      );

      final id = await _dbHelper.saveForm(form.toMap(), "formData1");
      final response = await _syncService.syncForm(jsonEncode(form.data),
          token: widget.userToken);

      if (response.status) {
        /**
         * 
          'is_synced': 1,
          'updated_at': DateTime.now().toIso8601String(),
        */

        //
        await _dbHelper.markFormAsSynced(id);
        _showSuccessDialog(isOnline: true);
      } else {
        await _dbHelper.scheduleSync(id);
        _showSuccessDialog(isOnline: false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Enregistré localement. Erreur de sync: ${response.errorMsg ?? "Inconnue"}'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      _showSuccessDialog(isOnline: false);
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  void _showSuccessDialog({bool isOnline = true}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    // Navigator.pushNamedAndRemoveUntil(
                    //   context,
                    //   Routes.BottomNavigationPageRoutes,
                    //   ModalRoute.withName('/loginpage'),
                    // );
                  },
                ),
              ),
              Icon(
                Icons.check_circle,
                color: Colors.green.shade600,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                isOnline ? 'Succès!' : 'Sauvegardé localement',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isOnline
                    ? 'Le formulaire est enregistré avec succès!'
                    : 'Le formulaire a été sauvegardé localement et sera synchronisé dès que possible.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.SavedFormsScreenRoutes);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
