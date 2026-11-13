using {govardhanraju.db.master, govardhanraju.db.transaction} from '../db/datamodel';

service Catalogservice @(path: 'CatalogService',requires: 'authenticated-user') {

 entity EmployeeSet @(restrict: [
    { grant: ['READ'], to: 'Viewer', where: 'bankName = $user.Govardhan' },
    { grant: ['WRITE'], to: 'Editor' }
]) as projection on master.employee;

    //@readonly
    // @Capabilities: { Deletable: false }
    entity PurchaseOrderSet @(
                              restrict :[
                                {grant : ['READ'],to: 'Viewer'},
                                {grant : ['WRITE', 'DELETE'], to: 'Editor'}
                              ],
        odata.draft.enabled : true) as projection on transaction.purchaseorder {
        *,
        case
            when OVERALL_STATUS = 'B' then 2
            when OVERALL_STATUS = 'A' then 3
            when OVERALL_STATUS = 'C' then 0
            when OVERALL_STATUS = 'N' then 5
            else 0
        end as IconColour : Integer,

        case
            when OVERALL_STATUS = 'B' then 'Billed'
            when OVERALL_STATUS = 'A' then 'Approved'
            when OVERALL_STATUS = 'C' then 'Completed'
            when OVERALL_STATUS = 'N' then 'New'
            else 'Unknown'
        end as OverallStatus : String(20)
    }
    actions {
        action boost() returns PurchaseOrderSet @(requires: 'Editor');
    };
    entity PurchaseItemSet    as projection on transaction.poitems;
    entity ProductSet         as projection on master.product;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity AddressSet         as projection on master.address;
    function toporder() returns array of PurchaseOrderSet;
}