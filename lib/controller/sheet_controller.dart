import 'package:get_it/get_it.dart';
import 'package:revision_backend/model/sheet.dart';
import 'package:revision_backend/revision_backend.dart';
import 'package:revision_backend/sql/db_service.dart';

class SheetController extends ResourceController {
  late DatabaseService dbService;

  SheetController() {
    final getIt = GetIt.instance;
    dbService = getIt<DatabaseService>();
  }

  @Operation.get()
  Future<Response> getAllSheets() async {
    return dbService.getAllSheets();
  }

  //TODO: Protect post/delete/put with api keys, see conduit docs
  @Operation.post()
  Future<Response> addSheet(@Bind.body() Sheet sheet) async {
    return dbService.addSheet(sheet);
  }

  @Operation.put()
  Future<Response> updateSheet(@Bind.body() Sheet sheet) async {
    return dbService.updateSheet(sheet);
  }
}
