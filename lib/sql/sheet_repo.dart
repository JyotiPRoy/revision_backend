import 'package:revision_backend/model/result.dart';
import 'package:revision_backend/model/sheet.dart';
import 'package:revision_backend/revision_backend.dart';

class SheetRepository {
  final ManagedContext context;

  SheetRepository({required this.context});

  Future<Result<List<Sheet>>> getAllSheets() async {
    try {
      final query = Query<Sheet>(context);
      final sheets = await query.fetch();

      return Result(data: sheets);
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.getAllSheet(), Reason: ${e.toString()}",
      );
    }
  }

  Future<Result<String>> addSheet(Sheet sheet) async {
    try {
      final query = Query<Sheet>(context)..values = sheet;
      final insertedSheet = await query.insert();

      return Result(data: insertedSheet.id);
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.addSheet(), Reason: ${e.toString()}",
      );
    }
  }

  Future<Result<Sheet>> updateSheet(Sheet sheet) async {
    try {
      final query = Query<Sheet>(context)
        ..values.title = sheet.title
        ..where((s) => s.id).equalTo(sheet.id);

      final update = await query.updateOne();
      return Result(data: update);
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.updateSheet(), Reason: ${e.toString()}",
      );
    }
  }
}
