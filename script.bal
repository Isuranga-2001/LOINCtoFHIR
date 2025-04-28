import ballerina/io;
import ballerinax/health.fhir.r4;
import ballerinax/health.fhir.r4.parser;

const string CSV_PATH = "loinc/LoincTable/Loinc.csv";

// Function to read the LOINC CSV file
function readLoincCsv(string path) returns LoincConcept[]|error {
    LoincConcept[]|io:Error content = io:fileReadCsv(path);
    return content;
}

// Function to create the CodeSystem resource
function createCodeSystemResource(LoincConcept[]? concepts) returns r4:CodeSystem {
    return {
        resourceType: "CodeSystem",
        id: "loinc",
        url: "http://loinc.org",
        'version: "2.8", // need to get as a user input
        name: "LOINC",
        title: "LOINC CodeSystem",
        status: "active",
        content: "complete",
        concept: LoincConceptToR4Concept(concepts)
    };
}

// Function to export the combined CodeSystem resource to a JSON file
function exportCodeSystem(LoincConcept[] concepts) returns error? {
    r4:CodeSystem codeSystem = createCodeSystemResource(concepts);
    json jsonContent = codeSystem.toJson();
    string filePath = "loinc-codesystem.json";
    check io:fileWriteString(filePath, jsonContent.toJsonString());
    io:println("CodeSystem exported to ", filePath);
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
        properties.push({ code: "PROPERTY", valueString: loinc?.PROPERTY });
    }
    if loinc?.TIME_ASPCT is string && loinc?.TIME_ASPCT != "" {
        properties.push({ code: "TIME_ASPCT", valueString: loinc?.TIME_ASPCT });
    }
    if loinc?.SYSTEM is string && loinc?.SYSTEM != "" {
        properties.push({ code: "SYSTEM", valueString: loinc?.SYSTEM });
    }
    if loinc?.SCALE_TYP is string && loinc?.SCALE_TYP != "" {
        properties.push({ code: "SCALE_TYP", valueString: loinc?.SCALE_TYP });
    }
    if loinc?.METHOD_TYP is string && loinc?.METHOD_TYP != "" {
        properties.push({ code: "METHOD_TYP", valueString: loinc?.METHOD_TYP });
    }
    if loinc?.CLASS is string && loinc?.CLASS != "" {
        properties.push({ code: "CLASS", valueString: loinc?.CLASS });
    }
    if loinc?.VersionLastChanged is string && loinc?.VersionLastChanged != "" {
        properties.push({ code: "VersionLastChanged", valueString: loinc?.VersionLastChanged });
    }
    if loinc?.CHNG_TYPE is string && loinc?.CHNG_TYPE != "" {
        properties.push({ code: "CHNG_TYPE", valueString: loinc?.CHNG_TYPE });
    }
    if loinc?.DefinitionDescription is string && loinc?.DefinitionDescription != "" {
        properties.push({ code: "DefinitionDescription", valueString: loinc?.DefinitionDescription });
    }
    if loinc?.STATUS is string && loinc?.STATUS != "" {
        properties.push({ code: "STATUS", valueString: loinc?.STATUS });
    }
    if loinc?.CONSUMER_NAME is string && loinc?.CONSUMER_NAME != "" {
        properties.push({ code: "CONSUMER_NAME", valueString: loinc?.CONSUMER_NAME });
    }
    if loinc?.CLASSTYPE is string && loinc?.CLASSTYPE != "" {
        properties.push({ code: "CLASSTYPE", valueString: loinc?.CLASSTYPE });
    }
    if loinc?.FORMULA is string && loinc?.FORMULA != "" {
        properties.push({ code: "FORMULA", valueString: loinc?.FORMULA });
    }
    if loinc?.EXMPL_ANSWERS is string && loinc?.EXMPL_ANSWERS != "" {
        properties.push({ code: "EXMPL_ANSWERS", valueString: loinc?.EXMPL_ANSWERS });
    }
    if loinc?.SURVEY_QUEST_TEXT is string && loinc?.SURVEY_QUEST_TEXT != "" {
        properties.push({ code: "SURVEY_QUEST_TEXT", valueString: loinc?.SURVEY_QUEST_TEXT });
    }
    if loinc?.SURVEY_QUEST_SRC is string && loinc?.SURVEY_QUEST_SRC != "" {
        properties.push({ code: "SURVEY_QUEST_SRC", valueString: loinc?.SURVEY_QUEST_SRC });
    }
    if loinc?.UNITSREQUIRED is string && loinc?.UNITSREQUIRED != "" {
        properties.push({ code: "UNITSREQUIRED", valueString: loinc?.UNITSREQUIRED });
    }
    if loinc?.RELATEDNAMES2 is string && loinc?.RELATEDNAMES2 != "" {
        properties.push({ code: "RELATEDNAMES2", valueString: loinc?.RELATEDNAMES2 });
    }
    if loinc?.SHORTNAME is string && loinc?.SHORTNAME != "" {
        properties.push({ code: "SHORTNAME", valueString: loinc?.SHORTNAME });
    }
    if loinc?.ORDER_OBS is string && loinc?.ORDER_OBS != "" {
        properties.push({ code: "ORDER_OBS", valueString: loinc?.ORDER_OBS });
    }
    if loinc?.HL7_FIELD_SUBFIELD_ID is string && loinc?.HL7_FIELD_SUBFIELD_ID != "" {
        properties.push({ code: "HL7_FIELD_SUBFIELD_ID", valueString: loinc?.HL7_FIELD_SUBFIELD_ID });
    }
    if loinc?.EXTERNAL_COPYRIGHT_NOTICE is string && loinc?.EXTERNAL_COPYRIGHT_NOTICE != "" {
        properties.push({ code: "EXTERNAL_COPYRIGHT_NOTICE", valueString: loinc?.EXTERNAL_COPYRIGHT_NOTICE });
    }
    if loinc?.EXAMPLE_UNITS is string && loinc?.EXAMPLE_UNITS != "" {
        properties.push({ code: "EXAMPLE_UNITS", valueString: loinc?.EXAMPLE_UNITS });
    }
    if loinc?.LONG_COMMON_NAME is string && loinc?.LONG_COMMON_NAME != "" {
        properties.push({ code: "LONG_COMMON_NAME", valueString: loinc?.LONG_COMMON_NAME });
    }
    if loinc?.EXAMPLE_UCUM_UNITS is string && loinc?.EXAMPLE_UCUM_UNITS != "" {
        properties.push({ code: "EXAMPLE_UCUM_UNITS", valueString: loinc?.EXAMPLE_UCUM_UNITS });
    }
    if loinc?.STATUS_REASON is string && loinc?.STATUS_REASON != "" {
        properties.push({ code: "STATUS_REASON", valueString: loinc?.STATUS_REASON });
    }
    if loinc?.STATUS_TEXT is string && loinc?.STATUS_TEXT != "" {
        properties.push({ code: "STATUS_TEXT", valueString: loinc?.STATUS_TEXT });
    }
    if loinc?.CHANGE_REASON_PUBLIC is string && loinc?.CHANGE_REASON_PUBLIC != "" {
        properties.push({ code: "CHANGE_REASON_PUBLIC", valueString: loinc?.CHANGE_REASON_PUBLIC });
    }
    if loinc?.COMMON_TEST_RANK is string && loinc?.COMMON_TEST_RANK != "" {
        properties.push({ code: "COMMON_TEST_RANK", valueString: loinc?.COMMON_TEST_RANK });
    }
    if loinc?.COMMON_ORDER_RANK is string && loinc?.COMMON_ORDER_RANK != "" {
        properties.push({ code: "COMMON_ORDER_RANK", valueString: loinc?.COMMON_ORDER_RANK });
    }
    if loinc?.HL7_ATTACHMENT_STRUCTURE is string && loinc?.HL7_ATTACHMENT_STRUCTURE != "" {
        properties.push({ code: "HL7_ATTACHMENT_STRUCTURE", valueString: loinc?.HL7_ATTACHMENT_STRUCTURE });
    }
    if loinc?.EXTERNAL_COPYRIGHT_LINK is string && loinc?.EXTERNAL_COPYRIGHT_LINK != "" {
        properties.push({ code: "EXTERNAL_COPYRIGHT_LINK", valueString: loinc?.EXTERNAL_COPYRIGHT_LINK });
    }
    if loinc?.PanelType is string && loinc?.PanelType != "" {
        properties.push({ code: "PanelType", valueString: loinc?.PanelType });
    }
    if loinc?.AskAtOrderEntry is string && loinc?.AskAtOrderEntry != "" {
        properties.push({ code: "AskAtOrderEntry", valueString: loinc?.AskAtOrderEntry });
    }
    if loinc?.AssociatedObservations is string && loinc?.AssociatedObservations != "" {
        properties.push({ code: "AssociatedObservations", valueString: loinc?.AssociatedObservations });
    }
    if loinc?.VersionFirstReleased is string && loinc?.VersionFirstReleased != "" {
        properties.push({ code: "VersionFirstReleased", valueString: loinc?.VersionFirstReleased });
    }
    if loinc?.ValidHL7AttachmentRequest is string && loinc?.ValidHL7AttachmentRequest != "" {
        properties.push({ code: "ValidHL7AttachmentRequest", valueString: loinc?.ValidHL7AttachmentRequest });
    }
    if loinc?.DisplayName is string && loinc?.DisplayName != "" {
        properties.push({ code: "DisplayName", valueString: loinc?.DisplayName });
    }

    return properties;
}

function validateExtractedData() returns error? {
    // Parse the JSON in the "loinc-codesystem.json" at the end of the program
    string jsonString = check io:fileReadString("loinc-codesystem.json");

    // parse into CodeSystem object
    r4:CodeSystem codeSystem = check parser:parse(jsonString).ensureType();
    io:println("Validation successful, Parsed CodeSystem: ", codeSystem.url);
}

public function main() returns error? {
    LoincConcept[] loincData = check readLoincCsv(CSV_PATH);

    _ = check exportCodeSystem(loincData);
    _ = check validateExtractedData();
}
