/* 
    Question:
    Detail a solution for the following: On the Opportunity object, 
    prevent non-admin users from modifying the Opportunity Name once Probability is greater than 50% and 
    Prevent Opportunity from being deleted if Probability greater than or equal to 75%
*/

trigger OpportunityTrigger on Opportunity(before update, before delete) {
	if(trigger.isBefore) {
        Id profileId = UserInfo.getProfileId();
		if(trigger.isUpdate) {
			List<Opportunity> opportunityValues = trigger.new;
			OpportunityTriggerHelper.beforeUpdate(profileId, opportunityValues);
		}
		if(trigger.isDelete) {
			List<Opportunity> opportunityValues = trigger.old;
			OpportunityTriggerHelper.beforeDelete(profileId, opportunityValues);
		}
	}
}