class Donation {
  int amount;
  String status;
  String donated_by;
  String uid;
  DateTime donation_time;

  Donation(this.amount, this.status, this.donated_by, this.uid, this.donation_time );

  Map<String, dynamic> toJson() => {
    'num_of_items': amount,
    'status': status,
    'donated_by': donated_by,
    'uid': uid,
    'date': donation_time,
  };
// formatting for upload to Firebase when creating the request

}