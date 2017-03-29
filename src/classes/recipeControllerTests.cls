@isTest
private class recipeControllerTests {

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


    @isTest static void addIngredientTest() {
        Recipe__c r     = [select Id, Name from Recipe__c where Name = 'Recipe'];
        Grocery_Item__c gi     = [select Id, Name from Grocery_Item__c where Name = 'Grocery'];
        Store_Section__c ss     = [select Id, Name from Store_Section__c where Name = 'Store Section'];

        System.assert(recipeController.addIngredient(r.Id, gi.Name, ss.Name));
    }
    
    @isTest static void removeIngredientTest() {
        Ingredient__c i     = [select Id from Ingredient__c limit 1];
        System.assert(recipeController.removeIngredient(i.Id));
    }


    @isTest static void getIngredientsTest() {
        Recipe__c r     = [select Id, Name from Recipe__c where Name = 'Recipe'];
        List<Ingredient__c> iList     = recipeController.getIngredients(r.Id);
        System.assertEquals(iList.size(), 1);
    }

    @isTest static void addRecipeToShoppingListTest() {
        Shopping_List__c sl = new Shopping_List__c();
        insert sl;
        Recipe__c r     = [select Id, Name from Recipe__c where Name = 'Recipe'];

        System.assert(recipeController.addRecipeToShoppingList(r.Id));
    }


    @isTest static void getShoppingListIdTest() {
        Shopping_List__c sl = new Shopping_List__c();
        insert sl;

        System.assertEquals(recipeController.getShoppingListId(), sl.Id);
    }


    
}