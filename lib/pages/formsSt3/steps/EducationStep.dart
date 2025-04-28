import 'package:flutter/material.dart';

class EducationStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const EducationStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  State<EducationStep> createState() => _EducationStepState();
}

class _EducationStepState extends State<EducationStep> {
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
              _buildHeader("Étape 4 - Personnel éducatif"),
              const SizedBox(height: 12),

              _buildSection(
                title: "Personnel enseignant",
                children: [
                  _buildTextFormField(
                    label: '2.31. Nombre d\'enseignants qui ont reçu une formation durant les 12 derniers mois',
                    initialValue: widget.formData['enseignantsFormation12mois'],
                    onSaved: (value) => widget.formData['enseignantsFormation12mois'] = value,
                    keyboardType: TextInputType.number,
                    icon: Icons.people,
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    label: '2.32. Nombre d\'enseignants cotés positivement (E, TB, B)',
                    initialValue: widget.formData['enseignantsCotesPositivement'],
                    onSaved: (value) => widget.formData['enseignantsCotesPositivement'] = value,
                    keyboardType: TextInputType.number,
                    icon: Icons.star,
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    label: '2.33. Nombre d\'enseignants ayant reçu une inspection pédagogique C3',
                    initialValue: widget.formData['enseignantsInspectionC3'],
                    onSaved: (value) => widget.formData['enseignantsInspectionC3'] = value,
                    keyboardType: TextInputType.number,
                    icon: Icons.checklist,
                  ),
                  const SizedBox(height: 12),
                  _buildInformationRadio(
                    '2.34. Le Chef d\'Établissement a-t-il reçu une formation continue durant 12 derniers mois ?',
                    'chefFormationContinue',
                  ),
                  const SizedBox(height: 12),
                  _buildInformationRadio(
                    '2.35. Le Chef d\'Établissement a-t-il été coté Positivement ? (Réservé au S/PROVED)',
                    'chefCotePositivement',
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _buildHeader("Activités et structures"),
              const SizedBox(height: 12),

              _buildSection(
                title: "Activités et structures éducatives",
                children: [
                  _buildInformationRadio(
                    '2.36. Votre Établissement a-t-il organisé les activités parascolaires au cours de cette année scolaire ?',
                    'activitesParascolaires',
                  ),
                  const SizedBox(height: 12),
                  _buildInformationRadio(
                    '2.37. Votre Établissement dispose-t-il d\'une Unité Pédagogique (UP) opérationnelle ?',
                    'unitePedagogique',
                  ),
                  const SizedBox(height: 12),
                  _buildInformationRadio(
                    '2.38. Existe-t-il un Gouvernement d\'Élèves opérationnel dans votre Établissement ?',
                    'gouvernementEleves',
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    label: '2.39. Si oui, présentez les PV de réunions (à vérifier par le PVD et le Directeur)',
                    initialValue: widget.formData['pvReunions'],
                    onSaved: (value) => widget.formData['pvReunions'] = value,
                    icon: Icons.description,
                  ),
                  const SizedBox(height: 12),
                  _buildInformationRadio(
                    '2.40. Votre Établissement dispose-t-il d\'un manuel de procédure pour la gestion des Ressources Financières, Matérielles et autres ?',
                    'manuelProcedure',
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _buildHeader("Étape 5 - Communication et environnement"),
              const SizedBox(height: 12),

              _buildSection(
                title: "Communication et réseaux",
                children: [
                  _buildInformationRadio(
                    '2.41. Votre Établissement dispose-t-il d\'un plan de communication ?',
                    'planCommunication',
                  ),
                  const SizedBox(height: 12),
                  _buildInformationRadio(
                    '2.42. Votre Établissement participe-t-il aux forums d\'échanges en Réseau d\'Écoles de Proximité (REP) ?',
                    'participationREP',
                  ),
                  const SizedBox(height: 12),
                  _buildInformationRadio(
                    '2.43. Existe-t-il des Réseaux Locaux de Directeurs (RLD) opérationnel dans votre secteur ?',
                    'reseauDirecteurs',
                  ),
                  const SizedBox(height: 12),
                  _buildInformationRadio(
                    '2.44. Le Chef d\'Établissement a-t-il pris part au Réseau Local des Directeurs (RLD) ?',
                    'participationRLD',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _buildSection(
                title: "Environnement et genre",
                children: [
                  _buildInformationRadio(
                    '2.45. Votre Établissement dispose-t-il des arbres ?',
                    'arbresDisponibles',
                  ),
                  if (widget.formData['arbresDisponibles'] == 'Oui') ...[
                    const SizedBox(height: 12),
                    _buildTextFormField(
                      label: '2.46. Nombre d\'arbres plantés par votre Établissement cette année',
                      initialValue: widget.formData['arbresPlantes'],
                      onSaved: (value) => widget.formData['arbresPlantes'] = value,
                      keyboardType: TextInputType.number,
                      icon: Icons.nature,
                    ),
                  ],
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    label: '2.47. Nombre d\'enseignants qui ont été formés sur l\'administration de 1er soin',
                    initialValue: widget.formData['enseignantsPremiersSoins'],
                    onSaved: (value) => widget.formData['enseignantsPremiersSoins'] = value,
                    keyboardType: TextInputType.number,
                    icon: Icons.medical_services,
                  ),
                  const SizedBox(height: 12),
                  _buildInformationRadio(
                    '2.48. Votre Établissement dispose-t-il des coins de gestion de déchets (poubelles) ?',
                    'coinsDechets',
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    label: '2.49. Nombre de femmes enseignantes recrutées cette année',
                    initialValue: widget.formData['femmesEnseignantesRecrutees'],
                    onSaved: (value) => widget.formData['femmesEnseignantesRecrutees'] = value,
                    keyboardType: TextInputType.number,
                    icon: Icons.female,
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    label: '2.50. Nombre d\'enseignants qui ont suivi une formation sur la pédagogie sensible au genre',
                    initialValue: widget.formData['enseignantsFormationGenre'],
                    onSaved: (value) => widget.formData['enseignantsFormationGenre'] = value,
                    keyboardType: TextInputType.number,
                    icon: Icons.school,
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _buildHeader("Étape 6 - Enfants victimes de violences"),
              const SizedBox(height: 12),

              _buildSection(
                title: "Formulaire d'enfants victimes",
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      '2.51. Veuillez remplir les champs (*) obligatoires :',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  _buildViolenceTable(),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViolenceTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade800),
          children: [
            _buildTableHeaderCell('Forme de violence'),
            _buildTableHeaderCell('G'),
            _buildTableHeaderCell('F'),
            _buildTableHeaderCell('G+F'),
          ],
        ),
        _buildViolenceTableRow('Intimidation', 'intimidation'),
        _buildViolenceTableRow('Châtiment corporel', 'chatiment'),
        _buildViolenceTableRow('Harcèlement', 'harcelement'),
        _buildViolenceTableRow('Discrimination', 'discrimination'),
        _buildViolenceTableRow('Abus sexuels', 'abusSexuels'),
        _buildViolenceTableRow('Autres', 'autresViolences'),
      ],
    );
  }

  TableRow _buildViolenceTableRow(String label, String keyPrefix) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        _buildTableNumberInput('${keyPrefix}G'),
        _buildTableNumberInput('${keyPrefix}F'),
        _buildTableNumberInput('${keyPrefix}GF'),
      ],
    );
  }

  Widget _buildTableNumberInput(String key) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        initialValue: widget.formData[key]?.toString() ?? '0',
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          isDense: true,
        ),
        onSaved: (value) => widget.formData[key] = value,
      ),
    );
  }

  Widget _buildTableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // [Les autres méthodes (_buildHeader, _buildSection, _buildInformationRadio, etc.) restent inchangées]
  // ... [Conservez toutes les autres méthodes existantes] ...

  Widget _buildHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Veuillez fournir les informations pertinentes',
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
    TextInputType? keyboardType,
    IconData? icon,
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
      onSaved: onSaved,
      keyboardType: keyboardType,
    );
  }
}