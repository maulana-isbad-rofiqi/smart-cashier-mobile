import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color(0xFF2196F3),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Pengaturan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF2196F3),
                      Color(0xFF1976D2),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Store Information
                  _buildSectionCard(
                    'Informasi Toko',
                    [
                      _buildSettingsTile(
                        icon: Icons.store,
                        title: 'Nama Toko',
                        subtitle: 'Smart Cashier AI',
                        onTap: () => _showEditDialog(context, 'Nama Toko', 'Smart Cashier AI'),
                      ),
                      _buildSettingsTile(
                        icon: Icons.location_on,
                        title: 'Alamat',
                        subtitle: 'Jl. Sudirman No. 123, Jakarta',
                        onTap: () => _showEditDialog(context, 'Alamat', 'Jl. Sudirman No. 123, Jakarta'),
                      ),
                      _buildSettingsTile(
                        icon: Icons.phone,
                        title: 'Telepon',
                        subtitle: '+62 21 1234 5678',
                        onTap: () => _showEditDialog(context, 'Telepon', '+62 21 1234 5678'),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // App Settings
                  _buildSectionCard(
                    'Pengaturan Aplikasi',
                    [
                      _buildSettingsTile(
                        icon: Icons.palette,
                        title: 'Tema',
                        subtitle: 'Terang',
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () => _showThemeDialog(context),
                      ),
                      _buildSettingsTile(
                        icon: Icons.language,
                        title: 'Bahasa',
                        subtitle: 'Indonesia',
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () => _showLanguageDialog(context),
                      ),
                      _buildSettingsTile(
                        icon: Icons.notifications,
                        title: 'Notifikasi',
                        subtitle: 'Aktif',
                        trailing: Switch(
                          value: true,
                          onChanged: (value) {
                            // Handle notification toggle
                          },
                          activeColor: const Color(0xFF2196F3),
                        ),
                        onTap: null,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Cart Settings
                  _buildSectionCard(
                    'Pengaturan Keranjang',
                    [
                      _buildSettingsTile(
                        icon: Icons.shopping_cart,
                        title: 'Auto Simpan Keranjang',
                        subtitle: 'Simpan keranjang secara otomatis',
                        trailing: Switch(
                          value: true,
                          onChanged: (value) {
                            // Handle auto save toggle
                          },
                          activeColor: const Color(0xFF2196F3),
                        ),
                        onTap: null,
                      ),
                      _buildSettingsTile(
                        icon: Icons.clear_all,
                        title: 'Kosongkan Keranjang',
                        subtitle: 'Hapus semua item di keranjang',
                        trailing: Consumer<CartService>(
                          builder: (context, cartService, child) {
                            return ElevatedButton(
                              onPressed: cartService.isEmpty 
                                  ? null 
                                  : () => _showClearCartDialog(context, cartService),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                              child: const Text('Kosongkan'),
                            );
                          },
                        ),
                        onTap: null,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // About
                  _buildSectionCard(
                    'Tentang Aplikasi',
                    [
                      _buildSettingsTile(
                        icon: Icons.info,
                        title: 'Versi Aplikasi',
                        subtitle: '1.0.0',
                        onTap: null,
                      ),
                      _buildSettingsTile(
                        icon: Icons.help,
                        title: 'Bantuan',
                        subtitle: 'Panduan penggunaan',
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () => _showHelpDialog(context),
                      ),
                      _buildSettingsTile(
                        icon: Icons.feedback,
                        title: 'Kirim Feedback',
                        subtitle: 'Berikan saran dan批评',
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () => _showFeedbackDialog(context),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Sign Out Button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _showSignOutDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.logout),
                      label: const Text('Keluar'),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF2196F3).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF2196F3),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right, color: Colors.grey) : null),
      onTap: onTap,
    );
  }

  void _showEditDialog(BuildContext context, String title, String currentValue) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              // Save the new value
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$title berhasil diperbarui'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Tema'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: const Text('Terang'),
              subtitle: const Text('Tema terang (saat ini)'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Gelap'),
              subtitle: const Text('Tema gelap (belum tersedia)'),
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Bahasa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Indonesia'),
              subtitle: const Text('Bahasa Indonesia (saat ini)'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('English'),
              subtitle: const Text('Bahasa Inggris'),
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bantuan'),
        content: const Text(
          'Selamat datang di Smart Cashier AI! \n\n'
          'Aplikasi ini membantu Anda mengelola toko dengan mudah. '
          'Gunakan fitur scan produk atau pencarian untuk menambah item ke keranjang.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kirim Feedback'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tulis saran atau批评 Anda:'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Pesan',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Terima kasih atas feedback Anda!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Keluar'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle sign out
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Anda telah keluar dari aplikasi'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Keluar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, CartService cartService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kosongkan Keranjang'),
        content: const Text('Apakah Anda yakin ingin mengosongkan keranjang?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              cartService.clearCart();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Keranjang telah dikosongkan'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Kosongkan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}