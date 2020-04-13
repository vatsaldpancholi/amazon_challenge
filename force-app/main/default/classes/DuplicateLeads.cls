
/*
    Write an Apex method called (leadDuplicateCheck) that will validate if a collection of new leads would create duplicates in the system
    and returns segregated lists in a map (True: list of non-duplicates & False: list of duplicates).
    A duplicate lead is defined as same Email, Territory__r.Region__c (text) and Company (text)
*/
public with sharing class DuplicateLeads {

    public static Map<boolean, List<Lead>> check() {
        List<Lead> newLeads = getNewLeads();
        return leadDuplicateCheck(newLeads);
    }

    private static List<Lead> getNewLeads() {
        return ([Select Territory__r.Region__c, Company, Email From Lead LIMIT 100]);
    }

	private static Map<boolean, List<Lead>> leadDuplicateCheck(List<Lead> newLeads) {
		List<Lead> nonDuplicateLeads = new List<Lead>();
        List<Lead> duplicateLeads = new List<Lead>();

		for (Lead lead1 : newLeads) {
            boolean isDuplicate = false;
            for(Lead lead2 : newLeads) {
                if(lead1 != null && lead2 != null && lead1.Id != lead2.Id) {
                    if (isDuplicateLead(lead1, lead2)) {
                        isDuplicate = true;
                    }
                }
            }
            if(isDuplicate) {
                duplicateLeads.add(lead1);
            } else {
                nonDuplicateLeads.add(lead1);
            }
        }

		Map<boolean, List<Lead>> result = new Map<boolean, List<Lead>>();
		result.put(true, nonDuplicateLeads);
        result.put(false, duplicateLeads);

		return result;
    }

    private static boolean isDuplicateLead(Lead lead1, Lead lead2) {
        // Assuming, null email, null company and null Territory region as duplicates
        return (lead1.Email.equalsIgnoreCase(lead2.Email) && lead1.Territory__r.Region__c.equalsIgnoreCase(lead2.Territory__r.Region__c) && lead1.Company.equalsIgnoreCase(lead2.Company));
    }
}