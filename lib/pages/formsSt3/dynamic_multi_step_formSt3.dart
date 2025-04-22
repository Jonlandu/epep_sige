import 'package:flutter/material.dart';
import 'steps/location_step.dart';
import 'steps/identification_step.dart';
import 'steps/type_step.dart';
import 'steps/EtablissementStep.dart';
import 'steps/staffing_step.dart';
import 'steps/DiversStep.dart';
import 'steps/history_step.dart';
import 'steps/validation_step.dart';

class DynamiqueMultiStepFormST3 extends StatefulWidget {
  const DynamiqueMultiStepFormST3({super.key});

  @override
  State<DynamiqueMultiStepFormST3> createState() => _DynamiqueMultiStepFormST3State();
}

class _DynamiqueMultiStepFormST3State extends State<DynamiqueMultiStepFormST3> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  bool _isSubmitting = false;
  final ScrollController _scrollController = ScrollController();

  // Données du formulaire
  final Map<String, dynamic> formData = {
    'province': 'KONGO-CENTRAL',
    'proved': 'KONGO-CENTRAL I',
    'sousProved': 'MATADI 2',
    'centreRegroupement': 'PR06CR21',
    'nomEtablissement': 'CS. DORELI',
    'nomChefEtablissement': '',
    'typeEtablissement': 'Public',
    'niveauxEnseignement': <String>[],
    'capaciteAccueil': '',
    'nombreEleves': '',
    'nombreEnseignants': '',
    'adresse': '',
    'telephone': '',
    'email': '',
    'anneeCreation': '',
    'infrastructures': <String>[],
    'validation': false,
  };

  final List<GlobalKey<FormState>> _stepFormKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final List<Map<String, dynamic>> _stepsData = [
    {'title': 'Localisation', 'icon': Icons.location_on, 'color': Colors.blue},
    {'title': 'Identification', 'icon': Icons.assignment_ind, 'color': Colors.purple},
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
    });
  }

  void _scrollToCurrentStep() {
    if (_scrollController.hasClients) {
      final double itemWidth = 140.0;
      final double scrollOffset = _currentStep * itemWidth - (MediaQuery.of(context).size.width / 2 - itemWidth / 2);
      _scrollController.animateTo(
        scrollOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
      );
    }
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            labelStyle: TextStyle(color: Colors.grey.shade700),
          ),
        ),
        child: Column(
          children: [
            // Barre de progression
            Container(
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
              child: Scrollbar(
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _stepsData.length,
                  itemBuilder: (context, index) {
                    final step = _stepsData[index];
                    final isActive = index == _currentStep;
                    final isCompleted = index < _currentStep;
                    final color = step['color'] as Color;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentStep = index;
                        });
                      },
                      child: Container(
                        width: 140,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: isActive ? 50 : 40,
                                    height: isActive ? 50 : 40,
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? color.withOpacity(0.2)
                                          : (isCompleted
                                          ? color.withOpacity(0.1)
                                          : Colors.grey.shade100),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isActive
                                            ? color
                                            : (isCompleted ? color : Colors.grey.shade400),
                                        width: isActive ? 2 : 1,
                                      ),
                                    ),
                                    child: Icon(
                                      step['icon'],
                                      size: isActive ? 24 : 20,
                                      color: isActive
                                          ? color
                                          : (isCompleted ? color : Colors.grey.shade600),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    step['title'],
                                    style: TextStyle(
                                      fontSize: isActive ? 14 : 13,
                                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                      color: isActive
                                          ? color
                                          : (isCompleted ? color : Colors.grey.shade600),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 3,
                              width: isActive ? 100 : 80,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? color
                                    : (isCompleted ? color : Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Contenu du formulaire
            Expanded(
              child: Container(
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
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (Widget child, Animation<double> animation) {
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
                            child: _buildCurrentStepContent(),
                          ),
                          const SizedBox(height: 30),
                          Padding(
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
                                            ? 'Soumettre'
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
                          ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0: return LocationStep(formData: formData, formKey: _stepFormKeys[0]);
      case 1: return EtablissementStep(formData: formData, formKey: _stepFormKeys[0]);
      default: return Container();
    }
  }

  void _continue() {
    if (_currentStep == _stepsData.length - 1) {
      // Final submission
      if (_stepFormKeys[_currentStep].currentState!.validate() &&
          formData['validation'] == true) {
        _stepFormKeys[_currentStep].currentState!.save();
        _submitForm();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Veuillez compléter tous les champs obligatoires'),
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

      // Additional validation for step 2 (niveaux d'enseignement)
      if (_currentStep == 2 && formData['niveauxEnseignement'].isEmpty) {
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
            content: const Text('Veuillez compléter tous les champs obligatoires'),
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
        _scrollToCurrentStep();
      });
    }
  }

  Future<void> _submitForm() async {
    setState(() => _isSubmitting = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isSubmitting = false);

    // Show success dialog
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
              Icon(
                Icons.check_circle,
                color: Colors.green.shade600,
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Succès!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Le formulaire a été soumis avec succès!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _resetForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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

  void _resetForm() {
    setState(() {
      _currentStep = 0;
      formData.clear();
      formData.addAll({
        'province': 'KONGO-CENTRAL',
        'proved': 'KONGO-CENTRAL I',
        'sousProved': 'MATADI 2',
        'centreRegroupement': 'PR06CR21',
        'nomEtablissement': 'CS. DORELI',
        'niveauxEnseignement': <String>[],
        'infrastructures': <String>[],
        'validation': false,
      });

      for (var key in _stepFormKeys) {
        key.currentState?.reset();
      }
      _scrollToCurrentStep();
    });
  }
}