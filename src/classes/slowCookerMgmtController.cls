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


        @RemoteAction
        public static Recipe__c createRecipe(String recipeName) {
            Recipe__c r         = new Recipe__c(Name = recipeName);
            insert r; 
            return r;
        }


        @RemoteAction 
        public static Boolean addIngredient(String recipeId, String groceryItemName, String storeSectionName) {
            return recipeController.addIngredient(recipeId, groceryItemName, storeSectionName);
        }

        @RemoteAction
        public static Boolean removeIngredient(String itemId) {
            return recipeController.removeIngredient(itemId);
        }


        @RemoteAction 
        public static List<Ingredient__c> getIngredients(String recipeId) {
            System.debug('recipeId = ' + recipeId);
            return groceryUtils.returnRecipeIngredients(recipeId);
        }

        @RemoteAction 
        public static Boolean addItem(String groceryItemName, String storeSectionName) {
            return shoppingListController.addItem(recipeController.getShoppingListId(), groceryItemName, storeSectionName);
        }

        @RemoteAction
        public static Boolean removeItem(String sli) {
            return shoppingListController.removeItem(sli);            
        }


        @RemoteAction
        public static List<String> searchStoreSections(String searchTerm) {
            return groceryItemAutoComplete.searchStoreSectionNames(searchTerm);
        }


        @RemoteAction
        public static List<Grocery_Item__c> searchItems(String searchTerm) {
            return groceryItemAutoComplete.searchGroceryItems(searchTerm);
        }

}