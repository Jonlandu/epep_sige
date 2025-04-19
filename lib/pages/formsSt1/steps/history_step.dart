import 'package:flutter/material.dart';

class HistoryStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const HistoryStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 8),
          _buildSubtitle(),
          const SizedBox(height: 24),
          _buildYearField(),
          const SizedBox(height: 24),
          _buildInfrastructureTitle(),
          const SizedBox(height: 12),
          _buildInfrastructureGrid(context),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Historique',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade800,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Informations sur la création et les infrastructures',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _buildYearField() {
    return _buildTextFormField(
      label: 'Année de création',
      initialValue: formData['anneeCreation'],
      keyboardType: TextInputType.number,
      onSaved: (value) => formData['anneeCreation'] = value,
      icon: Icons.calendar_today_outlined,
    );
  }

  Widget _buildInfrastructureTitle() {
    return Text(
      'Infrastructures disponibles',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade800,
      ),
    );
  }

  Widget _buildInfrastructureGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3.5,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: ['Bibliothèque', 'Laboratoire', 'Terrain de sport', 'Cantine', 'Salle informatique']
          .map((infra) {
        return _buildInfrastructureCard(infra);
      }).toList(),
    );
  }

  Widget _buildInfrastructureCard(String infra) {
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
          _toggleInfrastructure(infra);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Checkbox(
                value: formData['infrastructures'].contains(infra),
                onChanged: (bool? value) {
                  _toggleInfrastructure(infra);
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
  }

  void _toggleInfrastructure(String infra) {
    if (formData['infrastructures'].contains(infra)) {
      formData['infrastructures'].remove(infra);
    } else {
      formData['infrastructures'].add(infra);
    }
  }

  Widget _buildTextFormField({
    required String label,
    required String? initialValue,
    required TextInputType keyboardType,
    required FormFieldSetter<String> onSaved,
    IconData? icon,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade600) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onSaved: onSaved,
    );
  }
}