namespace govardhanraju.cds; 
using { govardhanraju.db.master, govardhanraju.db.transaction} from './datamodel';

context CDSViews {
    define view ![POWorkList] as 
        select from transaction.purchaseorder{
            key PO_ID as![PurchaseOrderId],
            key Items.PO_ITEM_POS as![ItemPosition],
            PARTNER_GUID.BP_ID as![PartnerId],
            PARTNER_GUID.COMPANY_NAME as![CompanyName],
            GROSS_AMOUNT as![GrossAmount],
            NET_AMOUNT as![NetAmount],
            TAX_AMOUNT as![TaxAmount],
            CURRENCY as![Currencycode],
            OVERALL_STATUS as![OverallStatus],
            Items.PRODUCT_GUID.PRODUCT_ID as![ProductId],
            Items.PRODUCT_GUID.DESCRIPTION as![Description],
            PARTNER_GUID.ADDRESS_GUID.CITY as![City],
            PARTNER_GUID.ADDRESS_GUID.COUNTRY as![Country]
        };

    define view ![ProductValueHelp] as 
        select from master.product{
            @EndUserText.lable:[
                {
                    language: 'EN',
                    text: 'Product Id'
                },
                {
                    language: 'DE',
                    text: 'Prodkt Id'
                }
            ]
            PRODUCT_ID as ![ProductId],
            @EndUserText.lable:[
                {
                    language: 'EN',
                    text: 'Product Description'
                },
                {
                    language: 'DE',
                    text: 'Prodkt Descripon'
                }
            ]
            DESCRIPTION as![Description]
        };
    
    define view ![ItemView] as 
        select from transaction.poitems{
            key PARENT_KEY.PARTNER_GUID.NODE_KEY as![CustomerId],
            key PRODUCT_GUID.NODE_KEY as![ProductId],
            CURRENCY as![Currencycode],
            GROSS_AMOUNT as![GrossAmount],
            NET_AMOUNT as![NetAmount],
            TAX_AMOUNT as![TaxAmount],
            PARENT_KEY.OVERALL_STATUS as![Status]
        };

    define view ProductView as select from master.product
        // mixin is a keyword to define lose coupling 
        // which will never load the data from product and items table together 
        // it will first load product and later ONEDEMAND does join to load Items data
        mixin{
            // View on view
            PO_ORDER: Association to many ItemView on PO_ORDER.ProductId = $projection.ProductId
        } into {
            NODE_KEY as![ProductId],
            DESCRIPTION as![Description],
            PRICE as![Price],
            SUPPLIER_GUID.BP_ID as![SupplierId],
            SUPPLIER_GUID.COMPANY_NAME as![CompanyName],
            SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as![Country],
            // exposed association  - @ runtime we load data on-demand
            PO_ORDER as ![To_Items]

        };

    define view CProductValuesView as 
        select from ProductView{
            ProductId,
            Country,
            // AGGREATION
            round(sum(To_Items.GrossAmount),2) as![TotalAmount],
            To_Items.Currencycode as![Currencycode]
        }group by ProductId,
            Country, To_Items.Currencycode
}