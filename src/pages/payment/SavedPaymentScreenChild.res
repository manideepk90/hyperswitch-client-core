open ReactNative
open ReactNative.Style

@react.component
let make = (
  ~savedPaymentMethodsData,
  ~isSaveCardCheckboxSelected,
  ~setSaveCardChecboxSelected,
  ~showSavePMCheckbox,
  ~merchantName,
  ~savedCardCvv,
  ~setSavedCardCvv,
  ~setIsCvcValid,
) => {
  let {borderRadius, component, shadowColor, shadowIntensity} = ThemebasedStyle.useThemeBasedStyle()
  let (selected, isSelected) = React.useState(_ => true)
  let getShadowStyle = ShadowHook.useGetShadowStyle(~shadowIntensity, ~shadowColor, ())

  let localeObj = GetLocale.useGetLocalObj()

  <>
    <Space />
    <View
      style={array([
        getShadowStyle,
        s({
          paddingHorizontal: 24.->dp,
          paddingVertical: 5.->dp,
          borderRadius,
          borderWidth: 0.0,
          borderColor: component.borderColor,
          backgroundColor: component.background,
        }),
      ])}>
      <SavedPMListWithLoader
        listArr={savedPaymentMethodsData} savedCardCvv setSavedCardCvv setIsCvcValid
      />
    </View>
    <Space height=20. />
    <ClickableTextElement
      initialIconName="addwithcircle"
      text={localeObj.addPaymentMethodLabel}
      isSelected=selected
      setIsSelected=isSelected
      textType={TextWrapper.LinkTextBold}
      fillIcon=false
    />
    {showSavePMCheckbox
      ? <>
          <Space />
          <ClickableTextElement
            disabled={false}
            initialIconName="checkboxClicked"
            updateIconName=Some("checkboxNotClicked")
            text={localeObj.cardTermsPart1 ++ merchantName ++ localeObj.cardTermsPart2}
            isSelected={isSaveCardCheckboxSelected}
            setIsSelected={setSaveCardChecboxSelected}
            textType={TextWrapper.ModalText}
            disableScreenSwitch=true
          />
        </>
      : React.null}
    <Space height=12. />
  </>
}
