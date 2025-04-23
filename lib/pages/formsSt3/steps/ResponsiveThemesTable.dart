import 'package:flutter/material.dart';

// Widget pour le tableau des thèmes
class ResponsiveThemesTable extends StatefulWidget {
  final Map<String, dynamic> formData;

  const ResponsiveThemesTable({super.key, required this.formData});

  @override
  State<ResponsiveThemesTable> createState() => _ResponsiveThemesTableState();
}

class _ResponsiveThemesTableState extends State<ResponsiveThemesTable> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: const ValueKey('themes_table_layout'),
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return _buildScrollableTable(_buildThemesTable());
        } else {
          return Column(
            key: const ValueKey('mobile_themes_column'),
            children: [
              _buildMobileThemeSection('VIH/Sida', 'vihSida'),
              const SizedBox(height: 16),
              _buildMobileThemeSection('Santé sexuelle', 'santeSexuelle'),
              const SizedBox(height: 16),
              _buildMobileThemeSection('Sensibilisation', 'sensibilisation'),
              const SizedBox(height: 16),
              _buildMobileThemeSection('Éducation environnementale', 'educationEnvironnementale'),
            ],
          );
        }
      },
    );
  }

  Widget _buildScrollableTable(Widget table) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: table,
      ),
    );
  }

  Widget _buildMobileThemeSection(String title, String keyPrefix) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _buildMobileCheckboxRow('Enseigné ?', '${keyPrefix}EnseigneOui', '${keyPrefix}EnseigneNon'),
            if (widget.formData['${keyPrefix}EnseigneOui'] == true) ...[
              const SizedBox(height: 8),
              _buildMobileCheckboxRow('Programme officiel', '${keyPrefix}ProgrammeOfficiel'),
              const SizedBox(height: 8),
              _buildMobileCheckboxRow('Discipline à part', '${keyPrefix}DisciplineApart'),
              const SizedBox(height: 8),
              _buildMobileCheckboxRow('Activités parascolaires', '${keyPrefix}ActivitesParascolaires'),
            ],
          ],
        ),
      ),
    );
  }

  TableRow _buildThemeRow(String theme, String keyPrefix) {
    final isTaught = widget.formData['${keyPrefix}EnseigneOui'] == true;

    return TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade50),
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(theme),
        ),
        _buildCheckbox('${keyPrefix}EnseigneOui'),
        _buildCheckbox('${keyPrefix}EnseigneNon'),
        if (isTaught) _buildCheckbox('${keyPrefix}ProgrammeOfficiel') else const SizedBox.shrink(),
        if (isTaught) _buildCheckbox('${keyPrefix}DisciplineApart') else const SizedBox.shrink(),
        if (isTaught) _buildCheckbox('${keyPrefix}ActivitesParascolaires') else const SizedBox.shrink(),
      ].where((widget) => widget != null).toList(),
    );
  }

  Widget _buildMobileCheckboxRow(String label, String key, [String? oppositeKey]) {
    return Row(
      children: [
        Expanded(
          child: Text(label),
        ),
        if (oppositeKey != null) ...[
          _buildMobileCheckbox('Oui', key, oppositeKey),
          const SizedBox(width: 16),
          _buildMobileCheckbox('Non', oppositeKey, key),
        ] else ...[
          Checkbox(
            value: widget.formData[key] ?? false,
            onChanged: (value) => setState(() => widget.formData[key] = value),
          ),
        ],
      ],
    );
  }

  Widget _buildMobileCheckbox(String label, String key, String oppositeKey) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: widget.formData[key] ?? false,
          onChanged: (value) {
            setState(() {
              widget.formData[key] = value;
              widget.formData[oppositeKey] = !value!;
            });
          },
        ),
        Text(label),
      ],
    );
  }

  Widget _buildThemesTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FixedColumnWidth(200),
        1: FixedColumnWidth(100),
        2: FixedColumnWidth(100),
        3: FixedColumnWidth(150),
        4: FixedColumnWidth(150),
        5: FixedColumnWidth(150),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade800),
          children: [
            _buildTableHeaderCell('Thèmes', rowSpan: 2),
            _buildTableHeaderCell('Enseigné ?', colSpan: 2),
            _buildTableHeaderCell('Sous quelle forme', colSpan: 3),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade800),
          children: [
            _buildTableHeaderCell('Oui'),
            _buildTableHeaderCell('Non'),
            _buildTableHeaderCell('Programme officiel'),
            _buildTableHeaderCell('Discipline à part'),
            _buildTableHeaderCell('Activités parascolaires'),
          ],
        ),
        _buildThemeRow('VIH/Sida', 'vihSida'),
        _buildThemeRow('Santé sexuelle', 'santeSexuelle'),
        _buildThemeRow('Sensibilisation', 'sensibilisation'),
        _buildThemeRow('Éducation environnementale', 'educationEnvironnementale'),
      ],
    );
  }



  Widget _buildCheckbox(String key) {
    return Center(
      child: Checkbox(
        value: widget.formData[key] ?? false,
        onChanged: (value) => setState(() => widget.formData[key] = value),
      ),
    );
  }

  Widget _buildTableHeaderCell(String text, {int rowSpan = 1, int colSpan = 1}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// Widget pour le tableau des règlements
class ResponsiveRegulationsTable extends StatefulWidget {
  final Map<String, dynamic> formData;

  const ResponsiveRegulationsTable({super.key, required this.formData});

  @override
  State<ResponsiveRegulationsTable> createState() => _ResponsiveRegulationsTableState();
}

class _ResponsiveRegulationsTableState extends State<ResponsiveRegulationsTable> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: const ValueKey('regulations_table_layout'),
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildScrollableTable(_buildRegulationsTable());
        } else {
          return Column(
            key: const ValueKey('mobile_regulations_column'),
            children: [
              _buildMobileRegulationCard('Sécurité physique', 'securitePhysique'),
              const SizedBox(height: 16),
              _buildMobileRegulationCard('Stigmatisation', 'stigmatisationDiscrimination'),
              const SizedBox(height: 16),
              _buildMobileRegulationCard('Harcèlements', 'harcelementAbusSexuels'),
            ],
          );
        }
      },
    );
  }

  Widget _buildScrollableTable(Widget table) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: table,
      ),
    );
  }

  Widget _buildMobileRegulationCard(String title, String keyPrefix) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _buildMobileRadioRow('${keyPrefix}Oui', '${keyPrefix}Non'),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileRadioRow(String yesKey, String noKey) {
    return Row(
      children: [
        _buildMobileRadioOption('Oui', yesKey, noKey),
        const SizedBox(width: 20),
        _buildMobileRadioOption('Non', noKey, yesKey),
      ],
    );
  }

  Widget _buildMobileRadioOption(String label, String key, String oppositeKey) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<bool>(
          value: true,
          groupValue: widget.formData[key],
          onChanged: (value) {
            setState(() {
              widget.formData[key] = value;
              widget.formData[oppositeKey] = !value!;
            });
          },
        ),
        Text(label),
      ],
    );
  }

  Widget _buildRegulationsTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FixedColumnWidth(250),
        1: FixedColumnWidth(100),
        2: FixedColumnWidth(100),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade800),
          children: [
            _buildTableHeaderCell('Relatifs'),
            _buildTableHeaderCell('Oui'),
            _buildTableHeaderCell('Non'),
          ],
        ),
        _buildRegulationRow('Sécurité physique', 'securitePhysique'),
        _buildRegulationRow('Stigmatisation', 'stigmatisationDiscrimination'),
        _buildRegulationRow('Harcèlements', 'harcelementAbusSexuels'),
      ],
    );
  }

  TableRow _buildRegulationRow(String regulation, String keyPrefix) {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade50),
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(regulation),
        ),
        _buildRadio('${keyPrefix}Oui'),
        _buildRadio('${keyPrefix}Non'),
      ],
    );
  }

  Widget _buildRadio(String key) {
    return Center(
      child: Radio<bool>(
        value: true,
        groupValue: widget.formData[key],
        onChanged: (value) {
          setState(() {
            widget.formData[key] = value;
            final oppositeKey = key.endsWith('Oui')
                ? key.replaceAll('Oui', 'Non')
                : key.replaceAll('Non', 'Oui');
            widget.formData[oppositeKey] = !value!;
          });
        },
      ),
    );
  }

  Widget _buildTableHeaderCell(String text) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class ResponsiveTeachingTable extends StatefulWidget {
  final Map<String, dynamic> formData;

  const ResponsiveTeachingTable({super.key, required this.formData});

  @override
  State<ResponsiveTeachingTable> createState() => _ResponsiveTeachingTableState();
}

