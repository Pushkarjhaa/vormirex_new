import 'dart:io';
import 'dart:math' as dartMath;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vormirex_new/controller/profile_controller.dart';
import 'package:vormirex_new/utils/app_colour.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  late final ProfileController _profileController;

  final List<String> _subjects = [
    'Coding',
    'Python',
    'Mathematics',
    'Coding',
    'Coding',
    'Python',
    'Coding',
    'Mathematics',
  ];

  @override
  void initState() {
    super.initState();

    // Ensure ProfileController is registered
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }
    _profileController = Get.find<ProfileController>();

    // Pre-fill text fields with data already fetched by ProfileController
    _nameController = TextEditingController(
      text: _profileController.name.value,
    );
    _emailController = TextEditingController(
      text: _profileController.email.value,
    );
    _phoneController = TextEditingController(
      text: _profileController.phoneNumber.value,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ── Pick image and upload ─────────────────────────────────────────────────
  Future<void> _pickAndUploadPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 800,
    );

    if (picked == null) return; // user cancelled

    await _profileController.uploadProfilePhoto(
      imageFile: File(picked.path),
      onSuccess: (message) {
        Get.snackbar(
          'Success ✓',
          message,
          backgroundColor: AppColors.accentCyan.withOpacity(0.15),
          colorText: AppColors.accentCyan,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 3),
        );
      },
      onError: (message) {
        Get.snackbar(
          'Error',
          message,
          backgroundColor: Colors.red.withOpacity(0.15),
          colorText: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      },
    );
  }

  // ── Save profile text fields ──────────────────────────────────────────────
  Future<void> _saveChanges() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      Get.snackbar(
        'Error',
        'Name and email cannot be empty.',
        backgroundColor: Colors.red.withOpacity(0.15),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    await _profileController.updateProfile(
      newName: name,
      newPhone: phone,
      onSuccess: (message) {
        Get.snackbar(
          'Success ✓',
          message,
          backgroundColor: AppColors.accentCyan.withOpacity(0.15),
          colorText: AppColors.accentCyan,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 3),
        );
        Navigator.pop(context);
      },
      onError: (message) {
        Get.snackbar(
          'Error',
          message,
          backgroundColor: Colors.red.withOpacity(0.15),
          colorText: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Edit Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 28),
                ],
              ),
            ),

            const Divider(color: Colors.white10, height: 1),

            // ── Scrollable body ──────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Profile avatar + fields card ─────────────────
                    _SectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Avatar row
                          Row(
                            children: [
                              Obx(() {
                                final photoUrl =
                                    _profileController.profilePhotoUrl.value;
                                final isUploading =
                                    _profileController.isSaving.value;

                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    // ── Avatar circle ──
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.accentCyan,
                                          width: 2.5,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: photoUrl.isNotEmpty
                                            ? Image.network(
                                                photoUrl,
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) =>
                                                    _fallbackAvatar(),
                                              )
                                            : Image.asset(
                                                'assets/profile_photo.png',
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) =>
                                                    _fallbackAvatar(),
                                              ),
                                      ),
                                    ),

                                    // ── Upload spinner overlay ──
                                    if (isUploading)
                                      Positioned.fill(
                                        child: ClipOval(
                                          child: Container(
                                            color: Colors.black.withOpacity(
                                              0.55,
                                            ),
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    // ── Camera badge ──
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: isUploading
                                            ? null
                                            : _pickAndUploadPhoto,
                                        child: Container(
                                          width: 26,
                                          height: 26,
                                          decoration: BoxDecoration(
                                            color: isUploading
                                                ? Colors.grey
                                                : AppColors.accentCyan,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppColors.scaffoldBg,
                                              width: 2,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.black,
                                            size: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              const SizedBox(width: 16),
                              // Progress alongside avatar
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Profile Completion',
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          '75%',
                                          style: TextStyle(
                                            color: AppColors.accentCyan,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: const LinearProgressIndicator(
                                        value: 0.75,
                                        backgroundColor: Colors.white12,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              AppColors.accentCyan,
                                            ),
                                        minHeight: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Full Name
                          const _FieldLabel('FULL NAME'),
                          const SizedBox(height: 8),
                          _EditField(
                            controller: _nameController,
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                          ),

                          const SizedBox(height: 16),

                          // Email (read-only — cannot be changed)
                          const _FieldLabel('EMAIL ADDRESS'),
                          const SizedBox(height: 8),
                          _EditField(
                            controller: _emailController,
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            readOnly: true,
                          ),

                          const SizedBox(height: 16),

                          // Phone
                          const _FieldLabel('PHONE NUMBER'),
                          const SizedBox(height: 8),
                          _EditField(
                            controller: _phoneController,
                            prefixIcon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── AI Personalization card ───────────────────────
                    _SectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D3330),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset('assets/new_logo.png'),
                              ),
                              const SizedBox(width: 14),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'AI Personalization',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    'Learning style: Visual & Interactive',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _subjects.map((s) {
                              final isActive = s == 'Mathematics';
                              return _SubjectChip(label: s, isActive: isActive);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── Change Password ───────────────────────────────
                    _SectionCard(
                      child: _ActionTile(
                        icon: Icons.shield_outlined,
                        title: 'Change Password',
                        subtitle: 'Last changed 30 days ago',
                        onTap: () {},
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── Linked Accounts ───────────────────────────────
                    _SectionCard(
                      child: _ActionTile(
                        icon: Icons.link,
                        title: 'Linked Accounts',
                        subtitle: 'Google, Github connected',
                        onTap: () {},
                      ),
                    ),

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),

            // ── Bottom buttons ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Obx(
                () => Column(
                  children: [
                    // Save Changes
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _profileController.isSaving.value
                            ? null
                            : _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentCyan,
                          disabledBackgroundColor: AppColors.accentCyan
                              .withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          elevation: 0,
                        ),
                        child: _profileController.isSaving.value
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.black,
                                ),
                              )
                            : const Text(
                                'Save Changes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Cancel
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cardBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fallbackAvatar() => Container(
    color: const Color(0xFF0D3330),
    child: Icon(Icons.person, color: AppColors.accentCyan, size: 40),
  );
}

// ─── Section Card ─────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10, width: 1),
      ),
      child: child,
    );
  }
}

// ─── Field Label ──────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }
}

// ─── Edit Field ───────────────────────────────────────────────────────────────

class _EditField extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool readOnly;

  const _EditField({
    required this.controller,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: readOnly ? Colors.white.withOpacity(0.03) : AppColors.scaffoldBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        style: TextStyle(
          color: readOnly ? Colors.white38 : Colors.white,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: Colors.white38, size: 20),
          suffixIcon: readOnly
              ? const Icon(Icons.lock_outline, color: Colors.white24, size: 16)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

// ─── Subject Chip ─────────────────────────────────────────────────────────────

class _SubjectChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const _SubjectChip({required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.accentCyan.withOpacity(0.15)
            : Colors.transparent,
        border: Border.all(
          color: isActive ? AppColors.accentCyan : Colors.white24,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.accentCyan : Colors.white70,
          fontSize: 12,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}

// ─── Action Tile ──────────────────────────────────────────────────────────────

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white60, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white38, size: 20),
        ],
      ),
    );
  }
}
