import '../../domain/models/notification.dart';

const String sampleUserId = 'user_001';

final List<Notification> sampleNotifications = [
  Notification(
    id: 'notif_001',
    userId: sampleUserId,
    title: 'Application Shortlisted',
    message: 'Congratulations! Your application for Senior Flutter Developer at TechCorp has been shortlisted.',
    type: 'application_status',
    isRead: false,
    createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
  ),
  Notification(
    id: 'notif_002',
    userId: sampleUserId,
    title: 'New Message from Recruiter',
    message: 'Hi Natnael, would you be available for a technical interview this Thursday at 10:00 AM?',
    type: 'message',
    isRead: false,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Notification(
    id: 'notif_003',
    userId: sampleUserId,
    title: 'New Job Alert',
    message: 'A new job matching your profile was posted: Mobile Engineer at Google.',
    type: 'job_alert',
    isRead: true,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Notification(
    id: 'notif_004',
    userId: sampleUserId,
    title: 'Application Received',
    message: 'Your application for Full-Stack Developer at InnovateTech was successfully submitted.',
    type: 'application_status',
    isRead: true,
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
  Notification(
    id: 'notif_005',
    userId: 'user_002',
    title: 'Welcome to JobHub',
    message: 'Complete your profile to start receiving tailored job recommendations.',
    type: 'system',
    isRead: false,
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
];
