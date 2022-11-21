import 'package:flexable/controller/supabase.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final box = GetStorage();
final client = SupabaseClient(supabaseUrl, supabasetoken);
final supabaseClient = SupabaseManager();
const supabasetoken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhldnZqeHh0a2JwYXJvYWZhaXVhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Njc0MDIxOTIsImV4cCI6MTk4Mjk3ODE5Mn0.xw_5PfSMp22L9VEB_56Wf8DQbXd161I3TZqjUKYjzK0";

const supabaseUrl = "https://hevvjxxtkbparoafaiua.supabase.co";
const imageBaseUrl = "https://nftstorage.link/ipfs/";
