import ballerina/data.xmldata;
import ballerina/file;
import ballerina/io;
import ballerinax/health.fhir.r4;
import ballerinax/health.fhir.r4.parser;
import ballerinacentral/zip;

function extractLoincZip(string sourcePath) returns error? {
    check zip:extract(sourcePath, EXTRACTED_FOLDER_PATH);
}

function removeExtractedDirectory() returns error? {
    check file:remove(EXTRACTED_FOLDER_PATH, file:RECURSIVE);
}

// Mapping function
function LoincConceptToR4Concept(LoincConcept[]? loincConcepts) returns r4:CodeSystemConcept[] {
    if loincConcepts is null {
        return [];
    }

    r4:CodeSystemConcept[] r4Concepts = [];
    foreach LoincConcept loinc in loincConcepts {
        r4:CodeSystemConcept concept = {
            code: loinc.LOINC_NUM,
            display: loinc.COMPONENT,
            property: getProperties(loinc)
        };
        r4Concepts.push(concept);
    }
    return r4Concepts;
}

// Function to extract all properties dynamically from a LoincConcept
function getProperties(LoincConcept loinc) returns r4:CodeSystemConceptProperty[] {
    r4:CodeSystemConceptProperty[] properties = [];

    // Manually map each field in the LoincConcept record
    if loinc?.PROPERTY is string && loinc?.PROPERTY != "" {
        properties.push({code: "PROPERTY", valueString: loinc?.PROPERTY});
    }
    if loinc?.TIME_ASPCT is string && loinc?.TIME_ASPCT != "" {
        properties.push({code: "TIME_ASPCT", valueString: loinc?.TIME_ASPCT});
    }
    if loinc?.SYSTEM is string && loinc?.SYSTEM != "" {
        properties.push({code: "SYSTEM", valueString: loinc?.SYSTEM});
    }
    if loinc?.SCALE_TYP is string && loinc?.SCALE_TYP != "" {
        properties.push({code: "SCALE_TYP", valueString: loinc?.SCALE_TYP});
    }
    if loinc?.METHOD_TYP is string && loinc?.METHOD_TYP != "" {
        properties.push({code: "METHOD_TYP", valueString: loinc?.METHOD_TYP});
    }
    if loinc?.CLASS is string && loinc?.CLASS != "" {
        properties.push({code: "CLASS", valueString: loinc?.CLASS});
    }
    if loinc?.VersionLastChanged is string && loinc?.VersionLastChanged != "" {
        properties.push({code: "VersionLastChanged", valueString: loinc?.VersionLastChanged});
    }
    if loinc?.CHNG_TYPE is string && loinc?.CHNG_TYPE != "" {
        properties.push({code: "CHNG_TYPE", valueString: loinc?.CHNG_TYPE});
    }
    if loinc?.DefinitionDescription is string && loinc?.DefinitionDescription != "" {
        properties.push({code: "DefinitionDescription", valueString: loinc?.DefinitionDescription});
    }
    if loinc?.STATUS is string && loinc?.STATUS != "" {
        properties.push({code: "STATUS", valueString: loinc?.STATUS});
    }
    if loinc?.CONSUMER_NAME is string && loinc?.CONSUMER_NAME != "" {
        properties.push({code: "CONSUMER_NAME", valueString: loinc?.CONSUMER_NAME});
    }
    if loinc?.CLASSTYPE is string && loinc?.CLASSTYPE != "" {
        properties.push({code: "CLASSTYPE", valueString: loinc?.CLASSTYPE});
    }
    if loinc?.FORMULA is string && loinc?.FORMULA != "" {
        properties.push({code: "FORMULA", valueString: loinc?.FORMULA});
    }
    if loinc?.EXMPL_ANSWERS is string && loinc?.EXMPL_ANSWERS != "" {
        properties.push({code: "EXMPL_ANSWERS", valueString: loinc?.EXMPL_ANSWERS});
    }
    if loinc?.SURVEY_QUEST_TEXT is string && loinc?.SURVEY_QUEST_TEXT != "" {
        properties.push({code: "SURVEY_QUEST_TEXT", valueString: loinc?.SURVEY_QUEST_TEXT});
    }
    if loinc?.SURVEY_QUEST_SRC is string && loinc?.SURVEY_QUEST_SRC != "" {
        properties.push({code: "SURVEY_QUEST_SRC", valueString: loinc?.SURVEY_QUEST_SRC});
    }
    if loinc?.UNITSREQUIRED is string && loinc?.UNITSREQUIRED != "" {
        properties.push({code: "UNITSREQUIRED", valueString: loinc?.UNITSREQUIRED});
    }
    if loinc?.RELATEDNAMES2 is string && loinc?.RELATEDNAMES2 != "" {
        properties.push({code: "RELATEDNAMES2", valueString: loinc?.RELATEDNAMES2});
    }
    if loinc?.SHORTNAME is string && loinc?.SHORTNAME != "" {
        properties.push({code: "SHORTNAME", valueString: loinc?.SHORTNAME});
    }
    if loinc?.ORDER_OBS is string && loinc?.ORDER_OBS != "" {
        properties.push({code: "ORDER_OBS", valueString: loinc?.ORDER_OBS});
    }
    if loinc?.HL7_FIELD_SUBFIELD_ID is string && loinc?.HL7_FIELD_SUBFIELD_ID != "" {
        properties.push({code: "HL7_FIELD_SUBFIELD_ID", valueString: loinc?.HL7_FIELD_SUBFIELD_ID});
    }
    if loinc?.EXTERNAL_COPYRIGHT_NOTICE is string && loinc?.EXTERNAL_COPYRIGHT_NOTICE != "" {
        properties.push({code: "EXTERNAL_COPYRIGHT_NOTICE", valueString: loinc?.EXTERNAL_COPYRIGHT_NOTICE});
    }
    if loinc?.EXAMPLE_UNITS is string && loinc?.EXAMPLE_UNITS != "" {
        properties.push({code: "EXAMPLE_UNITS", valueString: loinc?.EXAMPLE_UNITS});
    }
    if loinc?.LONG_COMMON_NAME is string && loinc?.LONG_COMMON_NAME != "" {
        properties.push({code: "LONG_COMMON_NAME", valueString: loinc?.LONG_COMMON_NAME});
    }
    if loinc?.EXAMPLE_UCUM_UNITS is string && loinc?.EXAMPLE_UCUM_UNITS != "" {
        properties.push({code: "EXAMPLE_UCUM_UNITS", valueString: loinc?.EXAMPLE_UCUM_UNITS});
    }
    if loinc?.STATUS_REASON is string && loinc?.STATUS_REASON != "" {
        properties.push({code: "STATUS_REASON", valueString: loinc?.STATUS_REASON});
    }
    if loinc?.STATUS_TEXT is string && loinc?.STATUS_TEXT != "" {
        properties.push({code: "STATUS_TEXT", valueString: loinc?.STATUS_TEXT});
    }
    if loinc?.CHANGE_REASON_PUBLIC is string && loinc?.CHANGE_REASON_PUBLIC != "" {
        properties.push({code: "CHANGE_REASON_PUBLIC", valueString: loinc?.CHANGE_REASON_PUBLIC});
    }
    if loinc?.COMMON_TEST_RANK is string && loinc?.COMMON_TEST_RANK != "" {
        properties.push({code: "COMMON_TEST_RANK", valueString: loinc?.COMMON_TEST_RANK});
    }
    if loinc?.COMMON_ORDER_RANK is string && loinc?.COMMON_ORDER_RANK != "" {
        properties.push({code: "COMMON_ORDER_RANK", valueString: loinc?.COMMON_ORDER_RANK});
    }
    if loinc?.HL7_ATTACHMENT_STRUCTURE is string && loinc?.HL7_ATTACHMENT_STRUCTURE != "" {
        properties.push({code: "HL7_ATTACHMENT_STRUCTURE", valueString: loinc?.HL7_ATTACHMENT_STRUCTURE});
    }
    if loinc?.EXTERNAL_COPYRIGHT_LINK is string && loinc?.EXTERNAL_COPYRIGHT_LINK != "" {
        properties.push({code: "EXTERNAL_COPYRIGHT_LINK", valueString: loinc?.EXTERNAL_COPYRIGHT_LINK});
    }
    if loinc?.PanelType is string && loinc?.PanelType != "" {
        properties.push({code: "PanelType", valueString: loinc?.PanelType});
    }
    if loinc?.AskAtOrderEntry is string && loinc?.AskAtOrderEntry != "" {
        properties.push({code: "AskAtOrderEntry", valueString: loinc?.AskAtOrderEntry});
    }
    if loinc?.AssociatedObservations is string && loinc?.AssociatedObservations != "" {
        properties.push({code: "AssociatedObservations", valueString: loinc?.AssociatedObservations});
    }
    if loinc?.VersionFirstReleased is string && loinc?.VersionFirstReleased != "" {
        properties.push({code: "VersionFirstReleased", valueString: loinc?.VersionFirstReleased});
    }
    if loinc?.ValidHL7AttachmentRequest is string && loinc?.ValidHL7AttachmentRequest != "" {
        properties.push({code: "ValidHL7AttachmentRequest", valueString: loinc?.ValidHL7AttachmentRequest});
    }
    if loinc?.DisplayName is string && loinc?.DisplayName != "" {
        properties.push({code: "DisplayName", valueString: loinc?.DisplayName});
    }

    return properties;
}

