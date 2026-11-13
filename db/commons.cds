namespace govardhanraju.common;
using{Currency} from '@sap/cds/common';


type Guid : String(32);

type Gender : String(1) enum{
    MALE = 'M';
    FEMALE = 'F';
    UNDISCLOSED = 'U'
}

type AmountT : Decimal(15,2) @(
    semantic.amount.currencyCode: 'CURRENCY_code'
);

// custom aspect
aspect  Amount{
    CURRENCY : Currency @(title: '{i18n>CURRENCY}');
    GROSS_AMOUNT : AmountT @(title: '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT : AmountT @(title: '{i18n>NET_AMOUNT}');
    TAX_AMOUNT : AmountT @(title: '{i18n>TAX_AMOUNT}');

}
type PhoneNumber : String(30) @assert.format : '^[6-9]\d{9}$';
type Email : String(250) @assert.format : '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-z]{2,}$';