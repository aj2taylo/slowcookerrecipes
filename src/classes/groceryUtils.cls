public with sharing class groceryUtils {

    /* ==================================================================
    SEARCHING / CREATING GROCERY ITEMS
    =====================================================================*/
        public static Grocery_Item__c getGroceryItemByNameAndSection(String groceryName, String storeSection) {
            Store_Section__c s      = groceryUtils.getStoreSectionByName(storeSection);
            return groceryUtils.getGroceryItemByName(groceryName, s);
        }


        public static Grocery_Item__c getGroceryItemByName(String groceryName, Store_Section__c s) {
            List<Grocery_Item__c> giList    = [select Id, Name, Store_Section__c from Grocery_Item__c where Name = :groceryName AND Store_Section__c = :s.Id];
            if(!giList.isEmpty())
                return giList[0];
            Grocery_Item__c gi      = new Grocery_Item__c(Name = groceryName, Store_Section__c = s.Id);
            insert gi;
            return gi;
        }





    /* ==================================================================
    SEARCHING / CREATING STORE SECTIONS
    =====================================================================*/
        public static Store_Section__c getStoreSectionByName(String storeSection) {
            List<Store_Section__c> ssList   = [select Id, Name from Store_Section__c where Name = :storeSection];
            if(!ssList.isEmpty())
                return ssList[0];
            Store_Section__c ss             = new Store_Section__c(Name = storeSection);
            insert ss;
            return ss;
        }




    /* ==================================================================
    RECIPE INGREDIENTS
    =====================================================================*/
        public static List<Ingredient__c> returnRecipeIngredients(String recipeId) {
            return [SELECT Id, Name, Grocery_Item__c, Grocery_Item__r.Name, Grocery_Item__r.Store_Section__r.Name FROM Ingredient__c where Recipe__c = :recipeId ORDER BY Name];
        }


        public static Boolean addRecipeToShoppingListById(String recipeId, String shoppingListId) {
            System.debug('recipeId = ' + recipeId);
            System.debug('shoppingListId = ' + shoppingListId);
            List<Shopping_List_Item__c> sliList     = new List<Shopping_List_Item__c>();
            for(Ingredient__c i : groceryUtils.returnRecipeIngredients(recipeId))
                sliList.add(new Shopping_List_Item__c(Shopping_List__c = shoppingListId, Grocery_Item__c = i.Grocery_Item__c));
            System.debug('sliList = ' + sliList);
            try {
                insert sliList;
            } catch(DmlException e) {
                return false;
            }
            return true;
        }


        public static Boolean addRecipeToRecentShoppingList(String recipeId) {
            return addRecipeToShoppingListById(recipeId, groceryUtils.getActiveShoppingListId());
        }



    public static Id getActiveShoppingListId() {
        List<Shopping_List__c> slList   = [select Id from Shopping_List__c where Done__c = false order by CreatedDate desc limit 1];
        if(slList.isEmpty()) {
            Shopping_List__c sl     = new Shopping_List__c();
            insert sl;
            slList.add(sl);
        }
        return slList[0].Id;
    }
}