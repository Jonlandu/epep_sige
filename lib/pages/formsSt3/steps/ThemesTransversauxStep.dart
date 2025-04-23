import 'package:epsp_sige/pages/formsSt3/steps/ResponsiveThemesTable.dart';
import 'package:flutter/material.dart';

class ThemesTransversauxStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const ThemesTransversauxStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  State<ThemesTransversauxStep> createState() => _ThemesTransversauxStepState();
}

class _ThemesTransversauxStepState extends State<ThemesTransversauxStep> {
  final ScrollController _verticalController = ScrollController();

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void dispose() {
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        controller: _verticalController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("3. PRISE EN COMPTE DES THÈMES TRANSVERSAUX"),
              const SizedBox(height: 16),

              // Section 3.1 - Tableau optimisé
              _buildSectionSubtitle("3.1. Formulaire des thèmes transversaux"),
              const SizedBox(height: 8),
              Text(
                'Veuillez remplir les champs (*) obligatoires :',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
              ResponsiveThemesTable(formData: widget.formData),
              const SizedBox(height: 24),

              // Section 3.2 - Tableau optimisé
              _buildSectionSubtitle("3.2. Règlements et directives"),
              const SizedBox(height: 16),
              ResponsiveRegulationsTable(formData: widget.formData),
              const SizedBox(height: 24),

              // Section 3.3
              _buildSectionSubtitle("3.3. Cellule d'orientation EVF"),
              const SizedBox(height: 8),
              _buildYesNoField('celluleOrientationEVF'),
              const SizedBox(height: 16),

              // Section 3.4
              _buildSectionSubtitle("3.4. Enseignants formés EVF"),
              const SizedBox(height: 8),
              _buildYesNoField('enseignantsFormesEVF'),
              const SizedBox(height: 16),

              // Section 3.5 conditionnelle
              if (widget.formData['enseignantsFormesEVF'] == 'Oui') ...[
                _buildTextFormField(
                  label: '3.5. Nombre d\'enseignant-e-s formé-e-s',
                  key: 'nombreEnseignantsFormesEVF',
                ),
                const SizedBox(height: 16),
              ],

              // Section 3.6 - Tableau optimisé
              _buildSectionSubtitle("3.6. Enseignants dispensant le cours"),
              const SizedBox(height: 8),
              ResponsiveTeachingTable(formData: widget.formData),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade800,
      ),
    );
  }

  Widget _buildSectionSubtitle(String subtitle) {
    return Text(
      subtitle,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.blue.shade700,
      ),
    );
  }

  Widget _buildYesNoField(String key) {
    return Row(
      children: [
        _buildRadioOption(key, 'Oui'),
        const SizedBox(width: 20),
        _buildRadioOption(key, 'Non'),
      ],
    );
  }

  Widget _buildRadioOption(String key, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: widget.formData[key],
          onChanged: (newValue) => setState(() => widget.formData[key] = newValue),
        ),
        const SizedBox(width: 4),
        Text(value),
      ],
    );
  }

  Widget _buildTextFormField({required String label, required String key}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      initialValue: widget.formData[key]?.toString(),
      onSaved: (value) => widget.formData[key] = value,
      keyboardType: TextInputType.number,
    );
  }
}