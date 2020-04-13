@isTest
private class OpportunityTriggerTest {

    @isTest
    private static void shouldNotAllowNonAdminUserToDeleteOpportunityRecord() {
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Test Profile' LIMIT 1];

     	User nonAdminUser = new User(   LastName = 'Test Last Name',
                                        FirstName='Test First Name',
                                        Alias = 'testName',
                                        Email = 'test@test.com',
                                        Username = 'testFirstLastName@test.com',
                                        ProfileId = profileId.id,
                                        TimeZoneSidKey = 'GMT',
                                        LanguageLocaleKey = 'en_US',
                                        EmailEncodingKey = 'UTF-8',
                                        LocaleSidKey = 'en_US'
                           );

        Opportunity opportunity = new Opportunity(  Name = 'Opportunity Trigger Test',
                                                    CloseDate = System.today().addDays(10),
                                                    StageName = 'Prospecting',
                                                    Probability = 76
                                                );
        Insert opportunity;
        Opportunity deleteOpportunity  = [Select Id, Name, Probability from Opportunity where Name =: 'Opportunity Trigger Test'];
        System.runAs(nonAdminUser) {
                Test.startTest();
                Database.DeleteResult result = Database.delete(deleteOpportunity, false);
                Test.stopTest();

                System.assertEquals('Non Admin user can not delete this Opportunity if Probability greater than or equal to 75%.', result.getErrors()[0].getMessage());
        }
    }

    @isTest
    private static void shouldAllowNonAdminUserToDeleteOpportunityRecordForBelowThreshold() {
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Test Profile' LIMIT 1];

     	User nonAdminUser = new User(   LastName = 'Test Last Name',
                                        FirstName='Test First Name',
                                        Alias = 'testName',
                                        Email = 'test@test.com',
                                        Username = 'testFirstLastName@test.com',
                                        ProfileId = profileId.id,
                                        TimeZoneSidKey = 'GMT',
                                        LanguageLocaleKey = 'en_US',
                                        EmailEncodingKey = 'UTF-8',
                                        LocaleSidKey = 'en_US'
                           );

        Opportunity opportunity = new Opportunity(  Name = 'Opportunity Trigger Test',
                                                    CloseDate = System.today().addDays(10),
                                                    StageName = 'Prospecting',
                                                    Probability = 49
                                                );
        Insert opportunity;

        Opportunity deleteOpportunity  = [Select Id, Name, Probability from Opportunity where Name =: 'Opportunity Trigger Test'];
        System.runAs(nonAdminUser) {
                Test.startTest();
                Database.DeleteResult result = Database.delete(deleteOpportunity, false);
                Test.stopTest();

                System.assert(result.isSuccess());
        }
    }

    @isTest
    private static void shouldAllowAdminUserToDeleteOpportunityRecord() {
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];

     	User AdminUser = new User(  LastName = 'Test Last Name',
                                    FirstName='Test First Name',
                                    Alias = 'testName',
                                    Email = 'test@test.com',
                                    Username = 'testFirstLastName@test.com',
                                    ProfileId = profileId.id,
                                    TimeZoneSidKey = 'GMT',
                                    LanguageLocaleKey = 'en_US',
                                    EmailEncodingKey = 'UTF-8',
                                    LocaleSidKey = 'en_US'
                           );

        Opportunity opportunity = new Opportunity(  Name = 'Opportunity Trigger Test',
                                                    CloseDate = System.today().addDays(10),
                                                    StageName = 'Prospecting',
                                                    Probability = 76
                                                );
        Insert opportunity;

        Opportunity deleteOpportunity  = [Select Id, Name, Probability from Opportunity where Name =: 'Opportunity Trigger Test'];
        System.runAs(AdminUser) {
                Test.startTest();
                Database.DeleteResult result = Database.delete(deleteOpportunity, false);
                Test.stopTest();

                System.assert(result.isSuccess());
        }
    }

    @isTest
    private static void bulkTesting() {
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Test Profile' LIMIT 1];

     	User AdminUser = new User(  LastName = 'Test Last Name',
                                    FirstName='Test First Name',
                                    Alias = 'testName',
                                    Email = 'test@test.com',
                                    Username = 'testFirstLastName@test.com',
                                    ProfileId = profileId.id,
                                    TimeZoneSidKey = 'GMT',
                                    LanguageLocaleKey = 'en_US',
                                    EmailEncodingKey = 'UTF-8',
                                    LocaleSidKey = 'en_US'
                           );

        List<Opportunity> bulkOpportunityRecords = new List<Opportunity>();
        for(Integer opportunity = 0; opportunity <= 300; opportunity++){
            Opportunity bulkOpportunity = new Opportunity(  Name = 'Opportunity Trigger Test '+opportunity,
                                                            CloseDate = System.today().addDays(10),
                                                            StageName = 'Prospecting',
                                                            Probability = 76
                                                         );
            bulkOpportunityRecords.add(bulkOpportunity);
        }
        Insert bulkOpportunityRecords;

        List<Opportunity> deleteBulkOpportunity  = [Select Id, Name, Probability from Opportunity where Name Like '%Opportunity Trigger Test%'];
        System.runAs(AdminUser) {
                Test.startTest();
                Database.DeleteResult[] results = Database.delete(deleteBulkOpportunity, false);
                Test.stopTest();

                for(Database.DeleteResult assertRecords : results)
                    System.assertEquals('Non Admin user can not delete this Opportunity if Probability greater than or equal to 75%.', assertRecords.getErrors()[0].getMessage());
        }
    }
}
