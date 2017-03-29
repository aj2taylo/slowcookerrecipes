@isTest
private class slowCookerMgmtControllerTests {

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
    
    @isTest static void getAllRecipesTest() {
        List<Recipe__c> rList = slowCookerMgmtController.getAllRecipes();
        System.assertEquals(rList.size(), 1);
    }
    
    @isTest static void slowCookerMgmtControllerBasicTest() {
        slowCookerMgmtController ctlr   = new slowCookerMgmtController();
    }


    @isTest static void getShoppingListTest() {
        List<Shopping_List_Item__c> rList = slowCookerMgmtController.getShoppingList();
        System.assertEquals(rList.size(), 0);
    }



    @isTest static void addRecipeToShoppingListTest() {
        Recipe__c r         = [select Id from Recipe__c where Name = 'Recipe'];
        System.assert(slowCookerMgmtController.addRecipeToShoppingList(r.Id));

        List<Shopping_List_Item__c> rList = slowCookerMgmtController.getShoppingList();
        System.assertEquals(rList.size(), 1);
    }


    @isTest static void createRecipeTest() {
        Recipe__c r = slowCookerMgmtController.createRecipe('My Super Secret Recipe');
        System.assertNotEquals(r.Id, null);
    }


    @isTest static void addIngredientTest() {
        Recipe__c r     = [select Id, Name from Recipe__c where Name = 'Recipe'];
        Grocery_Item__c gi     = [select Id, Name from Grocery_Item__c where Name = 'Grocery'];
        Store_Section__c ss     = [select Id, Name from Store_Section__c where Name = 'Store Section'];

        System.assert(slowCookerMgmtController.addIngredient(r.Id, gi.Name, ss.Name));
    }


    @isTest static void getIngredientsTest() {
        Recipe__c r     = [select Id, Name from Recipe__c where Name = 'Recipe'];
        List<Ingredient__c> iList     = slowCookerMgmtController.getIngredients(r.Id);
        System.assertEquals(iList.size(), 1);
    }


    @isTest static void itemTest() {
        Shopping_List__c sl = [select Id from Shopping_List__c where Done__c = false limit 1];
        Grocery_Item__c gi     = [select Id, Name from Grocery_Item__c where Name = 'Grocery'];
        Store_Section__c ss     = [select Id, Name from Store_Section__c where Name = 'Store Section'];
        Recipe__c r     = [select Id, Name from Recipe__c where Name = 'Recipe'];

        System.assert(slowCookerMgmtController.addItem(gi.Name, ss.Name));

    }


}