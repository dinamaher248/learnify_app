import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learnify_app/core/utils/color.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  void _copyPhoneNumber(BuildContext context, String phoneNumber) {
    Clipboard.setData(ClipboardData(text: phoneNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Phone number copied to clipboard!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Support',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            
            // Support Icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.support_agent,
                size: 80,
                color: AppColors.primaryColor,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Title
            const Text(
              'Need Help?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Subtitle
            Text(
              'Contact our support team',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Phone Numbers
            _buildPhoneCard(
              context: context,
              phoneNumber: '19700',
              label: 'Hotline',
            ),
            
            const SizedBox(height: 16),
            
            _buildPhoneCard(
              context: context,
              phoneNumber: '16800',
              label: 'Customer Service',
            ),
            
            const SizedBox(height: 16),
            
            _buildPhoneCard(
              context: context,
              phoneNumber: '01277545001',
              label: 'Direct Support',
            ),
            
            const SizedBox(height: 16),
            
            _buildPhoneCard(
              context: context,
              phoneNumber: '01229093566',
              label: 'Technical Support',
            ),
            
            const SizedBox(height: 32),
            
            // Working Hours Info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.blue[200]!,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.blue[700],
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Working Hours',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Saturday - Thursday: 9:00 AM - 5:00 PM',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneCard({
    required BuildContext context,
    required String phoneNumber,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Phone Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.phone,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Phone Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phoneNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          
          // Call Button
          IconButton(
            onPressed: () => _makePhoneCall(phoneNumber),
            icon: const Icon(Icons.call),
            color: Colors.green,
            tooltip: 'Call',
          ),
          
          // Copy Button
          IconButton(
            onPressed: () => _copyPhoneNumber(context, phoneNumber),
            icon: const Icon(Icons.copy),
            color: Colors.grey[600],
            tooltip: 'Copy',
          ),
        ],
      ),
    );
  }
}
