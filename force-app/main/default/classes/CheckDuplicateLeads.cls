
/*
    Write an Apex method called (leadDuplicateCheck) that will validate if a collection of new leads would create duplicates in the system
    and returns segregated lists in a map (True: list of non-duplicates & False: list of duplicates).
    A duplicate lead is defined as same Email, Territory__r.Region__c (text) and Company (text)
*/


public with sharing class CheckDuplicateLeads{

    private static Map<String, Lead> leadMap;
    public static void run(){
        new CheckDuplicateLeads();
    }

    private CheckDuplicateLeads() {
        List<Lead> newLeads = getNewLeads();
        system.debug('Get new Lead records '+newLeads);
        leadMap = new Map<String, Lead>();
        buildLeadMap(newLeads);
        leadDuplicateCheck(newLeads);
    }

    private static List<Lead> getNewLeads(){
        return ([Select Territory__r.Region__c, Company, Email From Lead Where Territory__c != null Limit 7]);
    }

    private static void buildLeadMap(List<Lead> newLeads){
		for (Lead lead : newLeads){
			if(lead != null) {
                String key = lead.email+lead.company+lead.territory__r.region__c;
                system.debug('Key values '+key);
                leadMap.put(key, lead);
            }
		}
    }

	private Map<boolean, List<Lead>> leadDuplicateCheck(List<Lead> newLeads){
		List<Lead> nonDuplicateLeads = new List<Lead>();
        List<Lead> duplicateLeads = new List<Lead>();

		for (Lead currentLead : newLeads){
			if(currentLead != null){
                String key = currentLead.email+currentLead.company+currentLead.territory__r.region__c;
				Lead lead = leadMap.get(key);
				if (isDuplicate(currentLead, lead)){
                    duplicateLeads.add(currentLead);
                }
				else{
                    nonDuplicateLeads.add(currentLead);
                }
			}
        }

		Map<boolean, List<Lead>> result = new Map<boolean, List<Lead>>();
		result.put(true, nonDuplicateLeads);
        result.put(false, duplicateLeads);

        System.debug('Result Map Duplicate '+result.get(false));
        System.debug('Result Map Non-Duplicate '+result.get(true));
		return result;
    }

    private boolean isDuplicate(Lead lead1, Lead lead2) {
        // Assuming, null email, null company and null Territory region as duplicates
        System.debug('List 1 '+lead1);
        System.debug('List 2 '+lead2);
        return (lead1.Email.equalsIgnoreCase(lead2.Email) && lead1.Territory__r.Region__c.equalsIgnoreCase(lead2.Territory__r.Region__c) && lead1.Company.equalsIgnoreCase(lead2.Company));
    }
}