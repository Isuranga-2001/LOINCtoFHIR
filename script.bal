import ballerina/io;
import ballerinax/health.fhir.r4;
import ballerinax/health.fhir.r4.parser;

const string CSV_PATH = "loinc/LoincTable/Loinc.csv";

// Function to read the LOINC CSV file
function readLoincCsv(string path) returns LoincConcept[]|error {
    LoincConcept[]|io:Error content = io:fileReadCsv(path);
    return content;
}

// Function to export the combined CodeSystem resource to a JSON file
function exportCodeSystem(LoincConcept[] concepts) returns error? {
    r4:CodeSystem codeSystem = createCodeSystemResource(concepts);
    json jsonContent = codeSystem.toJson();
    string filePath = "loinc-codesystem.json";
    check io:fileWriteString(filePath, jsonContent.toJsonString());
    io:println("CodeSystem exported to ", filePath);
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
