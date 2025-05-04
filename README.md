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

## Usage

1. **Prepare the LOINC Data**  
   - To extract the CodeSystem from a LOINC ZIP file provided by LOINC.org, use the following command:

     ```bash
     bal run -- "extract" "Loinc_2.80.zip" "2.80"
     ```

     - The first argument is the command to extract the CodeSystem from the ZIP file.
     - The second argument is the path to the LOINC ZIP file.
     - The third argument is the version of the LOINC CodeSystem.

   - To provide the LOINC CSV file and the CodeSystem JSON file separately, use the following command:

     ```bash
     bal run -- "loinc.csv" "Loinc.json"
     ```

     - The first argument is the path to the LOINC CSV file.
     - The second argument is the path to the `Loinc.json` file, which contains the CodeSystem details (without concepts). Defaults to `loinc/loinc.json`.

2. **Run the Script**  
   Execute the appropriate command based on your input data to generate the FHIR CodeSystem resource.

3. **Output**  
   The combined CodeSystem resource will be exported as `loincCodeSystem.json` (or the specified file name) in the project root directory.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments

- [LOINC](https://loinc.org/) for providing the standard for identifying health measurements, observations, and documents.
- [FHIR](https://www.hl7.org/fhir/) for enabling healthcare data interoperability.
