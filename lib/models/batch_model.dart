class BatchModel {
  final String id;
  final String kumbungId;
  final String batchName;
  final int baglogCount;
  final String inoculationDate;
  final String estimatedHarvestDate;
  final String growthStatus;
  final int growthProgress;
  final String? notes;
  final int isSynced;
  final int isDeleted;
  final String createdAt;
  final String updatedAt;

  BatchModel({
    required this.id,
    required this.kumbungId,
    required this.batchName,
    required this.baglogCount,
    required this.inoculationDate,
    required this.estimatedHarvestDate,
    required this.growthStatus,
    this.growthProgress = 0,
    this.notes,
    this.isSynced = 0,
    this.isDeleted = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  // Untuk simpan ke SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kumbung_id': kumbungId,
      'batch_name': batchName,
      'baglog_count': baglogCount,
      'inoculation_date': inoculationDate,
      'estimated_harvest_date': estimatedHarvestDate,
      'growth_status': growthStatus,
      'growth_progress': growthProgress,
      'notes': notes,
      'is_synced': isSynced,
      'is_deleted': isDeleted,
      'create_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Untuk baca dari SQLite
  factory BatchModel.fromMap(Map<String, dynamic> map) {
    return BatchModel(
      id: map['id'] as String,
      kumbungId: map['kumbung_id'] as String,
      batchName: map['batch_name'] as String,
      baglogCount: map['baglog_count'] as int,
      inoculationDate: map['inoculation_date'] as String,
      estimatedHarvestDate: map['estimated_harvest_date'] as String,
      growthStatus: map['growth_status'] as String,
      growthProgress: (map['growth_progress'] as int?) ?? 0,
      notes: map['notes'] as String?,
      isSynced: (map['is_synced'] as int?) ?? 0,
      isDeleted: (map['is_deleted'] as int?) ?? 0,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  // Untuk sinkronisasi ke Firebase Realtime Database
  Map<String, dynamic> toJson() {
    return {
      'kumbung_id': kumbungId,
      'batch_name': batchName,
      'baglog_count': baglogCount,
      'inoculation_date': inoculationDate,
      'estimated_harvest_date': estimatedHarvestDate,
      'growth_status': growthStatus,
      'growth_progress': growthProgress,
      'notes': notes,
      'updated_at': updatedAt,
    };
  }
}
