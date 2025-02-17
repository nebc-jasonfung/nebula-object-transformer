/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 17/11/2021
 * @description A Transformation instance that maps fields in the reverse of the configured direction
 */

global inherited sharing class ReverseTransformation extends Transformation {

    global ReverseTransformation(String transformationName, Type targetType) {
        this(
        [
                SELECT Source_Field__c, Target_Field__c, Apex_Class__c, Apex_Class_Parameters__c, Apex_Class_Receives__c,
                        Reverse_Apex_Class__c, Reverse_Apex_Class_Parameters__c, Reverse_Apex_Class_Receives__c
                FROM Transformation_Field__mdt
                WHERE Transformation__r.DeveloperName = :transformationName
        ],
                targetType);
    }

    @TestVisible
    private ReverseTransformation(List<Transformation_Field__mdt> transformationFields, Type targetType) {
        super(new LazySObjectIterator(transformationFields.deepClone())
                .mapValuesT(new SwapFields(Transformation_Field__mdt.Source_Field__c, Transformation_Field__mdt.Target_Field__c))
                .mapValuesT(new SwapFields(Transformation_Field__mdt.Apex_Class__c, Transformation_Field__mdt.Reverse_Apex_Class__c))
                .mapValuesT(new SwapFields(Transformation_Field__mdt.Apex_Class_Parameters__c, Transformation_Field__mdt.Reverse_Apex_Class_Parameters__c))
                .mapValuesT(new SwapFields(Transformation_Field__mdt.Apex_Class_Receives__c, Transformation_Field__mdt.Reverse_Apex_Class_Receives__c))
                .toList(new List<Transformation_Field__mdt>()), targetType);
    }
}