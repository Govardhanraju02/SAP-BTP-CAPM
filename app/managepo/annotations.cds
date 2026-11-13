using Catalogservice as service from '../../srv/Catalogservice';

annotate service.PurchaseOrderSet with @(
    // ADDING FIELDS TO THE SCREEN FOR FILTERING THE DATA
    UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],

    // adding coloums to the table data
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : NOTE,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'Catalogservice.boost',
            Label : 'BOOST',
            Inline : true,
        },
        {
            $Type : 'UI.DataField',
            Value : OVERALL_STATUS,
            Criticality : IconColour
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
    ],
    UI.HeaderInfo:{
        // title of the table first screen
        TypeName: 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        // will display on the second screen title section
        Title: {Value: PO_ID},
        Description: {Value: PARTNER_GUID.COMPANY_NAME},
        ImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVMYvg9G1BozZDtqX8O3t0Vb7tw4MT0Etv6aNa6orX2g&s=10'
    },
    // add strips in second page
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'General Information',
            Facets :[
                {   Label : 'Basic Info',
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.Identification',
                },
                {   Label : 'Additional Information',
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#BTP',
                },
                {   Label : 'Pricing Details',
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#SAP',
                },

            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Lable : 'Items Data',
            Target : 'Items/@UI.LineItem',
        },
    ],
    // default block which is always and always one
    // contains group of fields
    UI.Identification :[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : NOTE,
        },
    ],
    // Field group block that can be multiple and have many field inside
    UI.FieldGroup #SAP:{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },

        ],
    },
    UI.FieldGroup #BTP :{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ]
    }
);

annotate service.PurchaseItemSet with @(
    UI.HeaderInfo: {
        TypeName : 'PO Items',
        TypeNamePlural : 'Purchase Order Items',
        Title : {Value:PO_ITEM_POS},
        Description : {Value:PRODUCT_GUID.DESCRIPTION}
    },
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
    ],
    UI.Facets :[
        {
            $Type : 'UI.ReferenceFacet',
            Lable : 'Items Data',
            Target : '@UI.Identification',
        },
    ],
    UI.Identification :[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
    ]
);



//annotate a field to get its meaningful text
annotate service.PurchaseOrderSet with{
    @Common.Text: OverallStatus
    OVERALL_STATUS;
    @Common.Text: PARTNER_GUID.COMPANY_NAME
    PARTNER_GUID;
};

// annotate a field to get its meaningful text
annotate service.PurchaseItemSet with{
    @Common.Text: PRODUCT_GUID.DESCRIPTION
    PRODUCT_GUID;
};

