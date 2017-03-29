public with sharing class slowCookerMgmtController {
	public slowCookerMgmtController() {
	}

        @RemoteAction
        public static List<Recipe__c> getAllRecipes() {
            return [SELECT Id, Name FROM Recipe__c ORDER BY Name LIMIT 100];
        }



        @RemoteAction
        public static List<Shopping_List_Item__c> getShoppingList() {
            return shoppingListController.returnShoppingListBySection(recipeController.getShoppingListId());
        }

        @RemoteAction 
        public static Boolean addRecipeToShoppingList(String recipeId) {
            return groceryUtils.addRecipeToShoppingListById(recipeId, recipeController.getShoppingListId());
        }

}