import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> databasePath(String fileName) async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  return join(documentsDirectory.path, fileName);
}
