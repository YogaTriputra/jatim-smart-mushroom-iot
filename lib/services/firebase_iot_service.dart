import 'package:firebase_database/firebase_database.dart';
import '../core/app_constants.dart';
import '../models/iot_models.dart';

class FirebaseIotService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  DatabaseReference _kumbungRef([String kumbungId = AppConstants.defaultKumbungId]) {
    return _db.child('kumbungs/$kumbungId');
  }

  // Stream: otomatis mengirim data baru ke UI setiap kali ESP32 update sensor
  Stream<SensorData> streamCurrentSensor([String kumbungId = AppConstants.defaultKumbungId]) {
    return _kumbungRef(kumbungId).child('sensor_current').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      return SensorData.fromMap(data);
    });
  }

  // Stream status aktuator (Mist Maker & Exhaust Fan)
  Stream<ActuatorState> streamActuator([String kumbungId = AppConstants.defaultKumbungId]) {
    return _kumbungRef(kumbungId).child('actuator').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      return ActuatorState.fromMap(data);
    });
  }

  // Mengubah mode ('auto' / 'manual') atau status relay secara manual
  Future<void> updateActuator({
    String kumbungId = AppConstants.defaultKumbungId,
    String? mode,
    bool? mistMaker,
    bool? exhaustFan,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': ServerValue.timestamp,
    };
    if (mode != null) updates['mode'] = mode;
    if (mistMaker != null) updates['mist_maker'] = mistMaker;
    if (exhaustFan != null) updates['exhaust_fan'] = exhaustFan;

    await _kumbungRef(kumbungId).child('actuator').update(updates);
  }

  // Memperbarui ambang batas otomatis di ESP32
  Future<void> updateThresholds(
    ThresholdsModel thresholds, {
    String kumbungId = AppConstants.defaultKumbungId,
  }) async {
    await _kumbungRef(kumbungId).child('thresholds').update(thresholds.toJson());
  }
}