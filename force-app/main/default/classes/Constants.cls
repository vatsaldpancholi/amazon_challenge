public with sharing class Constants {
    public static final String SYSTEM_ADMIN = 'System Administrator';
    public static final decimal UPDATE_PROBABILITY_THRESHOLD = 50;
    public static final decimal DELETE_PROBABILITY_THRESHOLD = 75;
    public static final String UPDATE_ERROR_MESSAGE = 'Non Admin user can not modify this Opportunity if Probability greater than 50%.';
    public static final String DELETE_ERROR_MESSAGE = 'Non Admin user can not delete this Opportunity if Probability greater than or equal to 75%.';
}
