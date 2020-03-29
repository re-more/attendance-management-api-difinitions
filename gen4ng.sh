#!/usr/bin/env bash

rm -rf out/angular
rm -rf out/html

if [[ ! -e openapi-generator-cli.jar ]]; then
    curl -o openapi-generator-cli.jar https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/4.3.0/openapi-generator-cli-4.3.0.jar
fi

java -jar openapi-generator-cli.jar \
  batch \
  services/attendance-service-html.yaml \
  services/attendance-service-angular.yaml \
  -v
