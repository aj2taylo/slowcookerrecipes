public with sharing class recipeController {


    @AuraEnabled
    public static Boolean addIngredient(String recipeId, String groceryItemName, String storeSectionName) {
        Grocery_Item__c gi  = groceryUtils.getGroceryItemByNameAndSection(groceryItemName, storeSectionName);

        Ingredient__c i     = new Ingredient__c(Recipe__c = recipeId, Grocery_Item__c = gi.Id);
        try {
            insert i;
        } catch (DmlException e) {
            return false;
        }
        return true;
    }


    @AuraEnabled
    public static Boolean removeIngredient(String ingredientId) {
        Ingredient__c i     = new Ingredient__c(Id = ingredientId);
        try {
            delete i;
        } catch (DmlException e) {
            return false;
        }
        return true;
    }



    @AuraEnabled
    public static List<Ingredient__c> getIngredients(String recipeId) {
        System.debug('recipeId = ' + recipeId);
        return groceryUtils.returnRecipeIngredients(recipeId);
    }


    @AuraEnabled 
    public static Boolean addRecipeToShoppingList(String recipeId) {
        return groceryUtils.addRecipeToRecentShoppingList(recipeId);
    }


    @AuraEnabled 
    public static Id getShoppingListId() {
        return groceryUtils.getActiveShoppingListId();
    }

}