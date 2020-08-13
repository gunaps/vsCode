public class APTS_TaxCalculationFactory {
    public static Apttus_Config2.CustomClass.ITaxCallback2 getTaxCallback(){
        String defaultTaxCallback;
        Apttus_Config2.CustomClass.ITaxCallback2 taxCallbackValidator = NULL;

        Apttus_Config2__ConfigCustomClasses__c settings =
               Apttus_Config2__ConfigCustomClasses__c.getValues('System Properties');

        if (settings != null && settings.Apttus_Config2__TaxCallbackClass__c != null) {
            defaultTaxCallback = settings.Apttus_Config2__TaxCallbackClass__c;
            Type t = Type.forName(defaultTaxCallback);
            taxCallbackValidator = (Apttus_Config2.CustomClass.ITaxCallback2)t.newInstance();
        }
        else {
            defaultTaxCallback = NULL;
        }

        return taxCallbackValidator;
    }
}