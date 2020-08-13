public with sharing class SystemUtil {

    // approval status
    public static String APPROVAL_STATUS_NONE = 'None';
    public static String APPROVAL_STATUS_APPROVAL_REQUIRED = 'Approval Required';
    public static String APPROVAL_STATUS_NOT_SUBMITTED = 'Not Submitted';
    public static String APPROVAL_STATUS_PENDING_APPROVAL = 'Pending Approval';
    public static String APPROVAL_STATUS_APPROVED = 'Approved';
    public static String APPROVAL_STATUS_REJECTED = 'Rejected';
    public static String APPROVAL_STATUS_CANCELLED = 'Cancelled';
    
    // docusign config admin property name
    static final String PROP_DOCUSIGN_CONFIG = 'APTS_DocuSignConfig';
    
    /**
     * Checks if the given string value is null or empty.
     * @param strValue the string to check
     * @return <code>true</code> if the string value is null or empty, <code>false</code> otherwise
     */
    public static Boolean nullOrEmpty(String strValue) {
        // check if null or zero length string
        return (strValue == null || strValue.trim().length() == 0);
        
    }
    
    /**
     * Checks if the given list of objects is null or empty.
     * @param objList the list of objects to check
     * @return <code>true</code> if the list is null or empty, <code>false</code> otherwise
     */
    public static Boolean nullOrEmpty(List<Object> objList) {
        // check if null or empty
        return (objList == null || objList.isEmpty());
        
    }
    
    /**
     * Gets the docusign configuration xml
     * @return the docusign configuration xml
     */
    public static String getDocuSignConfigXML() {
        
        // get the docusign config property
        Apttus__APTS_Admin__c prop = null;
        
        List<Apttus__APTS_Admin__c> props = 
                [SELECT Id,
                        Name,
                        Apttus__Value__c,
                        Apttus__Code__c
                    FROM Apttus__APTS_Admin__c
                    WHERE Name = :PROP_DOCUSIGN_CONFIG LIMIT 1];
                    
            prop = (props.size() > 0 ? props[0] : null);
                                
        return (prop != null ? prop.Apttus__Code__c : null);
    }
    
}