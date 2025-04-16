import ballerina/io;
import ballerina/data.csv;
import ballerina/lang.value;
import ballerinax/health.fhir.r4;

type Concept record {
    string code;
    string display;
};

const string CSV_PATH = "loinc/LoincTable/LOINC.csv"; // Change this to your full LOINC path

// Function to read the LOINC CSV file
function readLoincCsv(string path) returns Concept[]|error {
    Concept[] concepts = [];
    csv:ReadableCSVChannel csvChannel = check csv:openReadableCsvChannel(path, csv:DEFAULT_READ_OPTIONS);
    stream<map<string>, io:Error?> csvStream = csvChannel.getRecords();

    // Iterate through the CSV stream and map the data to the Concept type
    error? e = csvStream.forEach(function(map<string> row) {
        string code = row.get("LOINC_NUM") ?: "Unknown";
        string display = row.get("COMPONENT") ?: "Unknown";
        concepts.push({
            code: code,
            display: display.trim()
        });
    });

    return concepts;
}

// Function to create the CodeSystem resource
function createCodeSystemResource(Concept[] concepts) returns r4:CodeSystem {
    return {
        resourceType: "CodeSystem",
        id: "loinc",
        url: "http://loinc.org",
        version: "2.8",
        name: "LOINC",
        title: "LOINC CodeSystem",
        status: "active",
        content: "complete",
        concept: concepts
    };
}

// Function to export the combined CodeSystem resource to a JSON file
function exportCombined(Concept[] concepts) returns error? {
    r4:CodeSystem codeSystem = createCodeSystemResource(concepts);
    json jsonContent = check value:toJSON(codeSystem);
    string filePath = "loinc-codesystem.json";
    check io:fileWriteString(filePath, jsonContent.toJsonString());
    io:println("Combined all concepts into " + filePath);
}

public function main() {
    Concept[]|error loincData = readLoincCsv(CSV_PATH);
    if (loincData is error) {
        io:println("Error reading LOINC CSV: ", loincData);
        return;
    }
    error? result = exportCombined(loincData);
    if (result is error) {
        io:println("Error exporting combined CodeSystem: ", result);
    }
}