class _ResponsiveTeachingTableState extends State<ResponsiveTeachingTable> {
  @override
  void initState() {
    super.initState();
    _calculateTotals();
  }

  void _calculateTotals() {
    final formData = widget.formData;

    // Calcul pour les enseignants formés
    final hommesFormes = int.tryParse(formData['enseignantsFormesH']?.toString() ?? '0') ?? 0;
    final femmesFormes = int.tryParse(formData['enseignantsFormesF']?.toString() ?? '0') ?? 0;
    formData['enseignantsFormesHF'] = (hommesFormes + femmesFormes).toString();

    // Calcul pour les enseignants qui dispensent
    final hommesDispensent = int.tryParse(formData['enseignantsDispensentH']?.toString() ?? '0') ?? 0;
    final femmesDispensent = int.tryParse(formData['enseignantsDispensentF']?.toString() ?? '0') ?? 0;
    formData['enseignantsDispensentHF'] = (hommesDispensent + femmesDispensent).toString();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 500) {
          return _buildScrollableTable(_buildTeachingTable());
        } else {
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  _buildMobileTeachingRow(
                      'Formés',
                      'enseignantsFormesH',
                      'enseignantsFormesF',
                      'enseignantsFormesHF'
                  ),
                  const Divider(),
                  _buildMobileTeachingRow(
                      'Dispensent',
                      'enseignantsDispensentH',
                      'enseignantsDispensentF',
                      'enseignantsDispensentHF'
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildScrollableTable(Widget table) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: table,
      ),
    );
  }

  Widget _buildMobileTeachingRow(String label, String hKey, String fKey, String totalKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Text('Hommes (H)')),
            SizedBox(
              width: 100,
              child: _buildNumberInput(hKey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Text('Femmes (F)')),
            SizedBox(
              width: 100,
              child: _buildNumberInput(fKey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Text('Total')),
            SizedBox(
              width: 100,
              child: _buildNumberInput(totalKey, isTotal: true),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTeachingTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FixedColumnWidth(150),
        1: FixedColumnWidth(100),
        2: FixedColumnWidth(100),
        3: FixedColumnWidth(100),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade800),
          children: [
            _buildTableHeaderCell(''),
            _buildTableHeaderCell('H'),
            _buildTableHeaderCell('F'),
            _buildTableHeaderCell('Total'),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade50),
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text('Formés'),
            ),
            _buildNumberInput('enseignantsFormesH'),
            _buildNumberInput('enseignantsFormesF'),
            _buildNumberInput('enseignantsFormesHF', isTotal: true),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade50),
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text('Dispensent'),
            ),
            _buildNumberInput('enseignantsDispensentH'),
            _buildNumberInput('enseignantsDispensentF'),
            _buildNumberInput('enseignantsDispensentHF', isTotal: true),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberInput(String key, {bool isTotal = false}) {
    return TextFormField(
      initialValue: widget.formData[key]?.toString() ?? '0',
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true,
      ),
      enabled: !isTotal,
      onChanged: (value) {
        setState(() {
          // Handle empty input gracefully
          if (value.isEmpty) {
            widget.formData[key] = '0';
          } else {
            widget.formData[key] = value;
          }
          _calculateTotals();
        });
      },
    );
  }

  Widget _buildTableHeaderCell(String text) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}