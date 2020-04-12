/* 
    Question:
    Detail a solution for the following: On the Opportunity object, 
    prevent non-admin users from modifying the Opportunity Name once Probability is greater than 50% and 
    Prevent Opportunity from being deleted if Probability greater than or equal to 75%
*/

trigger OpportunityTrigger on Opportunity(before delete) {
	Id profileId = UserInfo.getProfileId();
	List<Opportunity> opportunityValues = trigger.old;
	OpportunityTriggerHelper.beforeDelete(profileId, opportunityValues);
}