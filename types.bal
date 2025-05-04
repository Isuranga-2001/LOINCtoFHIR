type LoincConcept record {
    string LOINC_NUM;
    string COMPONENT;
    string? PROPERTY?;
    string? TIME_ASPCT?;
    string? SYSTEM?;
    string? SCALE_TYP?;
    string? METHOD_TYP?;
    string? CLASS?;
    string? VersionLastChanged?;
    string? CHNG_TYPE?;
    string? DefinitionDescription?;
    string? STATUS?;
    string? CONSUMER_NAME?;
    string? CLASSTYPE?;
    string? FORMULA?;
    string? EXMPL_ANSWERS?;
    string? SURVEY_QUEST_TEXT?;
    string? SURVEY_QUEST_SRC?;
    string? UNITSREQUIRED?;
    string? RELATEDNAMES2?;
    string? SHORTNAME?;
    string? ORDER_OBS?;
    string? HL7_FIELD_SUBFIELD_ID?;
    string? EXTERNAL_COPYRIGHT_NOTICE?;
    string? EXAMPLE_UNITS?;
    string? LONG_COMMON_NAME?;
    string? EXAMPLE_UCUM_UNITS?;
    string? STATUS_REASON?;
    string? STATUS_TEXT?;
    string? CHANGE_REASON_PUBLIC?;
    string? COMMON_TEST_RANK?;
    string? COMMON_ORDER_RANK?;
    string? HL7_ATTACHMENT_STRUCTURE?;
    string? EXTERNAL_COPYRIGHT_LINK?;
    string? PanelType?;
    string? AskAtOrderEntry?;
    string? AssociatedObservations?;
    string? VersionFirstReleased?;
    string? ValidHL7AttachmentRequest?;
    string? DisplayName?;
};

// xml parse
type XMLCodeSystem record {
    ValueString id;
    ValueString url;
    ValueSystemCode identifier;
    ValueString name;
    ValueString title;
    ValueString status;
    ValueBoolean experimental;
    ValueString publisher;
    Contact contact;
    ValueString copyright;
    ValueBoolean caseSensitive;
    ValueString valueSet;
    ValueString hierarchyMeaning;
    ValueBoolean compositional;
    ValueBoolean versionNeeded;
    ValueString content;
    ValueString[] description;
    Filter[] filters?;
    Property[] properties?;
};

type ValueString record {
    string value;
};

type ValueBoolean record {
    boolean value;
};

type ValueSystemCode record {
    ValueString system;
    ValueString value;
};

type Contact record {
    ValueSystemCode telecom;
};

type Filter record {
    ValueString code;
    ValueString description;
    ValueString operator;
    ValueString value;
};

type Property record {
    ValueString code;
    ValueString uri;
    ValueString description;
    ValueString 'type;
};