#!/bin/sh

# Define output file. Change "$PROJECT_DIR/Tests" to your test's root source folder, if it's not the default name.
PROJECT_DIR="."
PODS_ROOT="$PROJECT_DIR/Pods"
OUTPUT_FILE="$PROJECT_DIR/WeatherZoneTests/GeneratedMocks.swift"
echo "Generated Mocks File = $OUTPUT_FILE"

# Define input directory. Change "$PROJECT_DIR" to your project's root source folder, if it's not the default name.
INPUT_DIR="$PROJECT_DIR/WeatherZone"
echo "Mocks Input Directory = $INPUT_DIR"

# Generate mock files, include as many input files as you'd like to create mocks for.
${PODS_ROOT}/Cuckoo/run generate --testable "WeatherZone" \
--output "${OUTPUT_FILE}" \
"$INPUT_DIR/ViewModel/CityListViewModel/CityListViewModelProtocol.swift" \
"$INPUT_DIR/ViewModel/CityListViewModel/CityListViewModel.swift" \
"$INPUT_DIR/ViewModel/WeatherViewModel/WeatherViewModelProtocol.swift" \
"$INPUT_DIR/ViewModel/WeatherViewModel/WeatherViewModel.swift" \
"$INPUT_DIR/APIHandler/GetWeatherHandlerProtocol.swift" \
"$INPUT_DIR/APIHandler/GetWeatherHandler.swift" \
"$INPUT_DIR/APIHandler/CityListHandlerProtocol.swift" \
"$INPUT_DIR/APIHandler/CityListHandlerProtocol.swift" \
# ... and so forth
