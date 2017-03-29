@isTest
private class shoppingListControllerTest {

    @testSetup static void methodName() {
        Store_Section__c ss             = new Store_Section__c(Name = 'Store Section');
        insert ss;
        Grocery_Item__c gi      = new Grocery_Item__c(Name ='Grocery', Store_Section__c = ss.Id);
        insert gi;

        Recipe__c r         = new Recipe__c(Name = 'Recipe');
        insert r; 

        Ingredient__c i     = new Ingredient__c(Recipe__c = r.Id, Grocery_Item__c = gi.Id);
        insert i;

        Shopping_List__c sl = new Shopping_List__c();
        insert sl;

    }
	
	@isTest static void itemTest() {
		Shopping_List__c sl = [select Id from Shopping_List__c where Done__c = false limit 1];
        Grocery_Item__c gi     = [select Id, Name from Grocery_Item__c where Name = 'Grocery'];
        Store_Section__c ss     = [select Id, Name from Store_Section__c where Name = 'Store Section'];
        Recipe__c r     = [select Id, Name from Recipe__c where Name = 'Recipe'];

        System.assert(shoppingListController.addItem(sl.Id, gi.Name, ss.Name));

        Shopping_List_Item__c sli   = [select Id from Shopping_List_Item__c where Shopping_list__c = :sl.Id];

        System.assert(shoppingListController.markItemDone(sli.Id));

        System.assert(shoppingListController.removeItem(sli.Id));

        System.assert(shoppingListController.addItem(sl.Id, gi.Name, ss.Name));

        List<Shopping_List_Item__c> slList     = shoppingListController.returnShoppingListBySection(sl.Id);
        System.assertEquals(slList.size(), 1);

        sl.Done__c      = true;
        update sl;

        Shopping_List__c sl2    = new Shopping_List__c();
        insert sl2;

        System.assert(shoppingListController.addItemsFromPreviousTrip(sl2.Id));

        List<Shopping_List_Item__c> sl2List     = shoppingListController.returnShoppingListBySection(sl2.Id);
        System.assertEquals(sl2List.size(), 1);

	}
	

    @isTest static void searchTest() {
        List<Recipe__c> rList   = shoppingListController.searchRecipes('Reci');
        System.assertEquals(rList.size(), 1);
    }

	
}