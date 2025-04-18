import 'package:epsp_sige/pages/home/widgets/AccordionButton.dart';
import 'package:flutter/material.dart';
import 'package:epsp_sige/controllers/UserController.dart';
import 'package:epsp_sige/pages/home/NavigationDrawerMenu.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserController>().getDataAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const NavigationDrawerMenu(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final user = context.watch<UserController>().user;

    return AppBar(
      title: const Text(
        'Ministère de l\'Enseignement',
        style: TextStyle(fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFF040034),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: _showUserProfile,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: user?.image != null
                  ? NetworkImage(user!.image!)
                  : const AssetImage('assets/avatard.png') as ImageProvider,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/map_background.jpg',
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(0.1),
          ),
        ),
        Column(
          children: [
            _buildHeader(),
            const Expanded(child: BeautifulAccordion()),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF040034).withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Système Intégré de Gestion de l\'Éducation',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Trouvez les établissements scolaires par province, sous-division et commune',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _showQuickActions,
      icon: const Icon(Icons.add_location_alt),
      label: const Text('Ajouter École'),
      backgroundColor: Colors.blue,
      elevation: 4,
    );
  }

  void _showUserProfile() {
    showDialog(
      context: context,
      builder: (context) {
        final user = context.read<UserController>().user;

        return AlertDialog(
          title: const Text('Profil Utilisateur'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: user?.image != null
                    ? NetworkImage(user!.image!)
                    : const AssetImage('assets/avatard.png') as ImageProvider,
              ),
              const SizedBox(height: 16),
              Text(
                user?.fullName ?? 'Administrateur',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user?.email ?? 'admin@education.cd',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Paramètres'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Déconnexion'),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Actions Rapides',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 0.9,
                physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                children: [
                  _buildQuickAction(Icons.add, 'Ajouter École'),
                  _buildQuickAction(Icons.bar_chart, 'Statistiques'),
                  _buildQuickAction(Icons.report, 'Rapports'),
                  _buildQuickAction(Icons.school, 'Nouveau District'),
                  _buildQuickAction(Icons.map, 'Carte Interactive'),
                  _buildQuickAction(Icons.cloud_upload, 'Importer Données'),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickAction(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue.shade800),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}