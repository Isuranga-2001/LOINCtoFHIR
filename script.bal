import ballerina/io;
import ballerinax/health.fhir.r4;
import ballerinax/health.fhir.r4.parser;

// Function to read the LOINC CSV file
function readLoincCsv(string path) returns LoincConcept[]|error {
    io:println("Reading LOINC CSV file from: ", path, " ...");
    LoincConcept[]|io:Error content = io:fileReadCsv(path);
    return content;
}

// Function to export the combined CodeSystem resource to a JSON file
function exportCodeSystem(LoincConcept[] concepts, string loincJsonPath, string fileName) returns error? {
    io:println("Exporting CodeSystem to JSON file: ", fileName, " ...");
    r4:CodeSystem codeSystem = check createCodeSystemResource(concepts, loincJsonPath);
    json jsonContent = codeSystem.toJson();
    check io:fileWriteString(fileName, jsonContent.toJsonString());
    io:println("CodeSystem exported to ", fileName);
}

function validateExtractedData(string fileName) returns error? {
    // Parse the JSON in the "loinc-codesystem.json" at the end of the program
    string jsonString = check io:fileReadString(fileName);

    // parse into CodeSystem object
    r4:CodeSystem codeSystem = check parser:parse(jsonString).ensureType();
    io:println("Successfully Parsed CodeSystem: ", codeSystem.url, ", version: ", codeSystem.version, "\n");
}

public function main(string path, string loincJsonPath, string? fhirFileName) returns error? {
    if (path == "" || loincJsonPath == "") {
        io:println("Please provide the path to the CSV file and the output JSON path as arguments.");
        return error("Path not provided");
    }

    LoincConcept[] loincData = check readLoincCsv(path);

    string fileName = fhirFileName !is string ? "loinc-codesystem.json" : fhirFileName + ".json";

    _ = check exportCodeSystem(loincData, loincJsonPath, fileName);
    _ = check validateExtractedData(fileName);
}
