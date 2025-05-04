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
    Id id;
    Url url;
    Identifier identifier;
    Name name;
    Title title;
    Status status;
    Experimental experimental;
    Publisher publisher;
    Contact contact;
    Copyright copyright;
    CaseSensitive caseSensitive;
    ValueSet valueSet;
    HierarchyMeaning hierarchyMeaning;
    Compositional compositional;
    VersionNeeded versionNeeded;
    Content content;
    Description[] description;
    Filter[] filters?;
    Property[] properties?;
};

type Id record {
    string value;
};

type Url record {
    string value;
};

type Identifier record {
    System system;
    Value value;
};

type System record {
    string value;
};

type Value record {
    string value;
};

type Name record {
    string value;
};

type Title record {
    string value;
};

type Status record {
    string value;
};

type Experimental record {
    boolean value;
};

type Publisher record {
    string value;
};

type Contact record {
    Telecom telecom;
};

type Telecom record {
    System system;
    Value value;
};

type Description record {
    string value;
};

type Copyright record {
    string value;
};

type CaseSensitive record {
    boolean value;
};

type ValueSet record {
    string value;
};

type HierarchyMeaning record {
    string value;
};

type Compositional record {
    boolean value;
};

type VersionNeeded record {
    boolean value;
};

type Content record {
    string value;
};

type Filter record {
    Code code;
    Description description;
    Operator operator;
    Value value;
};

type Code record {
    string value;
};

type Operator record {
    string value;
};

type Property record {
    Code code;
    Uri uri;
    Description description;
    Type 'type;
};

type Uri record {
    string value;
};

type Type record {
    string value;
};
