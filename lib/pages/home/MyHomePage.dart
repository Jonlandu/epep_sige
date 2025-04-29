import 'package:epsp_sige/pages/home/widgets/DynamicAccessAccordion.dart';
import 'package:epsp_sige/settings/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:epsp_sige/controllers/UserController.dart';
import 'package:epsp_sige/pages/home/NavigationDrawerMenu.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:epsp_sige/models/UserModel.dart';
import 'package:accordion/accordion.dart';

class MyHomePage extends StatefulWidget {
  List navigations = [];
  MyHomePage(this.navigations, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //
  var box = GetStorage();
  //
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserController>().getDataAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = box.read("user") ?? {}; // context.watch<UserController>().user;
    print("Ton user: $user");

    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const NavigationDrawerMenu(),
      body: _buildBody(UserModel.fromJson(user)),
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
              backgroundImage: user?.photo != null
                  ? NetworkImage(user!.photo!)
                  : const AssetImage('assets/avatard.png') as ImageProvider,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(UserModel? user) {
    // final provincesData = {
    //   'Kinshasa': {
    //     'Lukunga': ['Gombe', 'Ngaliema', 'Mont-Ngafula', 'Lemba'],
    //     'Tshangu': ['Ndjili', 'Kimbanseke', 'Masina', 'Nsele'],
    //     'Mont-Amba': ['Matete', 'Lemba', 'Kinsenso'],
    //     'Funa': ['Bandalungwa', 'Bumbu', 'Makala', 'Selembao'],
    //     'Plateau': ['La Gombe', 'Kintambo', 'Lingwala']
    //   },
    //   'Kongo-Central': {
    //     'Matadi': ['Matadi', 'Nzanza', 'Mvuzi'],
    //     'Boma': ['Boma', 'Kalamu', 'Lukula'],
    //     'Muanda': ['Muanda', 'Kisundi'],
    //     'Lukala': ['Lukala', 'Kasangulu']
    //   },
    //   'Katanga': {
    //     'Lubumbashi': ['Lubumbashi', 'Kampemba', 'Katuba', 'Annexe'],
    //     'Likasi': ['Likasi', 'Kambove'],
    //     'Kolwezi': ['Kolwezi', 'Dilala'],
    //     'Kipushi': ['Kipushi', 'Kasenga']
    //   },
    // };

    // Détermine le rôle de l'utilisateur
    final userRole = _determineUserRole(user?.role);

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
            Expanded(
              child: BeautifulAccordion(
                provincesData: widget.navigations.cast<Map<String, dynamic>>(),
                userRole: userRole,
                province: user?.province,
                proved: user?.proved,
                sousDivision: user?.sousDivision,
                onProvinceSelected: (province) {
                  debugPrint('Province sélectionnée: $province');
                },
                onSubdivisionSelected: (province, subdivision) {
                  debugPrint(
                      'Subdivision sélectionnée: $subdivision dans $province');
                  //,,,
                  if (userRole == "superv_sous_division" ||
                      userRole == "superv_provinceeducationelle" ||
                      userRole == "superv_provincial" ||
                      userRole == "superv_national") {
                  } else {}
                },
                onCommuneSelected: (province, subdivision, commune) {
                  debugPrint(
                      'Commune sélectionnée: $commune dans $subdivision, $province');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Méthode pour déterminer le rôle de l'utilisateur
  UserRole _determineUserRole(String? role) {
    //superv_sous_division,superv_provinceeducationelle,superv_provincial,superv_national
    switch (role) {
      case 'super_admin':
        return UserRole.superAdmin;
      case 'admin_user':
        return UserRole.adminUser;
      case 'superv_national':
        return UserRole.supervNational;
      case 'superv_provincial':
        return UserRole.supervProvincial;
      case 'superv_provinceeducationelle':
        return UserRole.supervProved;
      case 'superv_sous_division':
        return UserRole.supervSousDivision;
      case 'encodeur':
        return UserRole.encodeur;
      default:
        return UserRole.guest;
    }
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
                backgroundImage: user?.photo != null
                    ? NetworkImage(user!.photo!)
                    : const AssetImage('assets/avatard.png') as ImageProvider,
              ),
              const SizedBox(height: 16),
              Text(
                user?.nom ?? 'Administrateur',
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
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsPage()));
                },
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
                physics: const NeverScrollableScrollPhysics(),
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

class BeautifulAccordion extends StatelessWidget {
  final List<Map> provincesData;
  final UserRole userRole;
  final String? province;
  final String? proved;
  final String? sousDivision;
  final Function(String)? onProvinceSelected;
  final Function(String, String)? onSubdivisionSelected;
  final Function(String, String, String)? onCommuneSelected;

  const BeautifulAccordion({
    super.key,
    required this.provincesData,
    required this.userRole,
    this.province,
    this.proved,
    this.sousDivision,
    this.onProvinceSelected,
    this.onSubdivisionSelected,
    this.onCommuneSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DynamicAccessAccordion(
      provincesData: provincesData,
      userRole: userRole,
      province: province,
      proved: proved,
      sousDivision: sousDivision,
      onProvinceSelected: onProvinceSelected,
      onSubdivisionSelected: onSubdivisionSelected,
      onCommuneSelected: onCommuneSelected,
    );
  }
}
