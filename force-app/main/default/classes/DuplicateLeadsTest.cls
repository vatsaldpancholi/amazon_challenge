@isTest
private class DuplicateLeadsTest {

    @TestSetup static void setup() {
        List < Lead > newLeads = new List < Lead > ();

        newLeads.addAll(getDuplicateList());
        newLeads.addAll(getNonDuplicateList());

        insert newLeads;
    }

    @isTest
    private static void shouldSegregateDuplicateRecords() {
        List < Lead > duplicate = getDuplicateList();

        Map < boolean, List < Lead >> result = DuplicateLeads.check();

        System.assertEquals(duplicate.size(), result.get(false).size());
    }

    @isTest
    private static void shouldSegregateNonDuplicateRecords() {
        List < Lead > nonDuplicate = getNonDuplicateList();

        Map < boolean, List < Lead >> result = DuplicateLeads.check();

        System.assertEquals(nonDuplicate.size(), result.get(true).size());
    }

    private static List < Lead > getDuplicateList() {

        Territory__c TerritoryRegionRecords1 = new Territory__c(Name = 'Test Territory Name 1',
            Region__c = 'Region Name 1'
        );
        insert TerritoryRegionRecords1;


        Lead lead1 = new Lead(LastName = 'Test Lead Name 1',
            Email = 'test1@test.com',
            Company = 'company1',
            Territory__c = TerritoryRegionRecords1.Id,
            Status = 'Open - Not Contacted'
        );

        Lead lead2 = new Lead(LastName = 'Test Lead Name 2',
            Email = 'test1@test.com',
            Company = 'company1',
            Territory__c = TerritoryRegionRecords1.Id,
            Status = 'Open - Not Contacted'
        );

        Lead lead3 = new Lead(LastName = 'Test Lead Name 3',
            Email = 'test1@test.com',
            Company = 'company1',
            Territory__c = TerritoryRegionRecords1.Id,
            Status = 'Open - Not Contacted'
        );
        List < Lead > duplicateList = new List < Lead > ();

        duplicateList.add(lead1);
        duplicateList.add(lead2);
        duplicateList.add(lead3);

        return duplicateList;
    }

    private static List < Lead > getNonDuplicateList() {

        Territory__c TerritoryRegionRecords2 = new Territory__c(Name = 'Test Territory Name 2',
            Region__c = 'Region Name 2'
        );
        insert TerritoryRegionRecords2;

        Territory__c TerritoryRegionRecords3 = new Territory__c(Name = 'Test Territory Name 3',
            Region__c = 'Region Name 3'
        );
        insert TerritoryRegionRecords3;

        Lead lead1 = new Lead(LastName = 'Test Lead Name 4',
            Email = 'test2@test.com',
            Company = 'company2',
            Territory__c = TerritoryRegionRecords2.Id,
            Status = 'Open - Not Contacted'
        );

        Lead lead2 = new Lead(LastName = 'Test Lead Name 5',
            Email = 'test3@test.com',
            Company = 'company3',
            Territory__c = TerritoryRegionRecords3.Id,
            Status = 'Open - Not Contacted'
        );

        List < Lead > nonDuplicateList = new List < Lead > ();

        nonDuplicateList.add(lead1);
        nonDuplicateList.add(lead2);

        return nonDuplicateList;
    }
}