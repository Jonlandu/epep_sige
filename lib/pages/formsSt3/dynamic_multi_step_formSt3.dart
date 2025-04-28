import 'package:epsp_sige/controllers/FormService.dart';
import 'package:epsp_sige/models/DatabaseHelper.dart';
import 'package:epsp_sige/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'steps/location_step.dart';
import 'steps/identification_step.dart';
import 'steps/EducationStep.dart';
import 'steps/ThemesTransversauxStep.dart';
import 'steps/StudentDataForm.dart';
import 'steps/ContactDataForm.dart';
import 'steps/FormationDataForm.dart';
import 'steps/validation_step.dart';

class DynamiqueMultiStepFormST3 extends StatefulWidget {
  final int? idannee;
  final int? idetablissement;

  const DynamiqueMultiStepFormST3({
    super.key,
    this.idannee,
    this.idetablissement,
  });

  @override
  State<DynamiqueMultiStepFormST3> createState() => _DynamiqueMultiStepFormST3State();
}

class _DynamiqueMultiStepFormST3State extends State<DynamiqueMultiStepFormST3> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  bool _isSubmitting = false;
  final ScrollController _scrollController = ScrollController();
  final FormService _formService = FormService();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Données du formulaire - Réorganisé pour une meilleure lisibilité
  final Map<String, dynamic> formData = {
    // Section Localisation
    'province': 'KONGO-CENTRAL',
    'proved': 'KONGO-CENTRAL I',
    'sousProved': 'MATADI 2',
    'centreRegroupement': 'PR06CR21',
    'nomEtablissement': 'CS. DORELI',

    // Section Identification
    'nomChefEtablissement': '',
    'typeEtablissement': 'Public',

    // Section Education
    'niveauxEnseignement': <String>[],

    // Section Capacité
    'capaciteAccueil': '',
    'nombreEleves': '',
    'nombreEnseignants': '',

    // Section Contact
    'adresse': '',
    'telephone': '',
    'email': '',

    // Section Historique
    'anneeCreation': '',
    'infrastructures': <String>[],

    // Validation
    'validation': false,
    'created_at': DateTime.now().toIso8601String(),
  };

  // Clés de formulaire pour chaque étape
  final List<GlobalKey<FormState>> _stepFormKeys = List.generate(
      8,
          (index) => GlobalKey<FormState>()
  );

  // Configuration des étapes - Réorganisé pour une meilleure lisibilité
  final List<Map<String, dynamic>> _stepsData = [
    {
      'title': 'Localisation',
      'icon': Icons.location_on,
      'color': Colors.blue,
      'description': 'Informations géographiques'
    },
    {
      'title': 'Identification',
      'icon': Icons.assignment_ind,
      'color': Colors.purple,
      'description': 'Identification de l\'établissement'
    },
    {
      'title': 'Type',
      'icon': Icons.category,
      'color': Colors.orange,
      'description': 'Type et niveaux d\'enseignement'
    },
    {
      'title': 'Capacité',
      'icon': Icons.people_outline,
      'color': Colors.green,
      'description': 'Capacité d\'accueil'
    },
    {
      'title': 'Effectifs',
      'icon': Icons.school,
      'color': Colors.teal,
      'description': 'Effectifs enseignants et élèves'
    },
    {
      'title': 'Contact',
      'icon': Icons.contact_phone,
      'color': Colors.pink,
      'description': 'Coordonnées de contact'
    },
    {
      'title': 'Historique',
      'icon': Icons.history,
      'color': Colors.indigo,
      'description': 'Historique et infrastructures'
    },
    {
      'title': 'Validation',
      'icon': Icons.verified_user,
      'color': Colors.red,
      'description': 'Vérification et soumission'
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentStep();
    });
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
          inputDecorationTheme: _buildInputDecorationTheme(),
        ),
        child: Column(
          children: [
            _buildStepProgressBar(),
            _buildFormContent(),
          ],
        ),
      ),
    );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: TextStyle(color: Colors.grey.shade700),
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
      child: Scrollbar(
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: _stepsData.length,
          itemBuilder: (context, index) => _buildStepItem(index),
        ),
      ),
    );
  }

  Widget _buildStepItem(int index) {
    final step = _stepsData[index];
    final isActive = index == _currentStep;
    final isCompleted = index < _currentStep;
    final color = step['color'] as Color;

    return GestureDetector(
      onTap: () => _onStepTap(index),
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
                  _buildStepIcon(step, isActive, isCompleted, color),
                  const SizedBox(height: 8),
                  _buildStepTitle(step, isActive, isCompleted, color),
                ],
              ),
            ),
            _buildStepIndicator(isActive, isCompleted, color),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIcon(Map<String, dynamic> step, bool isActive, bool isCompleted, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 50 : 40,
      height: isActive ? 50 : 40,
      decoration: BoxDecoration(
        color: isActive
            ? color.withOpacity(0.2)
            : (isCompleted ? color.withOpacity(0.1) : Colors.grey.shade100),
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? color : (isCompleted ? color : Colors.grey.shade400),
          width: isActive ? 2 : 1,
        ),
      ),
      child: Icon(
        step['icon'],
        size: isActive ? 24 : 20,
        color: isActive ? color : (isCompleted ? color : Colors.grey.shade600),
      ),
    );
  }

  Widget _buildStepTitle(Map<String, dynamic> step, bool isActive, bool isCompleted, Color color) {
    return Text(
      step['title'],
      style: TextStyle(
        fontSize: isActive ? 14 : 13,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        color: isActive ? color : (isCompleted ? color : Colors.grey.shade600),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildStepIndicator(bool isActive, bool isCompleted, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 3,
      width: isActive ? 100 : 80,
      decoration: BoxDecoration(
        color: isActive ? color : (isCompleted ? color : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  void _onStepTap(int index) {
    if (index < _currentStep ||
        (index > _currentStep && _stepFormKeys[_currentStep].currentState?.validate() == true)) {
      setState(() => _currentStep = index);
    }
  }

  Widget _buildFormContent() {
    return Expanded(
      child: Container(
        decoration: _buildFormBackground(),
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
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    child: _buildCurrentStepContent(),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildNavigationButtons(),
                  if (_isSubmitting) _buildLoadingIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildFormBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.blue.shade50.withOpacity(0.3),
          Colors.white,
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        strokeWidth: 3,
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          if (_currentStep != 0)
            Expanded(child: _buildPreviousButton()),
          if (_currentStep != 0) const SizedBox(width: 16),
          Expanded(child: _buildNextButton()),
        ],
      ),
    );
  }

  Widget _buildPreviousButton() {
    return OutlinedButton(
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
    );
  }

  Widget _buildNextButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.blue.shade600],
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
          _currentStep == _stepsData.length - 1 ? 'Enregistrer en local' : 'Suivant',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0: return LocationStep(formData: formData, formKey: _stepFormKeys[0]);
      case 1: return InfrastructureStep(formData: formData, formKey: _stepFormKeys[1]);
      case 2: return EducationStep(formData: formData, formKey: _stepFormKeys[2]);
      case 3: return ThemesTransversauxStep(formData: formData, formKey: _stepFormKeys[3]);
      case 4: return StudentDataForm(formData: formData, formKey: _stepFormKeys[4]);
      case 5: return ContactDataForm(formData: formData, formKey: _stepFormKeys[5]);
      case 6: return FormationDataForm(formData: formData, formKey: _stepFormKeys[6]);
      case 7: return ValidationStep(formData: formData, formKey: _stepFormKeys[7]);
      default: return Container();
    }
  }

  Future<void> _saveDraft() async {
    if (_stepFormKeys[_currentStep].currentState?.validate() ?? false) {
      _stepFormKeys[_currentStep].currentState?.save();

      try {
        setState(() => _isSubmitting = true);

        // Ajouter les métadonnées
        formData['idannee'] = widget.idannee;
        formData['idetablissement'] = widget.idetablissement;
        formData['updated_at'] = DateTime.now().toIso8601String();

        await _dbHelper.saveForm(formData);

        _showSnackBar(
          message: 'Brouillon sauvegardé avec succès',
          color: Colors.green.shade600,
        );
      } catch (e) {
        _showSnackBar(
          message: 'Erreur lors de la sauvegarde: $e',
          color: Colors.red.shade600,
        );
      } finally {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showSnackBar({required String message, required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _continue() {
    if (_currentStep == _stepsData.length - 1) {
      _handleFinalSubmission();
    } else {
      _validateAndProceed();
    }
  }

  void _handleFinalSubmission() {
    if (_stepFormKeys[_currentStep].currentState!.validate() &&
        formData['validation'] == true) {
      _stepFormKeys[_currentStep].currentState!.save();
      _submitForm();
    } else {
      _showSnackBar(
        message: 'Veuillez compléter tous les champs obligatoires',
        color: Colors.red.shade600,
      );
    }
  }

  void _validateAndProceed() {
    bool isValid = _stepFormKeys[_currentStep].currentState!.validate();

    // Validation supplémentaire pour l'étape 2 (niveaux d'enseignement)
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
      _showSnackBar(
        message: 'Veuillez compléter tous les champs obligatoires',
        color: Colors.red.shade600,
      );
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
        'created_at': DateTime.now().toIso8601String(),
      });

      for (var key in _stepFormKeys) {
        key.currentState?.reset();
      }
      _scrollToCurrentStep();
    });
  }

  Future<void> _submitForm() async {
    setState(() => _isSubmitting = true);

    try {
      // Ajouter les métadonnées
      formData['idannee'] = widget.idannee;
      formData['idetablissement'] = widget.idetablissement;
      formData['updated_at'] = DateTime.now().toIso8601String();

      // Sauvegarder localement
      final id = await _dbHelper.saveForm(formData);

      // Tenter de synchroniser immédiatement
      await _formService.syncFormsWithApi();

      setState(() => _isSubmitting = false);
      _showSuccessDialog();
    } catch (e) {
      setState(() => _isSubmitting = false);
      _showSuccessDialog(isOnline: false);
    }
  }

  void _showSuccessDialog({bool isOnline = true}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _buildSuccessDialog(isOnline),
    );
  }

  Widget _buildSuccessDialog(bool isOnline) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogHeader(),
            _buildSuccessIcon(),
            _buildSuccessTitle(isOnline),
            _buildSuccessMessage(isOnline),
            _buildOkButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogHeader() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(Icons.close, color: Colors.grey),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.BottomNavigationPageRoutes,
            ModalRoute.withName('/loginpage'),
          );
        },
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Icon(
      Icons.check_circle,
      color: Colors.green.shade600,
      size: 80,
    );
  }

  Widget _buildSuccessTitle(bool isOnline) {
    return Text(
      isOnline ? 'Succès!' : 'Sauvegardé localement',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSuccessMessage(bool isOnline) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        isOnline
            ? 'Le formulaire est enregistré avec succès!'
            : 'Le formulaire a été sauvegardé localement et sera synchronisé dès que possible.',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildOkButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.SavedFormsScreenRoutes);
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
    );
  }
}