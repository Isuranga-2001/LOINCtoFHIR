# LOINCtoFHIR

## Overview

LOINCtoFHIR is a Ballerina-based project designed to convert LOINC (Logical Observation Identifiers Names and Codes) data from a CSV file into a FHIR (Fast Healthcare Interoperability Resources) CodeSystem resource. This tool facilitates the integration of LOINC concepts into FHIR-compliant systems, enabling seamless interoperability in healthcare applications.

## Features

- Reads LOINC data from a CSV file.
- Converts LOINC concepts into FHIR R4 CodeSystem resources.
- Exports the combined CodeSystem resource to a JSON file.

## Prerequisites

- [Ballerina](https://ballerina.io/) installed on your system.
- A LOINC CSV file (e.g., `loinc.csv`) located in the `loinc/LoincTable/` directory.

## Project Structure

``` structure
LOINCtoFHIR/
├── loinc/
│   └── LoincTable/
│       └── loinc.csv  # Input LOINC CSV file
├── script.bal        # Main Ballerina script
├── loinc-codesystem.json  # Output JSON file (generated)
└── README.md         # Project documentation
```

## Usage

1. **Prepare the LOINC CSV File**  
   Place your LOINC CSV file in the `loinc/LoincTable/` directory. Ensure the file is named `test.csv` or update the `CSV_PATH` constant in `script.bal` accordingly.

2. **Run the Script**  
   Execute the Ballerina script to generate the FHIR CodeSystem resource:

   ```bash
   bal run
   ```

3. **Output**  
   The combined CodeSystem resource will be exported as `loinc-codesystem.json` in the project root directory.

## Error Handling

- If the script encounters an error while reading the CSV file, it will print an error message and terminate.
- Any issues during the export process will also be logged to the console.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments

- [LOINC](https://loinc.org/) for providing the standard for identifying health measurements, observations, and documents.
- [FHIR](https://www.hl7.org/fhir/) for enabling healthcare data interoperability.
