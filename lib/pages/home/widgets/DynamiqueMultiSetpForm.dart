import 'package:flutter/material.dart';

class DynamiqueMultiSetpForm extends StatefulWidget {
  const DynamiqueMultiSetpForm({super.key});

  @override
  State<DynamiqueMultiSetpForm> createState() => _DynamiqueMultiSetpFormState();
}

class _DynamiqueMultiSetpFormState extends State<DynamiqueMultiSetpForm> {
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
    final double itemWidth = 140.0;
    final double scrollOffset = _currentStep * itemWidth - (MediaQuery.of(context).size.width / 2 - itemWidth / 2);
    _scrollController.animateTo(
      scrollOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
    );
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
              borderSide: BorderSide(color: Colors.grey.shade400),
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
            // Barre de progression horizontale améliorée
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
      case 0: return _buildLocationStep();
      case 1: return _buildIdentificationStep();
      case 2: return _buildTypeStep();
      case 3: return _buildCapacityStep();
      case 4: return _buildStaffingStep();
      case 5: return _buildContactStep();
      case 6: return _buildHistoryStep();
      case 7: return _buildValidationStep();
      default: return Container();
    }
  }

  Widget _buildLocationStep() {
    return Form(
      key: _stepFormKeys[0],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Localisation de l\'établissement',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Renseignez les informations géographiques',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _buildDropdownFormField(
            label: 'Province *',
            value: formData['province'],
            items: ['KONGO-CENTRAL', 'Kinshasa', 'Katanga'],
            onChanged: (value) => formData['province'] = value,
            icon: Icons.map_outlined,
          ),
          const SizedBox(height: 20),
          _buildDropdownFormField(
            label: 'Proved *',
            value: formData['proved'],
            items: ['KONGO-CENTRAL I', 'KONGO-CENTRAL II', 'KONGO-CENTRAL III'],
            onChanged: (value) => formData['proved'] = value,
            icon: Icons.location_city_outlined,
          ),
          const SizedBox(height: 20),
          _buildDropdownFormField(
            label: 'Sous-Proved *',
            value: formData['sousProved'],
            items: ['MATADI 1', 'MATADI 2', 'MATADI 3'],
            onChanged: (value) => formData['sousProved'] = value,
            icon: Icons.place_outlined,
          ),
          const SizedBox(height: 20),
          _buildTextFormField(
            label: 'Centre de regroupement *',
            initialValue: formData['centreRegroupement'],
            onSaved: (value) => formData['centreRegroupement'] = value,
            validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            icon: Icons.group_work_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildIdentificationStep() {
    return Form(
      key: _stepFormKeys[1],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Identification de l\'établissement',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Renseignez les informations principales',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _buildTextFormField(
            label: 'Nom de l\'établissement *',
            initialValue: formData['nomEtablissement'],
            onSaved: (value) => formData['nomEtablissement'] = value,
            validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            icon: Icons.school_outlined,
          ),
          const SizedBox(height: 20),
          _buildTextFormField(
            label: 'Code de l\'établissement',
            initialValue: formData['codeEtablissement'],
            onSaved: (value) => formData['codeEtablissement'] = value,
            icon: Icons.code_outlined,
          ),
          const SizedBox(height: 20),
          _buildTextFormField(
            label: 'Nom du chef d\'établissement *',
            initialValue: formData['nomChefEtablissement'],
            onSaved: (value) => formData['nomChefEtablissement'] = value,
            validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            icon: Icons.person_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildTypeStep() {
    return Form(
      key: _stepFormKeys[2],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Type d\'établissement',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Définissez les caractéristiques principales',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _buildDropdownFormField(
            label: 'Type d\'établissement *',
            value: formData['typeEtablissement'],
            items: ['Public', 'Privé', 'Confessionnel', 'Conventionné'],
            onChanged: (value) => formData['typeEtablissement'] = value,
            icon: Icons.category_outlined,
          ),
          const SizedBox(height: 24),
          Text(
            'Niveaux d\'enseignement *',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['Primaire', 'Secondaire', 'Maternel', 'Professionnel'].map((niveau) {
              return FilterChip(
                label: Text(niveau),
                selected: formData['niveauxEnseignement'].contains(niveau),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      formData['niveauxEnseignement'].add(niveau);
                    } else {
                      formData['niveauxEnseignement'].remove(niveau);
                    }
                  });
                },
                selectedColor: Colors.orange.withOpacity(0.2),
                checkmarkColor: Colors.orange,
                labelStyle: TextStyle(
                  color: formData['niveauxEnseignement'].contains(niveau)
                      ? Colors.orange.shade800
                      : Colors.grey.shade700,
                ),
                backgroundColor: Colors.grey.shade100,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: formData['niveauxEnseignement'].contains(niveau)
                        ? Colors.orange
                        : Colors.grey.shade300,
                  ),
                ),
              );
            }).toList(),
          ),
          if (formData['niveauxEnseignement'].isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Sélectionnez au moins un niveau',
                style: TextStyle(color: Colors.red.shade600, fontSize: 13),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCapacityStep() {
    return Form(
      key: _stepFormKeys[3],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Capacité d\'accueil',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Indiquez la capacité de l\'établissement',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _buildTextFormField(
            label: 'Capacité d\'accueil *',
            initialValue: formData['capaciteAccueil'],
            keyboardType: TextInputType.number,
            onSaved: (value) => formData['capaciteAccueil'] = value,
            validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            icon: Icons.people_alt_outlined,
            suffixText: 'élèves',
          ),
        ],
      ),
    );
  }

  Widget _buildStaffingStep() {
    return Form(
      key: _stepFormKeys[4],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Effectifs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Renseignez les nombres d\'élèves et enseignants',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildTextFormField(
                  label: 'Nombre d\'élèves *',
                  initialValue: formData['nombreEleves'],
                  keyboardType: TextInputType.number,
                  onSaved: (value) => formData['nombreEleves'] = value,
                  validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                  icon: Icons.school_outlined,
                  suffixText: 'élèves',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextFormField(
                  label: 'Nombre d\'enseignants *',
                  initialValue: formData['nombreEnseignants'],
                  keyboardType: TextInputType.number,
                  onSaved: (value) => formData['nombreEnseignants'] = value,
                  validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                  icon: Icons.person_outline,
                  suffixText: 'enseignants',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactStep() {
    return Form(
      key: _stepFormKeys[5],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Coordonnées',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Comment contacter l\'établissement',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _buildTextFormField(
            label: 'Adresse complète *',
            initialValue: formData['adresse'],
            maxLines: 2,
            onSaved: (value) => formData['adresse'] = value,
            validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            icon: Icons.home_outlined,
          ),
          const SizedBox(height: 20),
          _buildTextFormField(
            label: 'Téléphone *',
            initialValue: formData['telephone'],
            keyboardType: TextInputType.phone,
            onSaved: (value) => formData['telephone'] = value,
            validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 20),
          _buildTextFormField(
            label: 'Email',
            initialValue: formData['email'],
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) => formData['email'] = value,
            validator: (value) {
              if (value?.isNotEmpty ?? false) {
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                  return 'Email invalide';
                }
              }
              return null;
            },
            icon: Icons.email_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryStep() {
    return Form(
      key: _stepFormKeys[6],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Historique',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Informations sur la création et les infrastructures',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _buildTextFormField(
            label: 'Année de création',
            initialValue: formData['anneeCreation'],
            keyboardType: TextInputType.number,
            onSaved: (value) => formData['anneeCreation'] = value,
            icon: Icons.calendar_today_outlined,
          ),
          const SizedBox(height: 24),
          Text(
            'Infrastructures disponibles',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 3.5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: ['Bibliothèque', 'Laboratoire', 'Terrain de sport', 'Cantine', 'Salle informatique']
                .map((infra) {
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: formData['infrastructures'].contains(infra)
                        ? Colors.indigo
                        : Colors.grey.shade300,
                  ),
                ),
                color: formData['infrastructures'].contains(infra)
                    ? Colors.indigo.withOpacity(0.05)
                    : Colors.grey.shade50,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    setState(() {
                      if (formData['infrastructures'].contains(infra)) {
                        formData['infrastructures'].remove(infra);
                      } else {
                        formData['infrastructures'].add(infra);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Checkbox(
                          value: formData['infrastructures'].contains(infra),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                formData['infrastructures'].add(infra);
                              } else {
                                formData['infrastructures'].remove(infra);
                              }
                            });
                          },
                          activeColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Text(
                          infra,
                          style: TextStyle(
                            color: formData['infrastructures'].contains(infra)
                                ? Colors.indigo.shade800
                                : Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationStep() {
    return Form(
      key: _stepFormKeys[7],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Validation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vérifiez les informations avant soumission',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSummaryItem('Province', formData['province']),
                  _buildSummaryItem('Proved', formData['proved']),
                  _buildSummaryItem('Sous-Proved', formData['sousProved']),
                  _buildSummaryItem('Centre de regroupement', formData['centreRegroupement']),
                  _buildSummaryItem('Nom établissement', formData['nomEtablissement']),
                  _buildSummaryItem('Chef établissement', formData['nomChefEtablissement']),
                  _buildSummaryItem('Type', formData['typeEtablissement']),
                  _buildSummaryItem('Niveaux', formData['niveauxEnseignement'].join(', ')),
                  _buildSummaryItem('Capacité', formData['capaciteAccueil']),
                  _buildSummaryItem('Nombre d\'élèves', formData['nombreEleves']),
                  _buildSummaryItem('Nombre d\'enseignants', formData['nombreEnseignants']),
                  _buildSummaryItem('Adresse', formData['adresse']),
                  _buildSummaryItem('Téléphone', formData['telephone']),
                  _buildSummaryItem('Email', formData['email']),
                  _buildSummaryItem('Année de création', formData['anneeCreation']),
                  _buildSummaryItem('Infrastructures', formData['infrastructures'].join(', ')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 0,
            color: Colors.red.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: formData['validation'] ? Colors.green : Colors.red.shade300,
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CheckboxListTile(
                title: const Text(
                  'Je certifie que les informations fournies sont exactes',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                value: formData['validation'] as bool,
                onChanged: (bool? value) {
                  setState(() {
                    formData['validation'] = value ?? false;
                  });
                },
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.green,
                checkColor: Colors.white,
              ),
            ),
          ),
          if (formData['validation'] == false)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Vous devez accepter cette déclaration pour soumettre',
                style: TextStyle(color: Colors.red.shade600),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String? initialValue,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
    int? maxLines,
    IconData? icon,
    String? suffixText,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade600) : null,
        suffixText: suffixText,
        suffixStyle: TextStyle(color: Colors.grey.shade600),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onSaved: onSaved,
    );
  }

  Widget _buildDropdownFormField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    IconData? icon,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade600) : null,
      ),
      items: items
          .map((item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      ))
          .toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Champ obligatoire' : null,
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
    );
  }

  Widget _buildSummaryItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value ?? 'Non renseigné',
              style: TextStyle(
                color: value?.isEmpty ?? true ? Colors.grey : Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
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