// Function to create the CodeSystem resource
function createCodeSystemResourceFromJSON(LoincConcept[]? concepts, string loincFilePath, string? 'version) returns r4:CodeSystem|error {
    io:println("Reading LOINC CodeSystem (JSON) file from: ", loincFilePath, " ...");
    string jsonString = check io:fileReadString(loincFilePath);

    r4:CodeSystem codeSystem = check parser:parse(jsonString).ensureType();
    codeSystem.concept = LoincConceptToR4Concept(concepts);

    if ('version is string) {
        codeSystem.version = 'version;
    }

    return codeSystem;
}

function createCodeSystemResource(LoincConcept[]? concepts, string loincFilePath, string? 'version) returns r4:CodeSystem|error {
    io:println("Reading LOINC CodeSystem (XML) file from: ", loincFilePath, " ...");
    xml xmlContent = check io:fileReadXml(loincFilePath);

    XMLCodeSystem xmlcodeSystem = check xmldata:parseAsType(xmlContent);

    r4:CodeSystem codeSystem = mapXMLCodeSystemToR4CodeSystem(xmlcodeSystem);
    codeSystem.concept = LoincConceptToR4Concept(concepts);

    if ('version is string) {
        codeSystem.version = 'version;
    }

    return codeSystem;
}

function mapXMLCodeSystemToR4CodeSystem(XMLCodeSystem xmlCodeSystem) returns r4:CodeSystem {
    r4:CodeSystem r4CodeSystem = {
        url: xmlCodeSystem.url?.value,
        name: xmlCodeSystem.name?.value,
        title: xmlCodeSystem.title?.value,
        status: <r4:CodeSystemStatus>xmlCodeSystem.status?.value,
        experimental: xmlCodeSystem.experimental?.value,
        publisher: xmlCodeSystem.publisher?.value,
        description: <r4:markdown>xmlCodeSystem.description[0].value,
        copyright: xmlCodeSystem.copyright?.value,
        caseSensitive: xmlCodeSystem.caseSensitive?.value,
        valueSet: xmlCodeSystem.valueSet?.value,
        hierarchyMeaning: <r4:CodeSystemHierarchyMeaning>xmlCodeSystem.hierarchyMeaning?.value,
        compositional: xmlCodeSystem.compositional?.value,
        versionNeeded: xmlCodeSystem.versionNeeded?.value,
        content: <r4:CodeSystemContent>xmlCodeSystem.content?.value,
        filter: mapFilters(xmlCodeSystem.filters),
        property: mapProperties(xmlCodeSystem.properties)
    };

    return r4CodeSystem;
}

// Helper function to map filters
function mapFilters(Filter[]? filters) returns r4:CodeSystemFilter[] {
    if filters is () {
        return [];
    }
    r4:CodeSystemFilter[] r4Filters = [];
    foreach var filter in filters {
        r4Filters.push({
            code: filter.code?.value,
            description: filter.description?.value,
            operator: [<r4:CodeSystemFilterOperator>filter.operator?.value],
            value: filter.value?.value
        });
    }
    return r4Filters;
}

// Helper function to map properties
function mapProperties(Property[]? properties) returns r4:CodeSystemProperty[] {
    if properties is () {
        return [];
    }
    r4:CodeSystemProperty[] r4Properties = [];
    foreach var property in properties {
        r4Properties.push({
            code: property.code.value,
            uri: property.uri.value,
            description: property.description.value,
            'type: <r4:CodeSystemPropertyType>property.'type.value
        });
    }

    return r4Properties;
}
