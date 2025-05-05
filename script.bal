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
function exportCodeSystem(LoincConcept[] concepts, string loincFilePath, string? 'version, boolean isExtract) returns error? {
    io:println("Exporting CodeSystem to JSON file: ", FHIR_LOINC_FILE_NAME, " ...");

    r4:CodeSystem codeSystem;

    if isExtract {
        codeSystem = check createCodeSystemResource(concepts, loincFilePath, 'version);
    } else {
        codeSystem = check createCodeSystemResourceFromJSON(concepts, loincFilePath, 'version);
    }
    
    check io:fileWriteString(FHIR_LOINC_FILE_NAME, codeSystem.toJson().toJsonString());
}

function validateExtractedData() returns error? {
    // Parse the JSON in the "loinc-codesystem.json" at the end of the program
    string jsonString = check io:fileReadString(FHIR_LOINC_FILE_NAME);

    // parse into CodeSystem object
    r4:CodeSystem codeSystem = check parser:parse(jsonString).ensureType();
    io:println("Successfully Parsed CodeSystem: ", codeSystem.url, ", version: ", codeSystem.version);
}

public function main(string... args) returns error? {
    if args.length() < 1 {
        return error("Insufficient arguments. At least the path to the LOINC file is required.");
    }

    string loincCsvPath;
    string loincCodeSystemPath;
    boolean isExtract = args[0] == "extract";

    if (isExtract) {
        // argument[0] is the command to extract the LOINC ZIP file
        // argument[1] is the path to the LOINC ZIP file
        // argument[2] is the version of the LOINC CodeSystem
        io:println("Extracting the concepts from LOINC ZIP file: ", args[1], " ...");

        check extractLoincZip(args[1]);
        loincCsvPath = EXTRACTED_FOLDER_PATH + LOINC_CSV_FILE_PATH;
        loincCodeSystemPath = EXTRACTED_FOLDER_PATH + LOINC_XML_FILE_PATH;

        io:println("Extracted LOINC CSV file: ", loincCsvPath, " and LOINC XML file: ", loincCodeSystemPath, " ...");
    } else {
        // argument[0] is the path to the LOINC CSV file
        // argument[1] is the path to the LOINC CodeSystem JSON file
        // argument[2] is the version of the LOINC CodeSystem
        io:println("Extract the concepts from CSV file: ", args[0], " and extract the CodeSystem details from: ", args[1], " ...");

        loincCsvPath = args[0];
        loincCodeSystemPath = args[1];
    }

    LoincConcept[] loincData = check readLoincCsv(loincCsvPath);
    check exportCodeSystem(loincData, loincCodeSystemPath, args[2], isExtract);
    
    check validateExtractedData();

    if isExtract {
        check removeExtractedDirectory();
        io:println("Removed extracted directory: ", EXTRACTED_FOLDER_PATH);
    }
}
