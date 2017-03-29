@isTest
private class groceryUtilsTests {
    @testSetup static void methodName() {
        Store_Section__c ss             = new Store_Section__c(Name = 'Store Section');
        insert ss;
        Grocery_Item__c gi      = new Grocery_Item__c(Name ='Grocery', Store_Section__c = ss.Id);
        insert gi;

        Recipe__c r         = new Recipe__c(Name = 'Recipe');
        insert r; 

        Ingredient__c i     = new Ingredient__c(Recipe__c = r.Id, Grocery_Item__c = gi.Id);
        insert i;
    }

	
	@isTest static void getGroceryItemByNameAndSectionTest() {
		Grocery_Item__c gi = groceryUtils.getGroceryItemByNameAndSection('Grocery', 'Store Section');
        System.assertNotEquals(gi, null);
        System.assertNotEquals(gi.Id, null);

        Grocery_Item__c gi2 = groceryUtils.getGroceryItemByNameAndSection('New Grocery Item', 'Store Section');
        System.assertNotEquals(gi2, null);
        System.assertNotEquals(gi2.Id, null);
	}
	
	@isTest static void getGroceryItemByNameTest() {
        Store_Section__c ss     = [select Id from Store_Section__c where Name = 'Store Section'];
        Grocery_Item__c gi = groceryUtils.getGroceryItemByName('Grocery', ss);
        System.assertNotEquals(gi, null);
        System.assertNotEquals(gi.Id, null);
	}


    @isTest static void getStoreSectionByNameTest() {
        Store_Section__c ss = groceryUtils.getStoreSectionByName('Store Section');
        System.assertNotEquals(ss, null);
        System.assertNotEquals(ss.Id, null);

        Store_Section__c ss2 = groceryUtils.getStoreSectionByName('New Section');
        System.assertNotEquals(ss2, null);
        System.assertNotEquals(ss2.Id, null);
    }


    @isTest static void returnRecipeIngredientsTest() {
        Recipe__c r         = [select Id from Recipe__c where Name = 'Recipe'];
        List<Ingredient__c> iList = groceryUtils.returnRecipeIngredients(r.Id);
        System.assertNotEquals(iList.size(), 0);
    }


    @isTest static void addRecipeToShoppingListByIdTest() {
        Recipe__c r         = [select Id from Recipe__c where Name = 'Recipe'];
        Shopping_List__c sl = new Shopping_List__c();
        insert sl;

        System.assert(groceryUtils.addRecipeToShoppingListById(r.Id, sl.Id));
    }

    @isTest static void addRecipeToRecentShoppingListTest() {
        Recipe__c r         = [select Id from Recipe__c where Name = 'Recipe'];
        Shopping_List__c sl = new Shopping_List__c();
        insert sl;

        System.assert(groceryUtils.addRecipeToRecentShoppingList(r.Id));
    }

    @isTest static void getActiveShoppingListIdTest() {
        System.assertNotEquals(groceryUtils.getActiveShoppingListId(), null);
    }

}