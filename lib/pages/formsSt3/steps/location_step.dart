import 'package:flutter/material.dart';

class LocationStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const LocationStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  _LocationStepState createState() => _LocationStepState();
}

class _LocationStepState extends State<LocationStep> {
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
                title: "Disponibilité des structures",
                children: [
                  _buildInformationCheckBox('2.1. Des programmes officiels des cours ?', 'programmesOfficiels'),
                  _buildInformationCheckBox('2.2. D\'un COPA ?', 'copa'),
                  if (widget.formData['copa'] == 'Oui') ...[
                    _buildInformationCheckBox('2.3. Si oui, est-il opérationnel dans votre établissement ?', 'copaOperationnel'),
                    _buildTextFormField(
                      label: '2.4. Le nombre de réunions tenues avec les PV l\'année passée',
                      initialValue: widget.formData['reunionsPV'],
                      onSaved: (value) => widget.formData['reunionsPV'] = value,
                      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                      icon: Icons.meeting_room,
                    ),
                    _buildTextFormField(
                      label: '2.5. Nombre de femmes dans le COPA',
                      initialValue: widget.formData['femmesCOPA'],
                      onSaved: (value) => widget.formData['femmesCOPA'] = value,
                      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                      icon: Icons.people_alt,
                    ),
                  ],
                  _buildInformationCheckBox('2.6. D\'un COGES', 'coges'),
                  if (widget.formData['coges'] == 'Oui') ...[
                    _buildInformationCheckBox('2.7. Si oui, le COGES est-il opérationnel dans votre école ?', 'cogesOperationnel'),
                    _buildTextFormField(
                      label: '2.8. Donner Le nombre de réunions tenues avec le rapport de gestion l\'année précédente',
                      initialValue: widget.formData['reunionsRapportGestion'],
                      onSaved: (value) => widget.formData['reunionsRapportGestion'] = value,
                      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                      icon: Icons.assignment,
                    ),
                    _buildTextFormField(
                      label: '2.9. Nombre de femmes dans le COGES',
                      initialValue: widget.formData['femmesCOGES'],
                      onSaved: (value) => widget.formData['femmesCOGES'] = value,
                      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                      icon: Icons.woman,
                    ),
                  ],
                  _buildInformationCheckBox('2.10. Les locaux, sont-ils utilisés par un 2ème établissement', 'locauxUtilises'),
                  if (widget.formData['locauxUtilises'] == 'Oui') ...[
                    _buildTextFormField(
                      label: '2.11. Si oui préciser le nom du 2eme établissement',
                      initialValue: widget.formData['nomSecondEtablissement'],
                      onSaved: (value) => widget.formData['nomSecondEtablissement'] = value,
                      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                      icon: Icons.school,
                    ),
                  ],
                  _buildInformationCheckBox('2.12. D\'un point d\'eau', 'pointEau'),
                  if (widget.formData['pointEau'] == 'Oui') ...[
                    _buildCheckboxGroup(
                      title: '2.13. Si oui préciser le type',
                      options: {
                        'robinet': 'Robinet',
                        'foragePuits': 'Forage/puits',
                        'sources': 'Sources',
                      },
                      formDataKey: 'typePointEau',
                    ),
                  ],
                  _buildInformationCheckBox('2.14. Des sources d\'énergie', 'sourcesEnergie'),
                  if (widget.formData['sourcesEnergie'] == 'Oui') ...[
                    _buildCheckboxGroup(
                      title: '2.15. Si oui préciser le type',
                      options: {
                        'solaire': 'Solaire',
                        'electrique': 'Électrique',
                        'generateur': 'Générateur',
                      },
                      formDataKey: 'typeEnergie',
                    ),
                  ],
                  _buildInformationCheckBox('2.16. Des latrines (W.C)', 'latrines'),
                  if (widget.formData['latrines'] == 'Oui') ...[
                    _buildTextFormField(
                      label: '2.17. Si oui préciser le nombre de compartiments',
                      initialValue: widget.formData['compartimentsLatrines'],
                      onSaved: (value) => widget.formData['compartimentsLatrines'] = value,
                      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                      icon: Icons.wc,
                    ),
                    _buildTextFormField(
                      label: '2.18. Dont pour les filles',
                      initialValue: widget.formData['latrinesFilles'],
                      onSaved: (value) => widget.formData['latrinesFilles'] = value,
                      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                      icon: Icons.female,
                    ),
                  ],
                  _buildInformationCheckBox('2.19. Une cour de récréation', 'courRecreation'),
                  _buildInformationCheckBox('2.20. Un terrain de sport', 'terrainSport'),
                ],
              ),
              const SizedBox(height: 20),
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
          'Infrastructure et équipements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Renseignez les informations sur les infrastructures de l\'établissement',
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

  Widget _buildInformationCheckBox(String title, String key) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.formData[key] = widget.formData[key] == 'Oui' ? 'Non' : 'Oui';
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _buildCompactRadioOption(key, 'Oui'),
            const SizedBox(width: 6),
            _buildCompactRadioOption(key, 'Non'),
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
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
      ),
    );
  }

  Widget _buildCheckboxGroup({
    required String title,
    required Map<String, String> options,
    required String formDataKey,
  }) {
    // Initialize the form data if not already done
    if (widget.formData[formDataKey] == null) {
      widget.formData[formDataKey] = {};
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        ...options.entries.map((entry) {
          final key = entry.key;
          final label = entry.value;
          final isChecked = (widget.formData[formDataKey] as Map)[key] == true;

          return InkWell(
            onTap: () {
              setState(() {
                (widget.formData[formDataKey] as Map)[key] = !isChecked;
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isChecked ? Colors.blue.shade50 : null,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isChecked ? Colors.blue : Colors.grey.shade400,
                        width: 1,
                      ),
                    ),
                    child: isChecked
                        ? Icon(Icons.check, size: 16, color: Colors.blue.shade800)
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        const SizedBox(height: 8),
      ],
    );
  }
}