import 'dart:convert';

import 'package:epsp_sige/utils/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DynamicAccessAccordion extends StatefulWidget {
  final List<Map> provincesData;
  final UserRole userRole;
  final String? province;
  final String? proved;
  final String? sousDivision;
  final Function(String)? onProvinceSelected;
  final Function(String, String)? onSubdivisionSelected;
  final Function(String, String, String)? onCommuneSelected;

  const DynamicAccessAccordion({
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
  State<DynamicAccessAccordion> createState() => _DynamicAccessAccordionState();
}

enum UserRole {
  superAdmin, // Accès complet à tous les niveaux
  adminUser, // Accès complet (admin)
  supervNational, // Accès national
  supervProvincial, // Accès provincial
  supervProved, // Accès province éducationnelle
  supervSousDivision, // Accès sous-division
  encodeur, // Encodeur
  guest, // Encodeur
}

class _DynamicAccessAccordionState extends State<DynamicAccessAccordion> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final Map<String, bool> _provinceExpansionState = {};
  final Map<String, Map<String, bool>> _subdivisionExpansionState = {};

  @override
  void initState() {
    super.initState();
    //_initializeExpansionStates();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() => _searchQuery = _searchController.text);
  }

  // void _initializeExpansionStates() {
  //   for (var province in widget.provincesData.keys) {
  //     _provinceExpansionState[province] = false;
  //     _subdivisionExpansionState[province] = {};
  //     for (var subdivision in widget.provincesData[province]!.keys) {
  //       _subdivisionExpansionState[province]![subdivision] = false;
  //     }
  //   }
  // }

  // List _filterData() {
  //   List filteredData = [];
  //   // Filtre basé sur le rôle de l'utilisateur
  //   switch (widget.userRole) {
  //     case UserRole.superAdmin:
  //     case UserRole.adminUser:
  //     case UserRole.guest:
  //     case UserRole.supervNational:
  //       filteredData = widget.provincesData;
  //       break;
  //     case UserRole.supervProvincial:
  //       if (widget.province != null) {
  //         // filteredData = {
  //         //   widget.province!: widget.provincesData[widget.province] ?? {},
  //         // };
  //         filteredData = widget.provincesData[widget.province]
  //       }
  //       break;
  //     case UserRole.supervProved:
  //       if (widget.proved != null) {
  //         for (var province in widget.provincesData.keys) {
  //           final subdivisions = widget.provincesData[province]!;
  //           final filteredSubdivisions = <String, List<String>>{};
  //           for (var subdivision in subdivisions.keys) {
  //             if (subdivision == widget.proved) {
  //               filteredSubdivisions[subdivision] = subdivisions[subdivision]!;
  //             }
  //           }
  //           if (filteredSubdivisions.isNotEmpty) {
  //             filteredData[province] = filteredSubdivisions;
  //           }
  //         }
  //       }
  //       break;
  //     case UserRole.supervSousDivision:
  //       if (widget.sousDivision != null) {
  //         for (var province in widget.provincesData) {
  //           final subdivisions = province[''];
  //           final filteredSubdivisions = <String, List<String>>{};
  //           for (var subdivision in subdivisions.keys) {
  //             if (subdivision == widget.sousDivision) {
  //               filteredSubdivisions[subdivision] = subdivisions[subdivision]!;
  //             }
  //           }
  //           if (filteredSubdivisions.isNotEmpty) {
  //             filteredData[province] = filteredSubdivisions;
  //           }
  //         }
  //       }
  //       break;
  //     case UserRole.encodeur:
  //       filteredData = {};
  //       break;
  //   }
  //   // Filtre supplémentaire basé sur la recherche
  //   if (_searchQuery.isNotEmpty) {
  //     final tempFilteredData = [];
  //     for (var province in filteredData.keys) {
  //       if (province.toLowerCase().contains(_searchQuery.toLowerCase())) {
  //         tempFilteredData[province] = filteredData[province]!;
  //         continue;
  //       }
  //       final filteredSubdivisions = <String, List<String>>{};
  //       for (var subdivision in filteredData[province]!.keys) {
  //         if (subdivision.toLowerCase().contains(_searchQuery.toLowerCase())) {
  //           filteredSubdivisions[subdivision] =
  //               filteredData[province]![subdivision]!;
  //           continue;
  //         }
  //         final communes = filteredData[province]![subdivision]!
  //             .where((commune) =>
  //                 commune.toLowerCase().contains(_searchQuery.toLowerCase()))
  //             .toList();
  //         if (communes.isNotEmpty) {
  //           filteredSubdivisions[subdivision] = communes;
  //         }
  //       }
  //       if (filteredSubdivisions.isNotEmpty) {
  //         tempFilteredData[province] = filteredSubdivisions;
  //       }
  //     }
  //     return tempFilteredData;
  //   }
  //   return filteredData;
  // }

  List<String> selectedHierarchy = [];

  @override
  Widget build(BuildContext context) {
    final filteredData = widget.provincesData;

    if (widget.userRole == UserRole.encodeur) {
      return const Center(
        child: Text("L'encodeur n'a pas accès à cette vue"),
      );
    }

    return Column(
      children: [
        _buildSearchBar(),
        const SizedBox(height: 10),
        _buildUserRoleBadge(),
        const SizedBox(height: 10),
        Expanded(
          child: filteredData.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    String abre = "";
                    return buildExpansionTile(filteredData[index], []);
                  },
                ),
          // ListView.builder(
          //     itemCount: filteredData.length,
          //     itemBuilder: (context, index) {
          //       final province = filteredData.keys.elementAt(index);
          //       return _buildAccordionForRole(
          //           province, filteredData[province]!);
          //     },
          //   ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Rechercher...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ));
  }

  Widget _buildUserRoleBadge() {
    Color roleColor;
    String roleText;

    switch (widget.userRole) {
      case UserRole.superAdmin:
        roleColor = Colors.green;
        roleText = 'Super Admin (Accès complet)';
        break;
      case UserRole.adminUser:
        roleColor = Colors.green;
        roleText = 'Admin (Accès complet)';
        break;
      case UserRole.supervNational:
        roleColor = Colors.blue;
        roleText = 'Superviseur National';
        break;
      case UserRole.supervProvincial:
        roleColor = Colors.blue;
        roleText = 'Superviseur Provincial: ${widget.province ?? 'Non défini'}';
        break;
      case UserRole.supervProved:
        roleColor = Colors.orange;
        roleText =
            'Superviseur Province Éducationnelle: ${widget.proved ?? 'Non défini'}';
        break;
      case UserRole.supervSousDivision:
        roleColor = Colors.purple;
        roleText =
            'Superviseur Sous-Division: ${widget.sousDivision ?? 'Non défini'}';
        break;

      case UserRole.guest:
        roleColor = Colors.grey;
        roleText = 'Encodeur';
        break;

      case UserRole.encodeur:
        roleColor = Colors.grey;
        roleText = 'Encodeur';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: roleColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: roleColor),
      ),
      child: Text(
        roleText,
        style: TextStyle(
          color: roleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 60,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty
                ? 'Aucune donnée disponible pour votre rôle'
                : 'Aucun résultat trouvé',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccordionForRole(
      String province, Map<String, List<String>> subdivisions) {
    switch (widget.userRole) {
      case UserRole.superAdmin:
      case UserRole.adminUser:
      case UserRole.supervNational:
        return _buildFullAccessAccordion(province, subdivisions);
      case UserRole.supervProvincial:
        return _buildProvincialAccessAccordion(province, subdivisions);
      case UserRole.supervProved:
        return _buildProvedAccessAccordion(province, subdivisions);
      case UserRole.supervSousDivision:
        return _buildSousDivisionAccessAccordion(province, subdivisions);

      case UserRole.guest:
        return Container();

      case UserRole.encodeur:
        return const SizedBox.shrink();
    }
  }

  Widget _buildFullAccessAccordion(
      String province, Map<String, List<String>> subdivisions) {
    final isExpanded = _provinceExpansionState[province] ?? false;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(province),
        subtitle: Text('${subdivisions.length} sous-divisions'),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) =>
            setState(() => _provinceExpansionState[province] = expanded),
        children: subdivisions.keys.map((subdivision) {
          return _buildSubdivisionTile(
              province, subdivision, subdivisions[subdivision]!);
        }).toList(),
      ),
    );
  }

  Widget _buildProvincialAccessAccordion(
      String province, Map<String, List<String>> subdivisions) {
    final isExpanded = _provinceExpansionState[province] ?? false;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(province),
        subtitle: Text('${subdivisions.length} sous-divisions'),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) =>
            setState(() => _provinceExpansionState[province] = expanded),
        children: subdivisions.keys.map((subdivision) {
          final communes = subdivisions[subdivision]!;
          return ListTile(
            title: Text(subdivision),
            subtitle: Text('${communes.length} communes'),
            onTap: () =>
                widget.onSubdivisionSelected?.call(province, subdivision),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProvedAccessAccordion(
      String province, Map<String, List<String>> subdivisions) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: subdivisions.keys.map((subdivision) {
          final communes = subdivisions[subdivision]!;
          final isExpanded =
              _subdivisionExpansionState[province]?[subdivision] ?? false;

          return ExpansionTile(
            title: Text(subdivision),
            subtitle: Text('${communes.length} communes'),
            initiallyExpanded: isExpanded,
            onExpansionChanged: (expanded) => setState(() {
              _subdivisionExpansionState[province]![subdivision] = expanded;
            }),
            children: communes.map((commune) {
              return ListTile(
                title: Text(commune),
                onTap: () => widget.onCommuneSelected
                    ?.call(province, subdivision, commune),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSousDivisionAccessAccordion(
      String province, Map<String, List<String>> subdivisions) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children:
            subdivisions.values.expand((communes) => communes).map((commune) {
          return ListTile(
            title: Text(commune),
            onTap: () {
              // Trouver la subdivision correspondante
              final subdivision = subdivisions.keys.firstWhere(
                (key) => subdivisions[key]!.contains(commune),
                orElse: () => '',
              );
              if (subdivision.isNotEmpty) {
                widget.onCommuneSelected?.call(province, subdivision, commune);
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSubdivisionTile(
      String province, String subdivision, List<String> communes) {
    final isExpanded =
        _subdivisionExpansionState[province]?[subdivision] ?? false;

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Card(
        child: ExpansionTile(
          title: Text(subdivision),
          subtitle: Text('${communes.length} communes'),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (expanded) => setState(() {
            _subdivisionExpansionState[province]![subdivision] = expanded;
          }),
          children: communes.map((commune) {
            return Padding(
              padding: const EdgeInsets.only(left: 16),
              child: ListTile(
                title: Text(commune),
                onTap: () => widget.onCommuneSelected
                    ?.call(province, subdivision, commune),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  //
  var box = GetStorage();

  //
  Widget buildExpansionTile(dynamic item, List parentNames) {
    final currentHierarchy = List<String>.from(parentNames)..add(item['name']);
    final hasChildren =
        (item['sub_navigations'] ?? item['sub_navigations'] ?? []).isNotEmpty;

    if (!hasChildren) {
      return ListTile(
        title: Text(item['name']),
        onTap: () {
          setState(() {
            selectedHierarchy = currentHierarchy;
            //
            print(
              'Chemin sélectionné: ${selectedHierarchy.join(' > ')}',
            );
            if (widget.userRole.name == "superv_sous_division" ||
                widget.userRole.name == "superv_provinceeducationelle" ||
                widget.userRole.name == "superv_provincial" ||
                widget.userRole.name == "superv_national") {
              //
              var user = box.read("user") ?? {};
              //
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.SchoolListPageRoutes,
                ModalRoute.withName('/SchoolListPageRoutes'),
                arguments: {
                  'establishments': user["etablissements"].toList(),
                },
              );
            } else {}
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sélectionné: ${currentHierarchy.join(' > ')}'),
            ),
          );
        },
      );
    }

    return ExpansionTile(
      title: Text(item['name']),
      children: (item['sub_navigations'] ?? item['sub_navigations'])
          .map<Widget>(
              (subItem) => buildExpansionTile(subItem, currentHierarchy))
          .toList(),
    );
  }
}

//widget.onSubdivisionSelected?.call(province, subdivision),
