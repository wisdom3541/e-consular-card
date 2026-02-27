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
  final String? cardReqStatus; 
  final CardStatus? cardStatus;

  DashboardData({
    required this.user,
    required this.stats,
    required this.recentTransactions,
    required this.pagination,
    this.cardReqStatus,
    this.cardStatus,
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
      cardReqStatus: json['card_req_status']?.toString(), 
      cardStatus: json['card_status'] != null 
          ? CardStatus.fromJson(json['card_status'])
          : null,
    );
  }

   // Helper getters
  bool get hasCardRequest => cardReqStatus != null && cardReqStatus != 'false';
  bool get isCardApproved => cardReqStatus?.toUpperCase() == 'APPROVED';
  bool get hasActiveCard => cardStatus?.isActive ?? false;
  bool get needsToCollectCard => cardStatus?.needsDeliveryCode ?? false;
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


// Add this at the bottom of the file

class CardStatus {
  final String cardNo;
  final bool alert;
  final String status;
  final String note;
  final bool printed;
  final String? deliveryCode;
  final bool delivered;
  final String? printedAt;
  final CardDetails? card;
  final bool? paidDelivery;

  CardStatus({
    required this.cardNo,
    required this.alert,
    required this.status,
    required this.note,
    required this.printed,
    this.deliveryCode,
    required this.delivered,
    this.printedAt,
    this.card,
    this.paidDelivery,
  });

  factory CardStatus.fromJson(Map<String, dynamic> json) {
    return CardStatus(
      cardNo: json['cardno']?.toString() ?? 'NA',
      alert: json['alert'] == true || json['alert'] == 1,
      status: json['status']?.toString() ?? 'none',
      note: json['note']?.toString() ?? '',
      printed: json['printed'] == true || json['printed'] == 1,
      deliveryCode: json['delivery_code']?.toString(),
      delivered: json['delivered'] == true || json['delivered'] == 1,
      printedAt: json['printed_at']?.toString(),
      card: json['card'] != null ? CardDetails.fromJson(json['card']) : null,
      paidDelivery: json['paid_delivery'] == true || json['paid_delivery'] == 1,
    );
  }

  // Helper getters
  bool get hasCard => status != 'none';
  bool get isActive => status == 'active';
  bool get isPrinted => printed;
  bool get isDelivered => delivered;
  bool get needsDeliveryCode => printed && !delivered && deliveryCode != null;
  bool get hasPaidDelivery => paidDelivery == true;
}

class CardDetails {
  final String id;
  final String userId;
  final String paymentId;
  final String citizenCardNo;
  final String requestType;
  final String requestKey;
  final String status;
  final String paymentStatus;
  final String? approvedBy;
  final String countryId;
  final bool cardPrinted;
  final String? deliveryCode;
  final bool cardDelivered;
  final bool exported;
  final String? token;
  final String? qrBase64;
  final String? printedAt;
  final String? deliveredAt;
  final String expirationDate;
  final bool paidDelivery;
  final String createdAt;
  final String updatedAt;

  CardDetails({
    required this.id,
    required this.userId,
    required this.paymentId,
    required this.citizenCardNo,
    required this.requestType,
    required this.requestKey,
    required this.status,
    required this.paymentStatus,
    this.approvedBy,
    required this.countryId,
    required this.cardPrinted,
    this.deliveryCode,
    required this.cardDelivered,
    required this.exported,
    this.token,
    this.qrBase64,
    this.printedAt,
    this.deliveredAt,
    required this.expirationDate,
    required this.paidDelivery,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    return CardDetails(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      paymentId: json['payment_id']?.toString() ?? '',
      citizenCardNo: json['citizen_card_no']?.toString() ?? '',
      requestType: json['request_type']?.toString() ?? '',
      requestKey: json['request_key']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      paymentStatus: json['payment_status']?.toString() ?? '',
      approvedBy: json['approved_by']?.toString(),
      countryId: json['country_id']?.toString() ?? '',
      cardPrinted: json['card_printed'] == 1 || json['card_printed'] == true,
      deliveryCode: json['delivery_code']?.toString(),
      cardDelivered: json['card_delivered'] == 1 || json['card_delivered'] == true,
      exported: json['exported'] == 1 || json['exported'] == true,
      token: json['token']?.toString(),
      qrBase64: json['qr_base64']?.toString(),
      printedAt: json['printed_at']?.toString(),
      deliveredAt: json['delivered_at']?.toString(),
      expirationDate: json['expiration_date']?.toString() ?? '',
      paidDelivery: json['paid_delivery'] == true || json['paid_delivery'] == 1,
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  bool get isApproved => status.toUpperCase() == 'APPROVED';
  bool get isPaid => paymentStatus.toUpperCase() == 'PAID';
}