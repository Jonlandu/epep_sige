import 'package:flutter/material.dart';

class InfrastructureStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const InfrastructureStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  _InfrastructureStepState createState() => _InfrastructureStepState();
}

class _InfrastructureStepState extends State<InfrastructureStep> {
  bool isSecondEtablissement = false;
  bool isPointEau = false;
  bool isSourceEnergie = false;
  bool isLatrines = false;
  bool isCourRecreation = false;
  bool isTerrainSport = false;
  bool isCloture = false;
  bool isInternat = false;
  bool isPrisEnChargeRefugie = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '2. INFRASTRUCTURES ET ÉQUIPEMENTS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // 2.9. Nombre de femmes dans le COGES
            _buildTextFormField(
              label: '2.9. Nombre de femmes dans le COGES',
              initialValue: widget.formData['femmesCoges']?.toString() ?? '',
              onSaved: (value) => widget.formData['femmesCoges'] = value,
              validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            ),
            const SizedBox(height: 15),

            // 2.10. Les locaux, sont-ils utilisés par un 2ème établissement
            Text(
              '2.10. Les locaux, sont-ils utilisés par un 2ème établissement',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'secondEtablissement',
              'Oui',
              'Non',
              onChanged: (value) {
                setState(() {
                  isSecondEtablissement = value == 'Oui';
                });
              },
            ),
            const SizedBox(height: 15),

