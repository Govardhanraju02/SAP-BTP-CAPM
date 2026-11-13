sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"govardhan/ui/managepo/test/integration/pages/PurchaseOrderSetList.gen",
	"govardhan/ui/managepo/test/integration/pages/PurchaseOrderSetObjectPage.gen",
	"govardhan/ui/managepo/test/integration/pages/PurchaseItemSetObjectPage.gen"
], function (JourneyRunner, PurchaseOrderSetListGenerated, PurchaseOrderSetObjectPageGenerated, PurchaseItemSetObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('govardhan/ui/managepo') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrderSetListGenerated: PurchaseOrderSetListGenerated,
			onThePurchaseOrderSetObjectPageGenerated: PurchaseOrderSetObjectPageGenerated,
			onThePurchaseItemSetObjectPageGenerated: PurchaseItemSetObjectPageGenerated
        },
        async: true
    });

    return runner;
});

