type walletData =
  | GooglePayData(WalletType.paymentDataFromGPay)
  | ApplePayData(WalletType.paymentDataFromApplePay)
  | SamsungPayData(
      SamsungPayType.paymentMethodData,
      option<SdkTypes.addressDetails>,
      option<SdkTypes.addressDetails>,
    )

type paymentScreenType =
  | PAYMENTSHEET
  | SAVEDCARDSCREEN
  | BANK_TRANSFER(option<PaymentConfirmTypes.ach_credit_transfer>)
  | WALLET_MISSING_FIELDS(
      RequiredFieldsTypes.required_fields,
      PaymentMethodListType.payment_method_types_wallet,
      walletData,
    )
let dafaultVal = SAVEDCARDSCREEN

let paymentScreenTypeContext = React.createContext((dafaultVal, (_: paymentScreenType) => ()))

module Provider = {
  let make = React.Context.provider(paymentScreenTypeContext)
}
@react.component
let make = (~children) => {
  let (state, setState) = React.useState(_ => dafaultVal)

  let setState = React.useCallback1(val => {
    setState(_ => val)
  }, [setState])

  <Provider value=(state, setState)> children </Provider>
}