            // 2.11. Si oui préciser le nom du 2eme établissement
            if (isSecondEtablissement) ...[
              _buildTextFormField(
                label: '2.11. Si oui préciser le nom du 2eme établissement',
                initialValue: widget.formData['nomSecondEtablissement']?.toString() ?? '',
                onSaved: (value) => widget.formData['nomSecondEtablissement'] = value,
                validator: isSecondEtablissement
                    ? (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null
                    : null,
              ),
              const SizedBox(height: 15),
            ],

            // 2.12. D'un point d'eau
            Text(
              '2.12. D\'un point d\'eau',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'pointEau',
              'Oui',
              'Non',
              onChanged: (value) {
                setState(() {
                  isPointEau = value == 'Oui';
                });
              },
            ),
            const SizedBox(height: 15),

            // 2.13. Si oui préciser le type
            if (isPointEau) ...[
              Text(
                '2.13. Si oui préciser le type en cochant la case appropriée',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              _buildCheckboxField('pointEauRobinet', 'Robinet'),
              _buildCheckboxField('pointEauForagePuits', 'Forage/puits'),
              _buildCheckboxField('pointEauSources', 'Sources'),
              const SizedBox(height: 15),
            ],

            // 2.14. Des sources d'énergie
            Text(
              '2.14. Des sources d\'énergie',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'sourceEnergie',
              'Oui',
              'Non',
              onChanged: (value) {
                setState(() {
                  isSourceEnergie = value == 'Oui';
                });
              },
            ),
            const SizedBox(height: 15),

            // 2.15. Si oui
            if (isSourceEnergie) ...[
              Text(
                '2.15. Si oui :',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              _buildCheckboxField('sourceEnergieElectrique', 'Énergie électrique'),
              _buildCheckboxField('sourceEnergieSolaire', 'Énergie solaire'),
              _buildCheckboxField('sourceEnergieGenerateur', 'Générateur'),
              const SizedBox(height: 15),
            ],

            // 2.16. Des latrines (W.C)
            Text(
              '2.16. Des latrines (W.C)',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'latrines',
              'Oui',
              'Non',
              onChanged: (value) {
                setState(() {
                  isLatrines = value == 'Oui';
                });
              },
            ),
            const SizedBox(height: 15),

            // 2.17. Si oui préciser le nombre de compartiments
            if (isLatrines) ...[
              _buildTextFormField(
                label: '2.17. Si oui préciser le nombre de compartiments',
                initialValue: widget.formData['nombreCompartiments']?.toString() ?? '',
                onSaved: (value) => widget.formData['nombreCompartiments'] = value,
                validator: isLatrines
                    ? (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null
                    : null,
              ),
              const SizedBox(height: 15),

              // 2.18. Dont pour les filles
              _buildTextFormField(
                label: '2.18. Dont pour les filles',
                initialValue: widget.formData['latrinesFilles']?.toString() ?? '',
                onSaved: (value) => widget.formData['latrinesFilles'] = value,
                validator: isLatrines
                    ? (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null
                    : null,
              ),
              const SizedBox(height: 15),
            ],

            // 2.19. Une cour de récréation
            Text(
              '2.19. Une cour de récréation',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'courRecreation',
              'Oui',
              'Non',
              onChanged: (value) {
                setState(() {
                  isCourRecreation = value == 'Oui';
                });
              },
            ),
            const SizedBox(height: 15),

            // 2.20. Un terrain de sport
            Text(
              '2.20. Un terrain de sport',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'terrainSport',
              'Oui',
              'Non',
              onChanged: (value) {
                setState(() {
                  isTerrainSport = value == 'Oui';
                });
              },
            ),
            const SizedBox(height: 15),

            // 2.21. Une clôture
            Text(
              '2.21. Une clôture',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'cloture',
              'Oui',
              'Non',
              onChanged: (value) {
                setState(() {
                  isCloture = value == 'Oui';
                });
              },
            ),
            const SizedBox(height: 15),

            // 2.22. Si oui préciser la nature de la cloture
            if (isCloture) ...[
              Text(
                '2.22. Si oui préciser la nature de la cloture',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              _buildCheckboxField('clotureEnDur', 'En dur'),
              _buildCheckboxField('clotureSemiDur', 'En Semi-dur'),
              _buildCheckboxField('clotureHaie', 'En haie'),
              _buildCheckboxField('clotureAutres', 'Autres'),
              const SizedBox(height: 15),
            ],

            // 2.23. D'un Internat
            Text(
              '2.23. D\'un Internat',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'internat',
              'Oui',
              'Non',
              onChanged: (value) {
                setState(() {
                  isInternat = value == 'Oui';
                });
              },
            ),
            const SizedBox(height: 15),

            // 2.24. Est-il pris en charge par le programme de réfugié
            Text(
              '2.24. Est-il pris en charge par le programme de réfugié',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'prisEnChargeRefugie',
              'Oui',
              'Non',
              onChanged: (value) {
                setState(() {
                  isPrisEnChargeRefugie = value == 'Oui';
                });
              },
            ),
            const SizedBox(height: 15),

            // 2.25. Si oui par quel organisme
            if (isPrisEnChargeRefugie) ...[
              _buildTextFormField(
                label: '2.25. Si oui par quel organisme',
                initialValue: widget.formData['organismePrisEnCharge']?.toString() ?? '',
                onSaved: (value) => widget.formData['organismePrisEnCharge'] = value,
                validator: isPrisEnChargeRefugie
                    ? (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null
                    : null,
              ),
              const SizedBox(height: 15),
            ],

            // 2.26. Projet d'établissement
            Text(
              '2.26. Votre Établissement a-t-il développé un projet d\'établissement avec toutes les parties prenantes ?',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'projetEtablissement',
              'Oui',
              'Non',
            ),
            const SizedBox(height: 15),

            // 2.27. Documents budgétaires et comptables
            Text(
              '2.27. Votre Établissement dispose-t-il des prévisions budgétaires et des documents comptables ?',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'documentsBudgetaires',
              'Oui',
              'Non',
            ),
            const SizedBox(height: 15),

            // 2.28. Plan d'action opérationnel
            Text(
              '2.28. Votre Etablissement dispose-t-il d\'un plan d\'action opérationnel ?',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'planActionOperationnel',
              'Oui',
              'Non',
            ),
            const SizedBox(height: 15),

            // 2.29. Tableau de Bord
            Text(
              '2.29. Votre Etablissement a-t-il élaboré un Tableau de Bord ?',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'tableauBord',
              'Oui',
              'Non',
            ),
            const SizedBox(height: 15),

            // 2.30. Revue Annuelle de Performance
            Text(
              '2.30. Votre Etablissement a-t-il organisé une Revue Annuelle de Performance (RAP) ?',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            _buildYesNoField(
              'revueAnnuellePerformance',
              'Oui',
              'Non',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String? initialValue,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      initialValue: initialValue ?? '',
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }

  Widget _buildYesNoField(
      String groupKey,
      String yesValue,
      String noValue, {
        ValueChanged<String?>? onChanged,
      }) {
    return Row(
      children: [
        Radio<String>(
          value: yesValue,
          groupValue: widget.formData[groupKey]?.toString(),
          onChanged: (String? value) {
            setState(() {
              widget.formData[groupKey] = value;
            });
            if (onChanged != null) onChanged(value);
          },
        ),
        Text(yesValue),
        SizedBox(width: 20),
        Radio<String>(
          value: noValue,
          groupValue: widget.formData[groupKey]?.toString(),
          onChanged: (String? value) {
            setState(() {
              widget.formData[groupKey] = value;
            });
            if (onChanged != null) onChanged(value);
          },
        ),
        Text(noValue),
      ],
    );
  }

  Widget _buildCheckboxField(String key, String label) {
    return Row(
      children: [
        Checkbox(
          value: widget.formData[key] ?? false,
          onChanged: (bool? value) {
            setState(() {
              widget.formData[key] = value ?? false;
            });
          },
        ),
        Text(label),
      ],
    );
  }
}