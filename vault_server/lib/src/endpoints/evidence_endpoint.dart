import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class EvidenceEndpoint extends Endpoint{

  Future<EvidenceRecord> createEvidenceRecord(Session session, String hash, String? note,) async{
    final row = EvidenceRecord(hash: hash, note: note , createdAt: DateTime.now());
    return await EvidenceRecord.db.insertRow(session, row);
  }

  Future<List<EvidenceRecord>> listEvidenceRecords(Session session) async{
    return EvidenceRecord.db.find(session, orderBy: (t) => t.createdAt, orderDescending: true  );

  }

  Future<bool> verifyEvidence(Session session, int evidenceId, String hashin) async{
    final rec = await EvidenceRecord.db.findById(session, evidenceId);
    if (rec == null) return false ;
    return rec.hash == hashin ;
  }


}