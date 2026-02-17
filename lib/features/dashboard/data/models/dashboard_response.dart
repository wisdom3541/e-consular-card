class DashboardResponse {
  final String status;
  final DashboardData data;

  DashboardResponse({
    required this.status,
    required this.data,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      status: json['status'] ?? '',
      data: DashboardData.fromJson(json['data']),
    );
  }

  bool get isSuccess => status.toLowerCase() == 'success';
}

class DashboardData {
  final DashboardUser user;
  final DashboardStats stats;
  final List<RecentTransaction> recentTransactions;
  final PaginationInfo pagination;

  DashboardData({
    required this.user,
    required this.stats,
    required this.recentTransactions,
    required this.pagination,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      user: DashboardUser.fromJson(json['user']),
      stats: DashboardStats.fromJson(json['stats']),
      recentTransactions: (json['recent_transactions'] as List<dynamic>?)
              ?.map((e) => RecentTransaction.fromJson(e))
              .toList() ??
          [],
      pagination: PaginationInfo.fromJson(json['pagination']),
    );
  }
}

class DashboardUser {
  final String id;
  final String email;
  final String nin;
  final String? birthCertificate;
  final String firstname;
  final String? middleName;
  final String surname;
  final String gender;
  final String birthdate;
  final String maritalStatus;
  final int? numberOfChildren;
  final String? motherMaidenName;
  final String? height;
  final String? educationalQualification;
  final String? profession;
  final String? citizenBy;
  final String? residenceAddress;
  final int? stateId;
  final int? lgaId;
  final int? countryId;
  final String? assignedStaffId;
  final String? emailVerifiedAt;
  final String phone;
  final String? whatsapp;
  final String? foreignAddress;
  final String? meansOfIdentification;
  final String? documentIdNumber;
  final String? expiryDate;
  final String channel;
  final String? regOrigin;
  final String regStatus;
  final String approvalStatus;
  final String? rejectionReason;
  final String createdAt;
  final String updatedAt;

  DashboardUser({
    required this.id,
    required this.email,
    required this.nin,
    this.birthCertificate,
    required this.firstname,
    this.middleName,
    required this.surname,
    required this.gender,
    required this.birthdate,
    required this.maritalStatus,
    this.numberOfChildren,
    this.motherMaidenName,
    this.height,
    this.educationalQualification,
    this.profession,
    this.citizenBy,
    this.residenceAddress,
    this.stateId,
    this.lgaId,
    this.countryId,
    this.assignedStaffId,
    this.emailVerifiedAt,
    required this.phone,
    this.whatsapp,
    this.foreignAddress,
    this.meansOfIdentification,
    this.documentIdNumber,
    this.expiryDate,
    required this.channel,
    this.regOrigin,
    required this.regStatus,
    required this.approvalStatus,
    this.rejectionReason,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DashboardUser.fromJson(Map<String, dynamic> json) {
    return DashboardUser(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      nin: json['nin']?.toString() ?? '',
      birthCertificate: json['birth_certificate']?.toString(),
      firstname: json['firstname']?.toString() ?? '',
      middleName: json['middle_name']?.toString(),
      surname: json['surname']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      birthdate: json['birthdate']?.toString() ?? '',
      maritalStatus: json['marital_status']?.toString() ?? '',
      numberOfChildren: json['number_of_children'] != null
          ? int.tryParse(json['number_of_children'].toString())
          : null,
      motherMaidenName: json['mother_maiden_name']?.toString(),
      height: json['height']?.toString(),
      educationalQualification: json['educational_qualification']?.toString(),
      profession: json['profession']?.toString(),
      citizenBy: json['citizen_by']?.toString(),
      residenceAddress: json['residence_address']?.toString(),
      stateId: json['state_id'] != null
          ? int.tryParse(json['state_id'].toString())
          : null,
      lgaId: json['lga_id'] != null
          ? int.tryParse(json['lga_id'].toString())
          : null,
      countryId: json['country_id'] != null
          ? int.tryParse(json['country_id'].toString())
          : null,
      assignedStaffId: json['assigned_staff_id']?.toString(),
      emailVerifiedAt: json['email_verified_at']?.toString(),
      phone: json['phone']?.toString() ?? '',
      whatsapp: json['whatsapp']?.toString(),
      foreignAddress: json['foreign_address']?.toString(),
      meansOfIdentification: json['means_of_identification']?.toString(),
      documentIdNumber: json['document_id_number']?.toString(),
      expiryDate: json['expiry_date']?.toString(),
      channel: json['channel']?.toString() ?? '',
      regOrigin: json['reg_origin']?.toString(),
      regStatus: json['reg_status']?.toString() ?? '',
      approvalStatus: json['approval_status']?.toString() ?? '',
      rejectionReason: json['rejection_reason']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  String get fullName {
    final parts = [firstname, middleName, surname].where((p) => p != null && p.isNotEmpty);
    return parts.join(' ');
  }

  bool get isApproved => approvalStatus.toLowerCase() == 'approved';
  bool get isPending => approvalStatus.toLowerCase() == 'pending';
  bool get isRejected => approvalStatus.toLowerCase() == 'rejected';
}

class DashboardStats {
  final int pending;
  final int paid;
  final int total;

  DashboardStats({
    required this.pending,
    required this.paid,
    required this.total,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      pending: json['pending'] ?? 0,
      paid: json['paid'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}
class RecentTransaction {
  final String transactionId;
  final String name;
  final String description;
  final String status;
  final String date;
  final String type;
  final double amount;

  RecentTransaction({
    required this.transactionId,
    required this.name,
    required this.description,
    required this.status,
    required this.date,
    required this.type,
    required this.amount,
  });

  factory RecentTransaction.fromJson(Map<String, dynamic> json) {
    return RecentTransaction(
      transactionId: json['tid']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['desc']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      amount: double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0,
    );
  }
}


class PaginationInfo {
  final int currentPage;
  final int lastPage;
  final int total;
  final int perPage;

  PaginationInfo({
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.perPage,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 10,
    );
  }
}