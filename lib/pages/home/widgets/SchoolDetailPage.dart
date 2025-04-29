import 'package:epsp_sige/models/SchoolModel.dart';
import 'package:flutter/material.dart';

class SchoolDetailPage extends StatelessWidget {
  final SchoolModel school;

  const SchoolDetailPage({Key? key, required this.school}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: 'school-${school.id}',
                child: school.logoUrl != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(school.logoUrl!),
                        backgroundColor: Colors.grey.shade200,
                      )
                    : Container(),
              ),
            ),
            const SizedBox(height: 24),
            _buildDetailSection(
              title: 'Informations Générales',
              items: [
                _buildDetailItem(Icons.school, 'Nom', school.nom),
                _buildDetailItem(Icons.location_on, 'Adresse',
                    "${school.province} ${school.proved} ${school.sousproved} "),
                _buildDetailItem(Icons.short_text, 'Abréviation', ""),
                _buildDetailItem(
                    Icons.info, 'Ville', school.territoireCommuneVille!),
                _buildDetailItem(
                    Icons.phone, 'Commune', school.territoireCommuneVille!),
                _buildDetailItem(
                    Icons.email, 'Matricule', school.matriculeCecope),
                //_buildDetailItem(Icons.short_text, 'Abréviation', ""),
                //_buildDetailItem(Icons.info, 'Description', school.description),
              ],
            ),
            // _buildDetailSection(
            //   title: '',
            //   items: [

            //   ],
            // ),
            const SizedBox(height: 32),
            //_buildContactButton(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(school.nom),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(
      {required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 8),
        ...items, // Spread operator to include items
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton() {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.mail_outline),
        label: const Text('CONTACTER'),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
