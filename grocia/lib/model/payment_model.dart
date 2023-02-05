enum PaymentMethod { Card, NetBanking, Cash }

class PaymentModel {
  final PaymentMethod selectedPayment;
  final String? cardNumber;
  final DateTime? validity;
  final int? cvv;
  final String? cardName;
  final bool? saveCardDetails;
  final String? bankAccountNumber;
  final String? bankIFSCCode;
  final String? bankName;
  final bool? isCashOnDelivery;
  PaymentModel(
      {required this.selectedPayment,
      this.cardNumber,
      this.validity,
      this.cvv,
      this.cardName,
      this.saveCardDetails,
      this.bankAccountNumber,
      this.bankIFSCCode,
      this.bankName,
      this.isCashOnDelivery});

  PaymentModel copyTo(
          {PaymentMethod? paymentMethod,
          String? cardNumber,
          DateTime? validity,
          int? cvv,
          String? cardName,
          bool? saveCardDetails,
          String? bankAccountNumber,
          String? bankIFSCCode,
          String? bankName,
          bool? isCashOnDelivery}) =>
      PaymentModel(
          selectedPayment: paymentMethod ?? this.selectedPayment,
          cardNumber: cardNumber ?? this.cardNumber,
          cardName: cardName ?? this.cardName,
          validity: validity ?? this.validity,
          cvv: cvv ?? this.cvv,
          saveCardDetails: saveCardDetails ?? this.saveCardDetails,
          bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
          bankIFSCCode: bankIFSCCode ?? this.bankIFSCCode,
          bankName: bankName ?? this.bankName,
          isCashOnDelivery: isCashOnDelivery ?? this.isCashOnDelivery);
}
