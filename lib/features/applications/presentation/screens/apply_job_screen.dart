import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../jobs/domain/models/job.dart';
import '../../domain/models/application.dart';
import '../providers/application_provider.dart';

class ApplyJobScreen extends ConsumerStatefulWidget {
  const ApplyJobScreen({
    required this.job,
    required this.applicantId,
    super.key,
  });

  final Job job;
  final String applicantId;

  @override
  ConsumerState<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends ConsumerState<ApplyJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _coverLetterController = TextEditingController();

  PlatformFile? _selectedCv;
  bool _isSubmitting = false;
  bool _isRequestingAiReview = false;

  @override
  void dispose() {
    _coverLetterController.dispose();
    super.dispose();
  }

  Future<void> _pickCv() async {
    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );

      if (!mounted || files.isEmpty) {
        return;
      }

      setState(() {
        _selectedCv = files.first;
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not select CV: $error')),
      );
    }
  }

  Future<void> _requestAiReview() async {
    if (_selectedCv == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your CV first.')),
      );
      return;
    }

    setState(() {
      _isRequestingAiReview = true;
    });

    // AI review needs a real backend service.
    // We do not generate fake feedback or expose API keys in Flutter.
    await Future<void>.delayed(Duration.zero);

    if (!mounted) return;

    setState(() {
      _isRequestingAiReview = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'AI review is not connected yet. You can still submit your application.',
        ),
      ),
    );
  }

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCv == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your CV.')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final repository = ref.read(applicationRepositoryProvider);

      final alreadyApplied = await repository.hasAlreadyApplied(
        widget.job.id,
        widget.applicantId,
      );

      if (alreadyApplied) {
        throw Exception('You have already applied for this job.');
      }

      final application = Application(
        id: '${widget.job.id}_${widget.applicantId}_'
            '${DateTime.now().microsecondsSinceEpoch}',
        jobId: widget.job.id,
        jobTitle: widget.job.title,
        companyName: widget.job.companyName,
        applicantId: widget.applicantId,
        cvReference: _selectedCv!.path ?? _selectedCv!.name,
        cvFileName: _selectedCv!.name,
        coverLetter: _coverLetterController.text.trim(),
        appliedAt: DateTime.now(),
        status: ApplicationStatus.pending,
      );

      await ref.read(applicationActionsProvider).submitApplication(application);

      ref.invalidate(applicationsProvider);
      ref.invalidate(applicationsByApplicantProvider(widget.applicantId));
      ref.invalidate(
        hasAlreadyAppliedProvider(
          ApplicationCheckParams(
            jobId: widget.job.id,
            applicantId: widget.applicantId,
          ),
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Application submitted successfully!'),
        ),
      );

      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Application failed: $error')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Job'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.job.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 6),
              Text(
                widget.job.companyName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 28),
              Text(
                'Your CV / Resume',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: _isSubmitting ? null : _pickCv,
                icon: const Icon(Icons.upload_file),
                label: const Text('Choose PDF or DOCX'),
              ),
              if (_selectedCv != null) ...[
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: Text(_selectedCv!.name),
                  subtitle: const Text('Selected CV'),
                  trailing: IconButton(
                    onPressed: _isSubmitting
                        ? null
                        : () {
                            setState(() {
                              _selectedCv = null;
                            });
                          },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Text(
                'AI Resume Review (Optional)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'Get suggestions about your CV before submitting. '
                'This feature will be available when the AI backend is connected.',
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: _isSubmitting || _isRequestingAiReview
                    ? null
                    : _requestAiReview,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Review my CV with AI'),
              ),
              const SizedBox(height: 24),
              Text(
                'Cover Letter',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _coverLetterController,
                maxLines: 8,
                maxLength: 3000,
                decoration: const InputDecoration(
                  hintText: 'Explain why you are interested in this position '
                      'and why you are a good fit...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please write a cover letter.';
                  }

                  if (value.trim().length < 30) {
                    return 'Your cover letter must contain at least 30 characters.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitApplication,
                  child: _isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text('Submit Application'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
