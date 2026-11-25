class HarvestModel {
  final String id;
  final String batchId;
  final String harvestDate;
  final double weightKg;
  final String qualityGrade; // 'A' | 'B' | 'C'
  final String qcStatus; // 'Lolos QC' | 'Lokal'
  final String? photoPath;
  final String? notes;
  final int isSynced;
  final int isDeleted;
  final String createdAt;
  final String updatedAt;

  HarvestModel({
    required this.id,
    required this.batchId,
    required this.harvestDate,
    required this.weightKg,
    required this.qualityGrade,
    this.qcStatus = 'Lokal',
    this.photoPath,
    this.notes,
    this.isSynced = 0,
    this.isDeleted = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'batch_id': batchId,
      'harvest_date': harvestDate,
      'weight_kg': weightKg,
      'quality_grade': qualityGrade,
      'qc_status': qcStatus,
      'photo_path': photoPath,
      'notes': notes,
      'is_synced': isSynced,
      'is_deleted': isDeleted,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory HarvestModel.fromMap(Map<String, dynamic> map) {
    return HarvestModel(
      id: map['id'] as String,
      batchId: map['batch_id'] as String,
      harvestDate: map['harvest_date'] as String,
      weightKg: (map['weight_kg'] as num).toDouble(),
      qualityGrade: map['quality_grade'] as String,
      qcStatus: (map['qc_status'] as String?) ?? 'Lokal',
      photoPath: map['photo_path'] as String?,
      notes: map['notes'] as String?,
      isSynced: (map['is_synced'] as int?) ?? 0,
      isDeleted: (map['is_deleted'] as int?) ?? 0,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batch_id': batchId,
      'harvest_date': harvestDate,
      'weight_kg': weightKg,
      'quality_grade': qualityGrade,
      'qc_status': qcStatus,
      'notes': notes,
      'updated_at': updatedAt,
    };
  }
}
