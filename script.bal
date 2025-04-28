import ballerina/io;
import ballerinax/health.fhir.r4;
import ballerinax/health.fhir.r4.parser;
// import ballerina/xmldata;

const string CSV_PATH = "loinc/LoincTable/Loinc.csv";
const string XML_PATH = "loinc/loinc.xml";

// Function to read the LOINC CSV file
function readLoincCsv(string path) returns LoincConcept[]|error {
    LoincConcept[]|io:Error content = io:fileReadCsv(path);
    return content;
}

// Function to read the LOINC XML file
function getCodeSystemDataFromXml(string path) returns r4:CodeSystem|error {
    xml|io:Error codeSystemContent = io:fileReadXml(path);

    if codeSystemContent is error {
        return codeSystemContent;
    }

    // LoincCodeSystem xmlCodeSystem = check xmldata:fromXml(codeSystemContent, LoincCodeSystem);
    // io:println("Parsed XML CodeSystem: ", xmlCodeSystem.toString());

    // convert XML to CodeSystem
    // var codeSystem = check parser:parse(content, r4:CodeSystem);

    // io:println("CodeSystem Content: ", codeSystemContent.toString());

    xml:Element personElement = check codeSystemContent.cloneWithType(xml:Element);

    io:println("Name: ", personElement.getChildren().filter(x => x is xml:Element && x.getName() == "Name")[0]);

    r4:CodeSystem codeSystem = {
        name: check codeSystemContent.name,
        'version: check codeSystemContent.'version,
        content: "example",
        status: "active"
    };

    io:println(codeSystem.toJsonString());
    return codeSystem;
}

// Function to create the CodeSystem resource
function createCodeSystemResource(r4:CodeSystem codeSystemData, LoincConcept[]? concepts) returns r4:CodeSystem {
    return {
        resourceType: "CodeSystem",
        id: codeSystemData.id,
        url: codeSystemData.url,
        'version: codeSystemData.version,
        name: codeSystemData.name,
        title: codeSystemData.title,
        status: codeSystemData.status,
        content: codeSystemData.content,
        concept: LoincConceptToR4Concept(concepts)
    };
}

// Function to export the combined CodeSystem resource to a JSON file
function exportFHIR(LoincConcept[] concepts, r4:CodeSystem codeSystemData) returns error? {
    r4:CodeSystem codeSystem = createCodeSystemResource(codeSystemData, concepts);
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
            display: loinc.COMPONENT
        };
        r4Concepts.push(concept);
    }
    return r4Concepts;
}

function validateExtractedData() returns boolean|error {
    // Parse the JSON in the "loinc-codesystem.json" at the end of the program
    string jsonString = check io:fileReadString("loinc-codesystem.json");

    // parse into CodeSystem object
    r4:CodeSystem codeSystem = check parser:parse(jsonString).ensureType();
    io:println("Validation successful, Parsed CodeSystem: ", codeSystem.url);
    return true;
}

public function main() {
    // Read the LOINC XML file to get CodeSystem data
    r4:CodeSystem|error codeSystemData = getCodeSystemDataFromXml(XML_PATH);
    if (codeSystemData is error) {
        io:println("Error reading LOINC XML: ", codeSystemData);
        return;
    }

    // Read the LOINC CSV file to get concepts
    LoincConcept[]|error loincData = readLoincCsv(CSV_PATH);
    if (loincData is error) {
        io:println("Error reading LOINC CSV: ", loincData);
        return;
    }

    // Create and export the combined CodeSystem resource
    error? result = exportFHIR(loincData, codeSystemData);
    if (result is error) {
        io:println("Error exporting the CodeSystem: ", result);
    }

    // Validate the extracted data
    boolean|error validationResult = validateExtractedData();
    if (validationResult is error) {
        io:println("Error validating extracted data: ", validationResult);
    }
}
