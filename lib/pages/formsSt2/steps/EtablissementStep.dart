import 'package:flutter/material.dart';

class EtablissementStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const EtablissementStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  State<EtablissementStep> createState() => _EtablissementStepState();
}

class _EtablissementStepState extends State<EtablissementStep> {
  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  void _initializeFormData() {
    widget.formData['programmesOfficiels'] ??= 'Non';
    widget.formData['copa'] ??= 'Non';
    widget.formData['copaOperationnel'] ??= 'Non';
    widget.formData['coges'] ??= 'Non';
    widget.formData['cogesOperationnel'] ??= 'Non';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildSection(
                title: "Informations de base",
                children: [
                  _buildTextFormField(
                    label: 'Année',
                    initialValue: widget.formData['annee'],
                    onSaved: (value) => widget.formData['annee'] = value?.trim(),
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                    icon: Icons.calendar_today,
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    label: 'Etablissement',
                    initialValue: widget.formData['etablissement'],
                    onSaved: (value) => widget.formData['etablissement'] = value?.trim(),
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                    icon: Icons.school,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildSection(
                title: "Disponibilités",
                children: [
                  _buildInformationRadio('2.1. Des programmes officiels des cours ?', 'programmesOfficiels'),
                  _buildInformationRadio('2.2. D\'un COPA ?', 'copa'),
                  if (widget.formData['copa'] == 'Oui') ...[
                    _buildInformationRadio('2.3. Si oui, est-il opérationnel dans votre établissement ?', 'copaOperationnel'),
                    const SizedBox(height: 12),
                    _buildTextFormField(
                      label: '2.4. Le nombre de réunions tenues avec les PV l\'année passée',
                      initialValue: widget.formData['reunionsPV'],
                      onSaved: (value) => widget.formData['reunionsPV'] = value?.trim(),
                      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                      keyboardType: TextInputType.number,
                      icon: Icons.numbers,
                    ),
                    const SizedBox(height: 12),
                    _buildTextFormField(
                      label: '2.5. Nombre de femmes dans le COPA',
                      initialValue: widget.formData['femmesCOPA'],
                      onSaved: (value) => widget.formData['femmesCOPA'] = value?.trim(),
                      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                      keyboardType: TextInputType.number,
                      icon: Icons.people,
                    ),
                  ],
                  const SizedBox(height: 12),
                  _buildInformationRadio('2.6. D\'un COGES', 'coges'),
                  if (widget.formData['coges'] == 'Oui') ...[
                    _buildInformationRadio('2.7. Si oui, le COGES est-il opérationnel dans votre école ?', 'cogesOperationnel'),
                    const SizedBox(height: 12),
                    _buildTextFormField(
                      label: '2.8. Nombre de réunions tenues avec le rapport de gestion l\'année précédente',
                      initialValue: widget.formData['reunionsRapport'],
                      onSaved: (value) => widget.formData['reunionsRapport'] = value?.trim(),
                      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                      keyboardType: TextInputType.number,
                      icon: Icons.meeting_room,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Étape de l\'établissement',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Veuillez fournir les informations pertinentes sur l\'établissement',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInformationRadio(String title, String key) {
    return InkWell(
      onTap: () {
        setState(() {
          // Toggle the value immediately
          widget.formData[key] = widget.formData[key] == 'Oui' ? 'Non' : 'Oui';
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                _buildCompactRadioOption(key, 'Oui'),
                const SizedBox(width: 6),
                _buildCompactRadioOption(key, 'Non'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactRadioOption(String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: widget.formData[key] == value
            ? (value == 'Oui' ? Colors.green.shade50 : Colors.red.shade50)
            : null,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: widget.formData[key] == value
              ? (value == 'Oui' ? Colors.green : Colors.red)
              : Colors.grey.shade400,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Radio<String>(
              value: value,
              groupValue: widget.formData[key],
              onChanged: (String? newValue) {
                setState(() {
                  widget.formData[key] = newValue!;
                });
              },
              activeColor: value == 'Oui' ? Colors.green : Colors.red,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: widget.formData[key] == value
                  ? (value == 'Oui' ? Colors.green : Colors.red)
                  : Colors.grey.shade700,
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
    IconData? icon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade700,
        ),
        prefixIcon: icon != null ? Icon(icon, size: 20, color: Colors.blue.shade600) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade600, width: 1.2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        isDense: true,
      ),
      style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
    );
  }
}