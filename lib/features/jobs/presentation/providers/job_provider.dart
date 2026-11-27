import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/datasources/job_local_datasource.dart';
import '../../data/repositories/job_repository_impl.dart';
import '../../data/services/location_service.dart';
import '../../domain/models/job.dart';
import '../../domain/repositories/job_repository.dart';

// Provides the location service.
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

/// Provides the user's current device location.
final currentLocationProvider = FutureProvider<Position>((ref) {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.getCurrentLocation();
});

// Provides the local data source.
final jobLocalDataSourceProvider = Provider<JobLocalDataSource>((ref) {
  return JobLocalDataSource();
});

// Provides the job repository.
final jobRepositoryProvider = Provider<JobRepository>((ref) {
  final dataSource = ref.watch(jobLocalDataSourceProvider);
  return JobRepositoryImpl(dataSource);
});

// Provides all available jobs.
final jobsProvider = FutureProvider<List<Job>>((ref) {
  final repository = ref.watch(jobRepositoryProvider);
  return repository.getJobs();
});

// Provides a single job by its ID.
final jobByIdProvider = FutureProvider.family<Job?, String>((ref, jobId) {
  final repository = ref.watch(jobRepositoryProvider);
  return repository.getJobById(jobId);
});

// Provides search results based on the search query.
final jobSearchProvider =
    FutureProvider.family<List<Job>, String>((ref, query) {
  final repository = ref.watch(jobRepositoryProvider);
  return repository.searchJobs(query);
});

/// Manages the active search query string in Riverpod instead of widget state.
class JobSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String value) => state = value.trim();

  void clear() => state = '';
}

final jobSearchQueryProvider =
    NotifierProvider<JobSearchQueryNotifier, String>(
  JobSearchQueryNotifier.new,
);

// Provides jobs posted by a specific employer.
final jobsByEmployerProvider =
    FutureProvider.family<List<Job>, String>((ref, employerId) {
  final repository = ref.watch(jobRepositoryProvider);
  return repository.getJobsByEmployer(employerId);
});

/// Provides nearby jobs using the user's current device location.
final nearbyJobsProvider =
    FutureProvider.family<List<Job>, double>((ref, radiusInKm) async {
  // Get the user's current GPS position.
  final position = await ref.watch(currentLocationProvider.future);

  // Get the job repository.
  final repository = ref.watch(jobRepositoryProvider);

  // Find jobs within the requested radius.
  return repository.getNearbyJobs(
    latitude: position.latitude,
    longitude: position.longitude,
    radiusInKm: radiusInKm,
  );
});

/// Holds the parameters required to search for nearby jobs.
class NearbyJobsParams {
  final double latitude;
  final double longitude;
  final double radiusInKm;

  const NearbyJobsParams({
    required this.latitude,
    required this.longitude,
    required this.radiusInKm,
  });
}
