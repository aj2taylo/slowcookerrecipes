public with sharing class shoppingListController {

    /* =====================================================================
    MANGE INDIVIDUAL GROCERY ITEMS ON LIST
    ======================================================================== */
        @AuraEnabled
        public static Boolean addItem(String shoppingListId, String groceryItemName, String storeSectionName) {
            Grocery_Item__c gi  = groceryUtils.getGroceryItemByNameAndSection(groceryItemName, storeSectionName);
            Shopping_List_Item__c sli   = new Shopping_List_Item__c(Grocery_Item__c = gi.Id, Shopping_List__c = shoppingListId);
            try {
                insert sli;
            } catch(DmlException e) {
                return false;
            }
            return true;
        }


        @AuraEnabled
        public static Boolean removeItem(String itemId) {
            Shopping_List_Item__c sli   = new Shopping_List_Item__c(Id = itemId);
            try {
                delete sli;
            } catch(DmlException e) {
                return false;
            }
            return true;
        }


        @AuraEnabled
        public static Boolean markItemDone(String itemId) {
            Shopping_List_Item__c sli   = new Shopping_List_Item__c(Id = itemId, Done__c = true);
            try {
                update sli;
            } catch(DmlException e) {
                return false;
            }
            return true;
        }


    /* =====================================================================
    SEARCH
    ======================================================================== */


        @AuraEnabled
        public static List<Recipe__c> searchRecipes(String s) {
            String searchTerm   = '%' + s + '%';
            return [SELECT Id, Name FROM Recipe__c where Name LIKE :searchTerm ORDER BY Name LIMIT 100];
        }


    /* =====================================================================
    ADD FULL RECIPE TO SHOPPING LIST
    ======================================================================== */

        @AuraEnabled 
        public static Boolean addRecipeToShoppingList(String recipeId, String listId) {
            System.debug('recipeId = ' + recipeId);
            System.debug('listId = ' + listId);
            return groceryUtils.addRecipeToShoppingListById(recipeId, listId);
        }


    /* =====================================================================
    RE-PARENT ITEMS FROM LAST SHOPPING LIST
    ======================================================================== */

        @AuraEnabled
        public static Boolean addItemsFromPreviousTrip(String listId) {
            List<Shopping_List__c> slList   = [select Id from Shopping_List__c where Id <> :listId ORDER BY CreatedDate DESC LIMIT 1];
            if(!slList.isEmpty()) {
                List<Shopping_List_Item__c> sliList     = [select Id, Shopping_List__c from Shopping_List_Item__c where Shopping_List__c = :slList[0].Id AND Done__c = false];
                for(Shopping_List_Item__c sli : sliList) 
                    sli.Shopping_List__c    = listId;
                try {
                    update sliList;
                } catch(DmlException e) {
                    return false;
                }
            }
            return true;
        }



    @AuraEnabled
    public static List<Shopping_List_Item__c> returnShoppingListBySection(String listId) {
        return [SELECT Id, Grocery_Item__c, Grocery_Item__r.Name, Grocery_Item__r.Store_Section__r.Name, Done__c FROM Shopping_List_Item__c where Shopping_List__c = :listId AND Done__c = false ORDER BY Grocery_Item__r.Store_Section__r.Name, Name];
    }




}