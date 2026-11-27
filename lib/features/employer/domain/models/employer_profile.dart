class EmployerProfile {
  const EmployerProfile({
    required this.employerId,
    required this.companyName,
    required this.industry,
    required this.description,
    this.location,
    this.website,
    this.phone,
    this.logoUrl,
  });

  final String employerId;
  final String companyName;
  final String industry;
  final String description;
  final String? location;
  final String? website;
  final String? phone;
  final String? logoUrl;

  EmployerProfile copyWith({
    String? companyName,
    String? industry,
    String? description,
    String? location,
    String? website,
    String? phone,
    String? logoUrl,
  }) {
    return EmployerProfile(
      employerId: employerId,
      companyName: companyName ?? this.companyName,
      industry: industry ?? this.industry,
      description: description ?? this.description,
      location: location ?? this.location,
      website: website ?? this.website,
      phone: phone ?? this.phone,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }
}
