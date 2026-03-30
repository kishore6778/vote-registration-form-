import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const VoterRegistrationApp());
}

class VoterRegistrationApp extends StatelessWidget {
  const VoterRegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voter Registration',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A73E8),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const VoterRegistrationForm(),
    );
  }
}

class VoterRegistrationForm extends StatefulWidget {
  const VoterRegistrationForm({super.key});

  @override
  State<VoterRegistrationForm> createState() => _VoterRegistrationFormState();
}

class _VoterRegistrationFormState extends State<VoterRegistrationForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _successController;
  late Animation<double> _successAnimation;

  bool _showSuccess = false;
  bool _isSubmitting = false;

  // Controllers
  final _fullNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _aadhaarController = TextEditingController();
  final _voterIdController = TextEditingController();
  final _doorNoController = TextEditingController();
  final _streetController = TextEditingController();
  final _areaController = TextEditingController();
  final _villageController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _wardController = TextEditingController();
  final _boothController = TextEditingController();

  // State values
  DateTime? _selectedDOB;
  String? _gender;
  String? _relationship;
  String? _casteCategory;
  String? _panchayat;
  String? _block;
  String? _district;
  String? _assembly;
  bool _declarationChecked = false;
  int? _age;

  // Options
  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _relationships = ['Father', 'Husband', 'Mother'];
  final List<String> _castes = ['General', 'OBC', 'SC', 'ST'];
  final List<String> _panchayats = [
    'Ambattur Panchayat',
    'Avadi Panchayat',
    'Tiruvallur Panchayat',
    'Kancheepuram Panchayat',
    'Chengalpattu Panchayat',
  ];
  final List<String> _blocks = [
    'Ambattur Block',
    'Avadi Block',
    'Poonamallee Block',
    'Tiruvallur Block',
  ];
  final List<String> _districts = [
    'Chennai',
    'Tiruvallur',
    'Kancheepuram',
    'Chengalpattu',
    'Vellore',
    'Coimbatore',
    'Madurai',
    'Salem',
  ];
  final List<String> _assemblies = [
    'Ambattur',
    'Avadi',
    'Poonamallee',
    'Tiruvallur',
    'Sholinganallur',
    'Velachery',
    'T. Nagar',
    'Anna Nagar',
  ];

  @override
  void initState() {
    super.initState();
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _successAnimation = CurvedAnimation(
      parent: _successController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _successController.dispose();
    _fullNameController.dispose();
    _fatherNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _aadhaarController.dispose();
    _voterIdController.dispose();
    _doorNoController.dispose();
    _streetController.dispose();
    _areaController.dispose();
    _villageController.dispose();
    _pincodeController.dispose();
    _wardController.dispose();
    _boothController.dispose();
    super.dispose();
  }

  void _calculateAge(DateTime dob) {
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    setState(() => _age = age);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1920),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF4FC3F7),
              onPrimary: Colors.black,
              surface: Color(0xFF1E2A3A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDOB = picked);
      _calculateAge(picked);
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Text('Please fill all required fields correctly.'),
            ],
          ),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    if (_selectedDOB == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select your Date of Birth.'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    if (!_declarationChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please accept the declaration to proceed.'),
          backgroundColor: Colors.orange.shade700,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isSubmitting = false;
      _showSuccess = true;
    });
    _successController.forward();
  }

  void _resetForm() {
    _successController.reset();
    setState(() {
      _showSuccess = false;
      _selectedDOB = null;
      _gender = null;
      _relationship = null;
      _casteCategory = null;
      _panchayat = null;
      _block = null;
      _district = null;
      _assembly = null;
      _declarationChecked = false;
      _age = null;
    });
    _formKey.currentState?.reset();
    _fullNameController.clear();
    _fatherNameController.clear();
    _mobileController.clear();
    _emailController.clear();
    _aadhaarController.clear();
    _voterIdController.clear();
    _doorNoController.clear();
    _streetController.clear();
    _areaController.clear();
    _villageController.clear();
    _pincodeController.clear();
    _wardController.clear();
    _boothController.clear();
  }

  // ─── Build helpers ─────────────────────────────────────────────────────────

  Widget _glassCard({required Widget child, EdgeInsets? padding}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: padding ?? const EdgeInsets.all(22),
          child: child,
        ),
      ),
    );
  }

  Widget _sectionHeader(String emoji, String title, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor.withOpacity(0.8), accentColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 14),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
              shadows: [
                Shadow(
                  color: accentColor.withOpacity(0.5),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _fieldDecoration(String label, IconData icon,
      {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF4FC3F7), size: 20),
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.65),
        fontSize: 13.5,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.3),
        fontSize: 13,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.06),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide:
            const BorderSide(color: Color(0xFF4FC3F7), width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1.8),
      ),
      errorStyle: const TextStyle(color: Color(0xFFFF6B6B), fontSize: 11.5),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    TextEditingController controller, {
    String? hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    String? Function(String?)? validator,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      readOnly: readOnly,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14.5,
        fontWeight: FontWeight.w500,
      ),
      decoration: _fieldDecoration(label, icon, hint: hint).copyWith(
        counterStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown(
    String label,
    IconData icon,
    String? value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: _fieldDecoration(label, icon),
      dropdownColor: const Color(0xFF1A2744),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14.5,
        fontWeight: FontWeight.w500,
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded,
          color: Color(0xFF4FC3F7)),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (v) => v == null ? 'Please select $label' : null,
    );
  }

  // ─── Sections ──────────────────────────────────────────────────────────────

  Widget _personalSection() {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('👤', 'Personal Details', const Color(0xFF4FC3F7)),
          _buildTextField(
            'Full Name *',
            Icons.person_outline_rounded,
            _fullNameController,
            hint: 'Enter your full name',
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Full name is required';
              if (v.trim().length < 3) return 'Name must be at least 3 characters';
              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(v.trim()))
                return 'Name should contain only letters';
              return null;
            },
          ),
          const SizedBox(height: 16),
          // DOB + Age Row
          Row(
            children: [
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: _pickDate,
                  child: AbsorbPointer(
                    child: TextFormField(
                      readOnly: true,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500),
                      decoration: _fieldDecoration(
                              'Date of Birth *', Icons.calendar_today_rounded)
                          .copyWith(
                        hintText: _selectedDOB == null
                            ? 'Select date'
                            : '${_selectedDOB!.day.toString().padLeft(2, '0')}/${_selectedDOB!.month.toString().padLeft(2, '0')}/${_selectedDOB!.year}',
                        hintStyle: TextStyle(
                          color: _selectedDOB == null
                              ? Colors.white.withOpacity(0.3)
                              : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (_) =>
                          _selectedDOB == null ? 'Select date of birth' : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.12)),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Age',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          _age != null ? '$_age yrs' : '—',
                          style: const TextStyle(
                            color: Color(0xFF4FC3F7),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Gender
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gender *',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.65),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: _genders.map((g) {
                  final selected = _gender == g;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _gender = g),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          gradient: selected
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF4FC3F7),
                                    Color(0xFF1A73E8)
                                  ],
                                )
                              : null,
                          color: selected
                              ? null
                              : Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selected
                                ? Colors.transparent
                                : Colors.white.withOpacity(0.12),
                          ),
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF4FC3F7)
                                        .withOpacity(0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            g,
                            style: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.6),
                              fontWeight: selected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              fontSize: 13.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildTextField(
                  "Father's / Husband's Name *",
                  Icons.family_restroom_rounded,
                  _fatherNameController,
                  hint: 'Enter name',
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'This field is required'
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  'Relation',
                  Icons.people_outline_rounded,
                  _relationship,
                  _relationships,
                  (v) => setState(() => _relationship = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Mobile Number *',
            Icons.phone_iphone_rounded,
            _mobileController,
            hint: '10-digit mobile number',
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 10,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Mobile number is required';
              if (v.length != 10) return 'Enter a valid 10-digit number';
              if (!RegExp(r'^[6-9]\d{9}$').hasMatch(v))
                return 'Enter a valid Indian mobile number';
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Email ID (Optional)',
            Icons.email_outlined,
            _emailController,
            hint: 'example@email.com',
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v != null && v.isNotEmpty) {
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(v)) {
                  return 'Enter a valid email address';
                }
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _identitySection() {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('🪪', 'Identity Details', const Color(0xFF81C784)),
          _buildTextField(
            'Aadhaar Number *',
            Icons.fingerprint_rounded,
            _aadhaarController,
            hint: '12-digit Aadhaar number',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 12,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Aadhaar number is required';
              if (v.length != 12) return 'Aadhaar must be exactly 12 digits';
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Voter ID Number (if existing)',
            Icons.how_to_vote_outlined,
            _voterIdController,
            hint: 'e.g. ABC1234567',
            validator: (v) {
              if (v != null && v.isNotEmpty) {
                if (!RegExp(r'^[A-Z]{3}[0-9]{7}$').hasMatch(v.toUpperCase())) {
                  return 'Format: 3 letters + 7 digits (e.g. ABC1234567)';
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            'Caste Category *',
            Icons.category_outlined,
            _casteCategory,
            _castes,
            (v) => setState(() => _casteCategory = v),
          ),
        ],
      ),
    );
  }

  Widget _addressSection() {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('🏠', 'Address Details', const Color(0xFFFFB74D)),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  'Door / House No. *',
                  Icons.home_outlined,
                  _doorNoController,
                  hint: 'No.',
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Required'
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _buildTextField(
                  'Street Name *',
                  Icons.streetview_outlined,
                  _streetController,
                  hint: 'Street / Road name',
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Street name is required'
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Area / Colony *',
            Icons.location_city_outlined,
            _areaController,
            hint: 'Locality / Colony / Nagar',
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Area is required'
                : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Village / Town *',
            Icons.villa_outlined,
            _villageController,
            hint: 'Village or Town name',
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Village/Town is required'
                : null,
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            'Panchayat *',
            Icons.account_balance_outlined,
            _panchayat,
            _panchayats,
            (v) => setState(() => _panchayat = v),
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            'Block / Taluk *',
            Icons.map_outlined,
            _block,
            _blocks,
            (v) => setState(() => _block = v),
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            'District *',
            Icons.place_outlined,
            _district,
            _districts,
            (v) => setState(() => _district = v),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  readOnly: true,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500),
                  decoration:
                      _fieldDecoration('State', Icons.flag_outlined)
                          .copyWith(hintText: 'Tamil Nadu'),
                  initialValue: 'Tamil Nadu',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  'Pincode *',
                  Icons.pin_drop_outlined,
                  _pincodeController,
                  hint: '6-digit',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 6,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    if (v.length != 6) return '6 digits needed';
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _constituencySection() {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
              '🗳️', 'Constituency Details', const Color(0xFFCE93D8)),
          _buildDropdown(
            'Assembly Constituency *',
            Icons.how_to_vote_rounded,
            _assembly,
            _assemblies,
            (v) => setState(() => _assembly = v),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  'Ward Number *',
                  Icons.grid_view_outlined,
                  _wardController,
                  hint: 'Ward no.',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Required'
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  'Booth Number *',
                  Icons.inbox_outlined,
                  _boothController,
                  hint: 'Booth no.',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Required'
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _declarationSection() {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('✅', 'Declaration', const Color(0xFF4DB6AC)),
          GestureDetector(
            onTap: () =>
                setState(() => _declarationChecked = !_declarationChecked),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: _declarationChecked
                        ? const LinearGradient(
                            colors: [Color(0xFF4DB6AC), Color(0xFF00897B)],
                          )
                        : null,
                    color: _declarationChecked
                        ? null
                        : Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _declarationChecked
                          ? Colors.transparent
                          : Colors.white.withOpacity(0.3),
                    ),
                  ),
                  child: _declarationChecked
                      ? const Icon(Icons.check_rounded,
                          color: Colors.white, size: 16)
                      : null,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'I hereby declare that all the information provided above is true and correct to the best of my knowledge. I understand that providing false information is an offence under the Representation of the People Act.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 13,
                      height: 1.6,
                      fontWeight: FontWeight.w400,
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

  Widget _submitButton() {
    return GestureDetector(
      onTap: _isSubmitting ? null : _submitForm,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          gradient: _isSubmitting
              ? LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05)
                  ],
                )
              : const LinearGradient(
                  colors: [Color(0xFF4FC3F7), Color(0xFF1565C0)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isSubmitting
              ? []
              : [
                  BoxShadow(
                    color: const Color(0xFF4FC3F7).withOpacity(0.45),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: Center(
          child: _isSubmitting
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.how_to_vote_rounded,
                        color: Colors.white, size: 22),
                    SizedBox(width: 10),
                    Text(
                      'Submit Registration',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _successOverlay() {
    return AnimatedBuilder(
      animation: _successAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _successAnimation.value,
          child: child,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: const Color(0xFF4DB6AC).withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.all(36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4DB6AC), Color(0xFF00897B)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4DB6AC).withOpacity(0.5),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.check_rounded,
                        color: Colors.white, size: 42),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Registration Successful!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your details have been saved successfully.\nYou will receive a confirmation SMS shortly.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.65),
                      fontSize: 14,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  GestureDetector(
                    onTap: _resetForm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4FC3F7), Color(0xFF1565C0)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4FC3F7).withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Register Another',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // ── Background gradient ──
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A0F2C),
                  Color(0xFF0D1B3E),
                  Color(0xFF0A1628),
                ],
              ),
            ),
          ),
          // ── Ambient orbs ──
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF1A73E8).withOpacity(0.25),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF4DB6AC).withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // ── Main content ──
          SafeArea(
            child: _showSuccess
                ? Center(child: _successOverlay())
                : Form(
                    key: _formKey,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header
                                Row(
                                  children: [
                                    Container(
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF4FC3F7),
                                            Color(0xFF1565C0)
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF4FC3F7)
                                                .withOpacity(0.4),
                                            blurRadius: 16,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text('🗳️',
                                            style:
                                                TextStyle(fontSize: 26)),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Voter Registration',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                        Text(
                                          'Tamil Nadu Election Commission',
                                          style: TextStyle(
                                            color: Colors.white
                                                .withOpacity(0.5),
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    'All fields marked * are mandatory',
                                    style: TextStyle(
                                      color:
                                          const Color(0xFF4FC3F7).withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                _personalSection(),
                                const SizedBox(height: 16),
                                _identitySection(),
                                const SizedBox(height: 16),
                                _addressSection(),
                                const SizedBox(height: 16),
                                _constituencySection(),
                                const SizedBox(height: 16),
                                _declarationSection(),
                                const SizedBox(height: 24),
                                _submitButton(),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
