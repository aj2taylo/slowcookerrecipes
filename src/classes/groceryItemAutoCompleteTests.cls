@isTest
private class groceryItemAutoCompleteTests {

    @testSetup static void methodName() {
        Store_Section__c ss             = new Store_Section__c(Name = 'Store Section');
        insert ss;
        Grocery_Item__c gi      = new Grocery_Item__c(Name ='Grocery', Store_Section__c = ss.Id);
        insert gi;
    }	

	@isTest static void searchGroceryItemsTest() {
		System.assertEquals(groceryItemAutoComplete.searchGroceryItems('Grocery').size(), 1);
        System.assertEquals(groceryItemAutoComplete.searchGroceryItems('Blah').size(), 0);
	}
	
	@isTest static void searchStoreSectionTest() {
        System.assertEquals(groceryItemAutoComplete.searchStoreSection('Store').size(), 1);
        System.assertEquals(groceryItemAutoComplete.searchStoreSection('Blah').size(), 0);
	}
	
}