const cds = require('@sap/cds')

module.exports = class Catalogservice extends cds.ApplicationService { init() {

  const { EmployeeSet, PurchaseOrderSet, BusinessPartnerSet, AddressSet, PurchaseItemSet, ProductSet } = cds.entities('Catalogservice')

  this.before (['CREATE', 'UPDATE'], EmployeeSet, async (req) => {
    console.log('Before CREATE/UPDATE EmployeeSet', req.data)

    // get the employeesalary info
    let salaryAmount = req.data.salaryAmount
    if (salaryAmount > 1000000){
      req.error(500, "ohh*** check the salaryAmount, none of employee get million")
    }
  })
  this.after ('READ', EmployeeSet, async (employeeSet, req) => {
    console.log('After READ EmployeeSet', employeeSet)
  })
  this.before (['CREATE', 'UPDATE'], PurchaseOrderSet, async (req) => {
    console.log('Before CREATE/UPDATE PurchaseOrderSet', req.data)
  })
  this.after ('READ', PurchaseOrderSet, async (purchaseOrderSet, req) => {
    console.log('After READ PurchaseOrderSet', purchaseOrderSet)
  })
  this.before (['CREATE', 'UPDATE'], BusinessPartnerSet, async (req) => {
    console.log('Before CREATE/UPDATE BusinessPartnerSet', req.data)
  })
  this.after ('READ', BusinessPartnerSet, async (businessPartnerSet, req) => {
    console.log('After READ BusinessPartnerSet', businessPartnerSet)
  })
  this.before (['CREATE', 'UPDATE'], AddressSet, async (req) => {
    console.log('Before CREATE/UPDATE AddressSet', req.data)
  })
  this.after ('READ', AddressSet, async (addressSet, req) => {
    console.log('After READ AddressSet', addressSet)
  })
  this.before (['CREATE', 'UPDATE'], PurchaseItemSet, async (req) => {
    console.log('Before CREATE/UPDATE PurchaseItemSet', req.data)
  })
  this.after ('READ', PurchaseItemSet, async (purchaseItemSet, req) => {
    console.log('After READ PurchaseItemSet', purchaseItemSet)
  })
  this.before (['CREATE', 'UPDATE'], ProductSet, async (req) => {
    console.log('Before CREATE/UPDATE ProductSet', req.data)
  })
  this.after ('READ', ProductSet, async (productSet, req) => {
    console.log('After READ ProductSet', productSet)
  })

  // implementing function using generic handler -  always returns array
  this.on('toporder', async(req,res)=>{
    try{
      const tx = cds.tx(req);
      // using cds ql to make call to db
      const reply = await tx.read(PurchaseOrderSet).orderBy({
        'GROSS_AMOUNT': 'desc'
      }).limit(10);

      return reply;

    }catch (error) {
      req.error(500, "some issue")
    }
  });

  // implementing the action - which is instance bound
  this.on('boost', async(req) => {

   // debugger;
   try{
    const PRIMARYKEY = req.params[0];
    const tx = cds.tx(req);
    // cds query language to update your gross_amount by +5000
    await tx.update(PurchaseOrderSet).with({
      GROSS_AMOUNT : { '+=' : 5000},
      NOTE: 'BOOSTED!!!'
    }).where(PRIMARYKEY);
    return await tx.read(PurchaseOrderSet).where(PRIMARYKEY)
   }catch (error){

   }

  });



  return super.init()
}}
