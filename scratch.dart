import 'dart:convert';

void main() {
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImY3ZDA1NjYzLTE5NGYtNDkzNi1iODliLTgzODIzNmQzZDRjNCIsImlkIjoiZjdkMDU2NjMtMTk0Zi00OTM2LWI4OWItODM4MjM2ZDNkNGM0IiwiZW1haWwiOiJwYXJlbnQyMkBnbWFpbC5jb20iLCJqdGkiOiI3MWI4ZjA2MC1jNDlkLTRjMzUtYmM4Mi0xNmRiZjUwOTUwNWUiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJQYXJlbnQiLCJleHAiOjE3ODIyMjI2MTAsImlzcyI6IkxlYXJuaWZ5U3lzdGVtIiwiYXVkIjoiTGVhcm5pZnlDbGllbnRzIn0.LsaurXatTzskkQgdTl21MpjgQzAJiAHqGi9xCy-5lvM";
  String? role;
  try {
    final parts = token.split('.');
    if (parts.length == 3) {
      final payloadString = parts[1];
      final normalized = base64Url.normalize(payloadString);
      final decodedPayload = utf8.decode(base64Url.decode(normalized));
      final Map<String, dynamic> payloadMap = json.decode(decodedPayload);
      
      role = payloadMap['role']?.toString() ?? 
             payloadMap['http://schemas.microsoft.com/ws/2008/06/identity/claims/role']?.toString();
      print("Role decoded: $role");
    }
  } catch (e) {
    print("Error: $e");
  }
}
