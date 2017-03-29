public with sharing class groceryItemAutoComplete {

        public static List<Grocery_Item__c> searchGroceryItems(String s) {
            String searchTerm   = '%' + s + '%';
            return [SELECT Id, Name, Store_Section__r.Name FROM Grocery_Item__c where Name LIKE :searchTerm ORDER BY Name LIMIT 100];
        }



        public static List<Store_Section__c> searchStoreSection(String s) {
            String searchTerm   = '%' + s + '%';
            return [SELECT Id, Name FROM Store_Section__c where Name LIKE :searchTerm ORDER BY Name LIMIT 100];
        }       
}