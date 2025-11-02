import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  final String userPhone;

  const ProfileScreen({super.key, required this.userPhone});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Kullanıcı';
  String userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profil kartı
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.secondary,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.userPhone,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                    if (userEmail.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        userEmail,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.grey600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: _editProfile,
                      icon: const Icon(Icons.edit, size: 20),
                      label: const Text('Profili Düzenle'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Menü seçenekleri
            _buildMenuSection('Hesap Yönetimi', [
              _MenuOption(
                icon: Icons.child_care,
                title: 'Çocuk Bilgileri',
                subtitle: 'Çocuk bilgilerini ekle ve düzenle',
                onTap: () {
                  // TODO: Navigate to children management
                },
              ),
              _MenuOption(
                icon: Icons.notifications,
                title: 'Bildirimler',
                subtitle: 'Bildirim ayarları',
                onTap: () {
                  // TODO: Navigate to notification settings
                },
              ),
              _MenuOption(
                icon: Icons.security,
                title: 'Güvenlik',
                subtitle: 'Güvenlik ve gizlilik ayarları',
                onTap: () {
                  // TODO: Navigate to security settings
                },
              ),
            ]),

            const SizedBox(height: 20),

            _buildMenuSection('Uygulaması', [
              _MenuOption(
                icon: Icons.videocam,
                title: 'Kamera İzinleri',
                subtitle: 'Oyun alanı kamera erişimi',
                onTap: () {
                  // TODO: Navigate to camera permissions
                },
              ),
              _MenuOption(
                icon: Icons.help,
                title: 'Yardım & Destek',
                subtitle: 'SSS ve iletişim',
                onTap: () {
                  _showHelpDialog();
                },
              ),
              _MenuOption(
                icon: Icons.info,
                title: 'Hakkında',
                subtitle: 'Uygulama bilgileri ve sürüm',
                onTap: () {
                  _showAboutDialog();
                },
              ),
            ]),

            const SizedBox(height: 20),

            _buildMenuSection('Diğer', [
              _MenuOption(
                icon: Icons.share,
                title: 'Uygulamayı Paylaş',
                subtitle: 'Arkadaşlarınızla paylaşın',
                onTap: () {
                  // TODO: Share app
                },
              ),
              _MenuOption(
                icon: Icons.star_rate,
                title: 'Uygulamayı Değerlendir',
                subtitle: 'App Store\'da değerlendirin',
                onTap: () {
                  // TODO: Rate app
                },
              ),
            ]),

            const SizedBox(height: 30),

            // Çıkış yap butonu
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.exit_to_app, color: AppColors.error),
                label: const Text(
                  'Çıkış Yap',
                  style: TextStyle(color: AppColors.error),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Uygulama sürümü
            Text(
              'Kidstopia v1.0.0',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.grey500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<_MenuOption> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.grey600,
            ),
          ),
        ),
        Card(
          child: Column(
            children: options.map((option) {
              final isLast = option == options.last;
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.secondary,
                      child: Icon(
                        option.icon,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      option.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: option.subtitle != null
                        ? Text(
                            option.subtitle!,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        : null,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: option.onTap,
                  ),
                  if (!isLast) const Divider(height: 1),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) => _EditProfileDialog(
        currentName: userName,
        currentEmail: userEmail,
        onSave: (name, email) {
          setState(() {
            userName = name;
            userEmail = email;
          });
        },
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yardım & Destek'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Destek için bizimle iletişime geçin:'),
            SizedBox(height: 12),
            Text('📞 Telefon: +90 555 123 45 67'),
            Text('📧 E-posta: destek@kidstopia.com'),
            Text('🌐 Web: www.kidstopia.com'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Kidstopia',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.child_care, size: 32, color: AppColors.primary),
      ),
      children: const [
        Text('Çocuk oyun alanı yönetim sistemi'),
        SizedBox(height: 8),
        Text('© 2025 Kidstopia Team'),
      ],
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text('Hesabınızdan çıkmak istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const KidstopiaApp()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Çıkış Yap'),
          ),
        ],
      ),
    );
  }
}

class _MenuOption {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  _MenuOption({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });
}

class _EditProfileDialog extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final Function(String, String) onSave;

  const _EditProfileDialog({
    required this.currentName,
    required this.currentEmail,
    required this.onSave,
  });

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Profili Düzenle'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ad Soyad',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Lütfen adınızı girin';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-posta (Opsiyonel)',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (!value.contains('@')) {
                    return 'Geçerli bir e-posta adresi girin';
                  }
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSave(
                _nameController.text.trim(),
                _emailController.text.trim(),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
