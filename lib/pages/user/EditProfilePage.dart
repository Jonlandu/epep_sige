import 'dart:io';
import 'package:epsp_sige/controllers/UserController.dart';
import 'package:epsp_sige/utils/Routes.dart';
import 'package:epsp_sige/widgets/ChargementWidget.dart';
import 'package:epsp_sige/widgets/CustomVisibilityWidget.dart';
import 'package:epsp_sige/widgets/EntryFieldEmailWidgets.dart';
import 'package:epsp_sige/widgets/EntryFieldLongtext.dart';
import 'package:epsp_sige/widgets/GenderWidget.dart';
import 'package:epsp_sige/widgets/MessageWidgets.dart';
import 'package:epsp_sige/widgets/ReusableEntryFieldWidgets.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //Variables group that store the existing data into Database to show before updating userInfo
  late var fullnameUserToUpdate;
  late var emailUserToUpdate;
  late var phoneUserToUpdate;
  late var addressUserToUpdate;
  late var selectedGenderToUpdate;

  //Bloc of Dispose
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  bool _isSaving = false; //Validate boutton

  //Variables group of fields
  File? _selectedImage;
  var email = TextEditingController();
  var phone = TextEditingController();
  var fullname = TextEditingController();
  var address = TextEditingController();

  String selectedGender = "";

  //CustomVisibility Bloc variable
  bool isCancelButtonVisible = false;

  bool isVisible = false;
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    //selectedGender.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration.zero, () {
        var userCtrl = context.read<UserController>();
        userCtrl.getDataAPI();

        fullnameUserToUpdate = userCtrl.user?.fullName;
        fullname = TextEditingController(text: "${fullnameUserToUpdate}");
        emailUserToUpdate = userCtrl.user?.email;
        email = TextEditingController(text: "${emailUserToUpdate}");
        phoneUserToUpdate = userCtrl.user?.phone;
        phone = TextEditingController(text: "${phoneUserToUpdate}");
        addressUserToUpdate = userCtrl.user?.address;
        address = TextEditingController(text: "${addressUserToUpdate == null ? "Please, enter your Address" : addressUserToUpdate}");
      });
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back, color: Colors.white,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Edit Profile', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.white,),
            onPressed: _isSaving ? null : _handleSignUpPressed,
          ),
        ],
        backgroundColor: Color(0xFF040034),
      ),
      body: Stack(
        children: [
          _body(context),
          ChargementWidget(isVisible)
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {

    return Form(
      key: formKey,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(06.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select a picture'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text('Take a picture'),
                                    onTap: () {
                                      _pickImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo_library),
                                    title: Text('Choose from gallery'),
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : AssetImage('assets/avatard.png') as ImageProvider,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                ReusableEntryFieldWidgets(
                  ctrl: fullname,
                  label: "Full name",
                  required: true,
                  isName: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                EntryFieldEmailWidgets(
                  ctrl: email,
                  required: true,
                  label: "Email",
                  isEmail: false,
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                EntryFieldLongtext(
                  ctrl: address,
                  label: "Address",
                  required: true,
                ),
                GenderSelectionWidget(
                  showOtherGender: true,
                  alignVertical: false,
                  //initialGender: Gender.Others, // Provide the initial gender value here
                  onChanged: (Gender? gender) {
                    print(gender);
                    //Extracting gender by spliting thanks to '.' a reccover [1] element of liste
                    if (gender != null) {
                      List<String> genderParts = gender.toString().split('.');
                      String extractedGender = genderParts[1];
                      selectedGender = extractedGender;
                      print(extractedGender);
                    }
                    //setState(() {});
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CustomVisibilityWidget(
                  visible: isCancelButtonVisible,
                  onPressed: () {
                    setState(() {
                      isCancelButtonVisible = false;
                      //isLoadingWaitingAPIResponse = false;
                    });
                  },
                  child: Text(
                    'Cancel query',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveChanges() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }

    isVisible = true;
    setState(() {
      _isSaving = true;
    });

    var ctrl = context.read<UserController>();

    //We do it here because gender value is initialised empty
    var selectedGenderToUse = selectedGender.isEmpty ? "Others" : selectedGender;

    Map data = {
      'fullName': fullname.text,
      'email': email.text,
      'phone': phone.text,
      'address': address.text,
      'gender': selectedGenderToUse,
    };

    print("USER INFORMATION TU UPDATE ${data}");
    var response = await ctrl.updateProfil(data);
    await Future.delayed(Duration(seconds: 3));

    isVisible = false;
    setState(() {});

    if (response.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
      Navigator.pushNamedAndRemoveUntil(context, Routes.BottomNavigationPageRoutes, ModalRoute.withName('/homepage'),);

      var msg = (response.data?['message'] ?? "Done with success");
      MessageWidgetsSuccess.showSnack(context, msg);

      } else {
      var msg = response.isException == true ? response.errorMsg : (response.data?['message'] ?? "");
      MessageWidgets.showSnack(context, msg);
    }

    setState(() {
      _isSaving = false;
    });
  }

  void _handleSignUpPressed() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
      isCancelButtonVisible = true;
    });

    await _saveChanges();

    setState(() {
      _isSaving = false;
      isCancelButtonVisible = false;
    });
  }

  showSnackBar(context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Ok',
          textColor: Colors.orange,
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }
}