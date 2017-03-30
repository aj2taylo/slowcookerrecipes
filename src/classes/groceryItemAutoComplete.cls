public with sharing class groceryItemAutoComplete {

        public static List<Grocery_Item__c> searchGroceryItems(String s) {
            String searchTerm   = '%' + s + '%';
            return [SELECT Id, Name, Store_Section__r.Name FROM Grocery_Item__c where Name LIKE :searchTerm ORDER BY Name LIMIT 100];
        }


            public static List<String> searchGroceryItemsNames(String s) {
                List<String> items   = new List<String>();
                for(Grocery_Item__c i : groceryItemAutoComplete.searchGroceryItems(s)) 
                    items.add(i.Name);
                return items;
            }


        public static List<Store_Section__c> searchStoreSection(String s) {
            String searchTerm   = '%' + s + '%';
            return [SELECT Id, Name FROM Store_Section__c where Name LIKE :searchTerm ORDER BY Name LIMIT 100];
        }       

            public static List<String> searchStoreSectionNames(String s) {
                List<String> sections   = new List<String>();
                for(Store_Section__c ss : groceryItemAutoComplete.searchStoreSection(s)) 
                    sections.add(ss.Name);
                return sections;
            }
}