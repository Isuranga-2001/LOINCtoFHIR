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
function exportCodeSystem(LoincConcept[] concepts, string loincJsonPath) returns error? {
    io:println("Exporting CodeSystem to JSON file: ", FHIR_LOINC_FILE_NAME, " ...");

    r4:CodeSystem codeSystem = check createCodeSystemResource(concepts, loincJsonPath);
    check io:fileWriteString(FHIR_LOINC_FILE_NAME, codeSystem.toJson().toJsonString());
}

function validateExtractedData() returns error? {
    // Parse the JSON in the "loinc-codesystem.json" at the end of the program
    string jsonString = check io:fileReadString(FHIR_LOINC_FILE_NAME);

    // parse into CodeSystem object
    r4:CodeSystem codeSystem = check parser:parse(jsonString).ensureType();
    io:println("Successfully Parsed CodeSystem: ", codeSystem.url, ", version: ", codeSystem.version, "\n");
}

public function main(string path, string? codeSystemJsonPath) returns error? {
    string loincCsvPath;
    string loincJsonPath;

    if (codeSystemJsonPath is ()) {
        io:println("Extract the concepts from LOINC ZIP file: ", path, " ...");

        check extractLoincZip(path);
        loincCsvPath = EXTRACTED_FOLDER_PATH + LOINC_CSV_FILE_PATH;
        loincJsonPath = EXTRACTED_FOLDER_PATH + LOINC_XML_FILE_PATH;

        io:println("Extracted LOINC CSV file: ", loincCsvPath, " and LOINC XML file: ", loincJsonPath, " ...");

    } else {
        io:println("Extract the concepts from CSV file: ", path, " and extract the CodeSystem details from: ", codeSystemJsonPath, " ...");

        loincCsvPath = path;
        loincJsonPath = codeSystemJsonPath;
    }

    LoincConcept[] loincData = check readLoincCsv(loincCsvPath);
    check exportCodeSystem(loincData, loincJsonPath);
    check validateExtractedData();
}
