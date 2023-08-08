class StudentDetails {
  // 0 2 3 6 9
  StudentDetails(
      {required this.name,
      required this.branch,
      required this.rollNo,
      required this.studentPhoneNumber,
      required this.parentsPhoneNumber,
      this.outTime,
      this.outDate,
      this.inDate,
      this.intime,
      this.isVerified
      });
  final String name;
  final String branch;
  final String rollNo;
  final String studentPhoneNumber;
  final String parentsPhoneNumber;
  final String? intime;
  final String? inDate;
  final String? outTime;
  final String? outDate;
  final bool? isVerified;
}
