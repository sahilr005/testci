class ApiAppConstants {
  // Network Constants

  static String apiEndPoint = "https://platform.dev.flexabledats.com/api/v1.0/";
  static String prodapiEndPoint = "https://platform.flexabledats.com/api/v1.0/";

  static const String auth = 'auth/supabase';
  static const String authGoogle = 'auth/google';
  // Services --> public
  static const String services = 'orgservstaff/org-services';
          //  --> Org staff
  static const String datspost = 'org/public/redeem-ticket';
  static const String datsCodepost = 'org/public/redeem-ticket-with-code';

  // Org
  static const String getorgpart = 'services/user/get-services';
  static const String getorg = 'org/user/get-org';
}
