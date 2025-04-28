import 'package:flutter/material.dart';

class FormationDataForm extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const FormationDataForm({
    Key? key,
    required this.formData,
    required this.formKey,
  }) : super(key: key);

  @override
  _FormationDataFormState createState() => _FormationDataFormState();
}

class _FormationDataFormState extends State<FormationDataForm> {
  int _currentStep = 0;
  late Map<String, dynamic> _formData;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _formData = Map<String, dynamic>.from(widget.formData);
    // Initialize form data structure with proper list initialization
    _formData['trainingTime'] = <String, dynamic>{};
    _formData['teachingStaff'] = List<Map<String, dynamic>>.generate(
        2,
            (_) => <String, dynamic>{}
    );
    _formData['adminStaff'] = List<Map<String, dynamic>>.generate(
        2,
            (_) => <String, dynamic>{}
    );
    _formData['secondaryTeachers'] = <String, dynamic>{};
    _formData['adminDistribution'] = <String, dynamic>{};
    _formData['retraite_eligible'] = '0';
    _formData['non_payes'] = '0';
  }

  // Helper method to safely access staff data
  Map<String, dynamic> _getStaffData(String staffType, int index) {
    if (_formData[staffType] == null ||
        (_formData[staffType] as List).length <= index - 1) {
      return <String, dynamic>{};
    }
    return Map<String, dynamic>.from(_formData[staffType][index - 1] ?? {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: Stepper(
          currentStep: _currentStep,
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  if (_currentStep != 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Précédent'),
                      ),
                    ),
                  if (_currentStep != 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.formKey.currentState!.validate()) {
                          details.onStepContinue!();
                        }
                      },
                      child: Text(
                        _currentStep == 4 ? 'Terminer' : 'Suivant',
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          onStepContinue: () {
            if (_currentStep < 4) {
              setState(() => _currentStep += 1);
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep -= 1);
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          },
          steps: [
            _buildTrainingTimeStep(),
            _buildTeachingStaffStep(),
            _buildAdminStaffStep(),
            _buildSecondaryTeachersStep(),
            _buildAdminDistributionStep(),
          ],
        ),
      ),
    );
  }

  // ============ Temps de Formation ============
  Step _buildTrainingTimeStep() {
    return Step(
      title: const Text('Temps de Formation'),
      content: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '6. Répartition de Temps de Formation par Filière',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildTrainingTimeForm(1),
            const SizedBox(height: 20),
            _buildTrainingTimeForm(2),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainingTimeForm(int index) {
    final key = 'filiere_$index';
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filière $index', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nom de la filière',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              initialValue: _formData['trainingTime'][key]?['nom']?.toString() ?? '',
              onSaved: (value) {
                _formData['trainingTime'][key] ??= {};
                _formData['trainingTime'][key]['nom'] = value;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Théorique (h)',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: _formData['trainingTime'][key]?['theorique']?.toString() ?? '',
                    onSaved: (value) {
                      _formData['trainingTime'][key] ??= {};
                      _formData['trainingTime'][key]['theorique'] = value;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Pratique (h)',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: _formData['trainingTime'][key]?['pratique']?.toString() ?? '',
                    onSaved: (value) {
                      _formData['trainingTime'][key] ??= {};
                      _formData['trainingTime'][key]['pratique'] = value;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Stage (h)',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: _formData['trainingTime'][key]?['stage']?.toString() ?? '',
                    onSaved: (value) {
                      _formData['trainingTime'][key] ??= {};
                      _formData['trainingTime'][key]['stage'] = value;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Total (h)',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: _formData['trainingTime'][key]?['total']?.toString() ?? '',
                    onSaved: (value) {
                      _formData['trainingTime'][key] ??= {};
                      _formData['trainingTime'][key]['total'] = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============ Personnel Enseignant ============
  Step _buildTeachingStaffStep() {
    return Step(
      title: const Text('Personnel Enseignant'),
      content: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '7. Informations Relatives au Personnel Enseignant',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildStaffForm('teachingStaff', 1),
            const SizedBox(height: 20),
            _buildStaffForm('teachingStaff', 2),
          ],
        ),
      ),
    );
  }

  // ============ Personnel Administratif ============
  Step _buildAdminStaffStep() {
    return Step(
      title: const Text('Personnel Administratif'),
      content: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '8. Répartition du personnel administratif',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildStaffForm('adminStaff', 1),
            const SizedBox(height: 20),
            _buildStaffForm('adminStaff', 2),
          ],
        ),
      ),
    );
  }

  // Generic staff form builder for both teaching and admin staff
  Widget _buildStaffForm(String staffType, int index) {
    final staffData = _getStaffData(staffType, index);
    final title = staffType == 'teachingStaff' ? 'Enseignant $index' : 'Personnel administratif $index';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nom et prénom',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              initialValue: staffData['nom']?.toString() ?? '',
              onSaved: (value) {
                _ensureStaffList(staffType, index);
                _formData[staffType][index - 1]['nom'] = value;
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Sexe',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              value: staffData['sexe']?.toString() ?? 'H',
              items: const [
                DropdownMenuItem(value: 'H', child: Text('Homme')),
                DropdownMenuItem(value: 'F', child: Text('Femme')),
              ],
              onChanged: (value) {
                setState(() {
                  _ensureStaffList(staffType, index);
                  _formData[staffType][index - 1]['sexe'] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Année de naissance',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              keyboardType: TextInputType.number,
              initialValue: staffData['annee_naissance']?.toString() ?? '',
              onSaved: (value) {
                _ensureStaffList(staffType, index);
                _formData[staffType][index - 1]['annee_naissance'] = value;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'N° Matricule (SECOPE)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              initialValue: staffData['matricule']?.toString() ?? '',
              onSaved: (value) {
                _ensureStaffList(staffType, index);
                _formData[staffType][index - 1]['matricule'] = value;
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Situation Salariale',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              value: staffData['situation']?.toString() ?? 'Payé',
              items: const [
                DropdownMenuItem(value: 'Payé', child: Text('Payé')),
                DropdownMenuItem(value: 'Non Payé', child: Text('Non Payé')),
              ],
              onChanged: (value) {
                setState(() {
                  _ensureStaffList(staffType, index);
                  _formData[staffType][index - 1]['situation'] = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Année d\'engagement',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              keyboardType: TextInputType.number,
              initialValue: staffData['annee_engagement']?.toString() ?? '',
              onSaved: (value) {
                _ensureStaffList(staffType, index);
                _formData[staffType][index - 1]['annee_engagement'] = value;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Qualification',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              initialValue: staffData['qualification']?.toString() ?? '',
              onSaved: (value) {
                _ensureStaffList(staffType, index);
                _formData[staffType][index - 1]['qualification'] = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  // Ensure the staff list has enough elements
  void _ensureStaffList(String staffType, int index) {
    if (_formData[staffType] == null) {
      _formData[staffType] = [];
    }
    while (_formData[staffType].length < index) {
      _formData[staffType].add({});
    }
  }

  // ============ Enseignants Secondaires ============
  Step _buildSecondaryTeachersStep() {
    return Step(
      title: const Text('Enseignants Secondaires'),
      content: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '9. Enseignants Secondaires',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildSecondaryTeachersForm(1),
            const SizedBox(height: 20),
            _buildSecondaryTeachersForm(2),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryTeachersForm(int index) {
    final key = 'secondaire_$index';
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filière secondaire $index',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nom de la filière',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              initialValue: _formData['secondaryTeachers'][key]?['nom']?.toString() ?? '',
              onSaved: (value) {
                _formData['secondaryTeachers'][key] ??= {};
                _formData['secondaryTeachers'][key]['nom'] = value;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Hommes',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: _formData['secondaryTeachers'][key]?['hommes']?.toString() ?? '',
                    onSaved: (value) {
                      _formData['secondaryTeachers'][key] ??= {};
                      _formData['secondaryTeachers'][key]['hommes'] = value;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Femmes',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: _formData['secondaryTeachers'][key]?['femmes']?.toString() ?? '',
                    onSaved: (value) {
                      _formData['secondaryTeachers'][key] ??= {};
                      _formData['secondaryTeachers'][key]['femmes'] = value;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Total',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              keyboardType: TextInputType.number,
              initialValue: _formData['secondaryTeachers'][key]?['total']?.toString() ?? '',
              onSaved: (value) {
                _formData['secondaryTeachers'][key] ??= {};
                _formData['secondaryTeachers'][key]['total'] = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============ Répartition Administrative ============
  Step _buildAdminDistributionStep() {
    return Step(
      title: const Text('Répartition Administrative'),
      content: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '10. Répartition du Personnel administratif',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildAdminDistributionSection(),
            const SizedBox(height: 20),
            _buildRetirementAndPaymentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminDistributionSection() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Par fonction et sexe selon la qualification',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildQualificationInput('D6'),
            const SizedBox(height: 15),
            _buildQualificationInput('P6'),
            const SizedBox(height: 15),
            _buildQualificationInput('A1'),
            const SizedBox(height: 15),
            _buildQualificationInput('G3'),
            const SizedBox(height: 15),
            _buildQualificationInput('L2'),
            const SizedBox(height: 15),
            _buildQualificationInput('LA'),
            const SizedBox(height: 15),
            _buildQualificationInput('IR'),
            const SizedBox(height: 15),
            _buildQualificationInput('DR'),
            const SizedBox(height: 15),
            _buildQualificationInput('Autres'),
          ],
        ),
      ),
    );
  }

  Widget _buildQualificationInput(String qualification) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(qualification, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildFunctionInput(qualification, 'Préfet des Études', 'Prefet'),
        const SizedBox(height: 10),
        _buildFunctionInput(qualification, 'Directeur des Études', 'DirecteurEtudes'),
        const SizedBox(height: 10),
        _buildFunctionInput(qualification, 'Directeur des Disciplines', 'DirecteurDisciplines'),
        const SizedBox(height: 10),
        _buildFunctionInput(qualification, 'Conseiller Pédagogique', 'Conseiller'),
        const SizedBox(height: 10),
        _buildFunctionInput(qualification, 'Surveillant', 'Surveillant'),
        const SizedBox(height: 10),
        _buildFunctionInput(qualification, 'Ouvrier et Autres', 'Ouvrier'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Total Hommes',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                keyboardType: TextInputType.number,
                initialValue: _formData['adminDistribution']['${qualification}_total_H']?.toString() ?? '0',
                onSaved: (value) {
                  _formData['adminDistribution']['${qualification}_total_H'] = value ?? '0';
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Total Femmes',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                keyboardType: TextInputType.number,
                initialValue: _formData['adminDistribution']['${qualification}_total_F']?.toString() ?? '0',
                onSaved: (value) {
                  _formData['adminDistribution']['${qualification}_total_F'] = value ?? '0';
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFunctionInput(String qualification, String label, String functionKey) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: const TextStyle(fontSize: 14)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'H',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
            keyboardType: TextInputType.number,
            initialValue: _formData['adminDistribution']['${qualification}_${functionKey}_H']?.toString() ?? '0',
            onSaved: (value) {
              _formData['adminDistribution']['${qualification}_${functionKey}_H'] = value ?? '0';
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'F',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
            keyboardType: TextInputType.number,
            initialValue: _formData['adminDistribution']['${qualification}_${functionKey}_F']?.toString() ?? '0',
            onSaved: (value) {
              _formData['adminDistribution']['${qualification}_${functionKey}_F'] = value ?? '0';
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRetirementAndPaymentSection() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Statistiques enseignants',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enseignants éligibles à la retraite (65 ans et plus)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              keyboardType: TextInputType.number,
              initialValue: _formData['retraite_eligible']?.toString() ?? '0',
              onSaved: (value) {
                _formData['retraite_eligible'] = value ?? '0';
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enseignants non payés (salaire de base)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              keyboardType: TextInputType.number,
              initialValue: _formData['non_payes']?.toString() ?? '0',
              onSaved: (value) {
                _formData['non_payes'] = value ?? '0';
              },
            ),
          ],
        ),
      ),
    );
  }
}