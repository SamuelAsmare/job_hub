import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../jobs/domain/models/job.dart';
import '../providers/employer_provider.dart';

class PostVacancyScreen extends ConsumerStatefulWidget {
  const PostVacancyScreen({
    super.key,
    this.vacancyId,
  });

  final String? vacancyId;

  @override
  ConsumerState<PostVacancyScreen> createState() => _PostVacancyScreenState();
}

class _PostVacancyScreenState extends ConsumerState<PostVacancyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _locationController = TextEditingController();
  final _salaryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requirementsController = TextEditingController();

  String _employmentType = 'Full-time';
  bool _isSaving = false;
  bool _initialized = false;

  bool get _isEditing => widget.vacancyId != null;

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    _descriptionController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }

  void _populateForm(Job job) {
    if (_initialized) return;

    _titleController.text = job.title;
    _companyController.text = job.companyName;
    _locationController.text = job.location;
    _salaryController.text = job.salary ?? '';
    _descriptionController.text = job.description;
    _requirementsController.text = job.requirements.join('\n');
    _employmentType = job.employmentType;
    _initialized = true;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final employerId = ref.read(employerIdProvider);
      final repository = ref.read(employerRepositoryProvider);

      final existing = _isEditing
          ? await repository.getVacancyById(
              employerId: employerId,
              vacancyId: widget.vacancyId!,
            )
          : null;

      if (_isEditing && existing == null) {
        throw StateError('Vacancy not found or access denied.');
      }

      final vacancy = Job(
        id: existing?.id ?? '',
        title: _titleController.text.trim(),
        companyName: _companyController.text.trim(),
        location: _locationController.text.trim(),
        description: _descriptionController.text.trim(),
        requirements: _requirementsController.text
            .split('\n')
            .map((item) => item.trim())
            .where((item) => item.isNotEmpty)
            .toList(),
        employmentType: _employmentType,
        salary: _salaryController.text.trim().isEmpty
            ? null
            : _salaryController.text.trim(),
        postedAt: existing?.postedAt ?? DateTime.now(),
        deadline: existing?.deadline,
        employerId: employerId,
      );

      late final Job saved;

      if (_isEditing) {
        await repository.updateVacancy(vacancy);
        saved = vacancy;
      } else {
        saved = await repository.createVacancy(vacancy);
      }

      ref.invalidate(employerVacanciesProvider(employerId));
      ref.invalidate(
        employerVacancyProvider((
          employerId: employerId,
          vacancyId: saved.id,
        )),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'Vacancy updated successfully.'
                : 'Vacancy posted successfully.',
          ),
        ),
      );

      context.go(RouteNames.vacancyDetailsPath(saved.id));
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save vacancy: $error')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final employerId = ref.watch(employerIdProvider);

    final vacancyAsync = _isEditing
        ? ref.watch(
            employerVacancyProvider((
              employerId: employerId,
              vacancyId: widget.vacancyId!,
            )),
          )
        : null;

    if (_isEditing && !_initialized) {
      return vacancyAsync!.when(
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          appBar: AppBar(title: const Text('Edit Vacancy')),
          body: Center(child: Text('Could not load vacancy: $error')),
        ),
        data: (job) {
          if (job == null) {
            return const Scaffold(
              body: Center(child: Text('Vacancy not found.')),
            );
          }
          _populateForm(job);
          return _buildForm();
        },
      );
    }

    return _buildForm();
  }

  Widget _buildForm() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Vacancy' : 'Post Vacancy'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _field(_titleController, 'Job Title'),
            _field(_companyController, 'Company Name'),
            _field(_locationController, 'Location'),
            DropdownButtonFormField<String>(
              initialValue: _employmentType,
              decoration: const InputDecoration(
                labelText: 'Employment Type',
                border: OutlineInputBorder(),
              ),
              items: const [
                'Full-time',
                'Part-time',
                'Contract',
                'Internship',
                'Remote',
              ].map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _employmentType = value);
                }
              },
            ),
            const SizedBox(height: 16),
            _field(_salaryController, 'Salary (optional)', required: false),
            _field(
              _descriptionController,
              'Job Description',
              maxLines: 5,
            ),
            _field(
              _requirementsController,
              'Requirements (one per line)',
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _isSaving ? null : _save,
              icon: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(_isEditing ? 'Save Changes' : 'Publish Vacancy'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          alignLabelWithHint: maxLines > 1,
        ),
        validator: required
            ? (value) => value == null || value.trim().isEmpty
                ? 'This field is required'
                : null
            : null,
      ),
    );
  }
}
