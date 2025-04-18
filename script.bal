import ballerina/io;
import ballerinax/health.fhir.r4;

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
function exportCombined(LoincConcept[] concepts) returns error? {
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
            display: loinc.COMPONENT
        };
        r4Concepts.push(concept);
    }
    return r4Concepts;
}

public function main() {
    LoincConcept[]|error loincData = readLoincCsv(CSV_PATH);
    if (loincData is error) {
        io:println("Error reading LOINC CSV: ", loincData);
        return;
    }
    error? result = exportCombined(loincData);
    if (result is error) {
        io:println("Error exporting combined CodeSystem: ", result);
    }
}
