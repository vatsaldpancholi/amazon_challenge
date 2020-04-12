public with sharing class OpportunityTriggerHelper {
	public static void beforeUpdate(Id profileId, List<Opportunity> opportunities) {
		String profileName = [Select Id, Name from Profile where Id =: profileId].Name;
		for(Opportunity opportunity: opportunities) {
            if(opportunity != null)
			    if(isAdminAndProbabilityGreaterThanThreshold(profileName, Opportunity.Probability, Constants.UPDATE_PROBABILITY_THRESHOLD + 1)) {
				    addErrorToOpportunity(opportunity, Constants.UPDATE_ERROR_MESSAGE);
			    }
		}
	}

	public static void beforeDelete(Id profileId, List<Opportunity> opportunities) {
        String profileName = [Select Id, Name from Profile where Id =: profileId].Name;
		for(Opportunity opportunity: opportunities) {
            if(opportunity != null)
                if(isAdminAndProbabilityGreaterThanThreshold(profileName, Opportunity.Probability, Constants.DELETE_PROBABILITY_THRESHOLD)) {
                    addErrorToOpportunity(opportunity, Constants.DELETE_ERROR_MESSAGE);
                }
		}
    }

    private static boolean isAdminAndProbabilityGreaterThanThreshold(String profileName, decimal probability, decimal threshold) {
        return (probability >= threshold && profileName != Constants.SYSTEM_ADMIN);
    }

    private static void addErrorToOpportunity(Opportunity opportunity, String message) {
            opportunity.Name.addError(message);
    }
}