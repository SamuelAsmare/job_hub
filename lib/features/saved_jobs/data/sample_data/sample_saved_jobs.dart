import '../../domain/models/saved_job.dart';

const sampleUserId = 'user_001';

final sampleSavedJobs = <SavedJob>[
  SavedJob(
    id: 'saved_001',
    userId: sampleUserId,
    jobId: 'job_001',
    savedAt: DateTime(2026, 11, 20, 10, 30),
  ),
  SavedJob(
    id: 'saved_002',
    userId: sampleUserId,
    jobId: 'job_002',
    savedAt: DateTime(2026, 11, 22, 14, 15),
  ),
  SavedJob(
    id: 'saved_003',
    userId: sampleUserId,
    jobId: 'job_003',
    savedAt: DateTime(2026, 11, 24, 9, 0),
  ),
  SavedJob(
    id: 'saved_004',
    userId: 'user_002',
    jobId: 'job_001',
    savedAt: DateTime(2026, 11, 25, 8, 45),
  ),
];
