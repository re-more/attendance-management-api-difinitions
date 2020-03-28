#!/usr/bin/env bash
rm -r out/angular/*

if [[ ! -e openapi-generator-cli.jar ]]; then
    curl -o openapi-generator-cli.jar https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/4.3.0/openapi-generator-cli-4.3.0.jar
fi

for file in `\find ./definitions/ -maxdepth 1 -type f`; do
    filename=`basename ${file} .yaml`
    echo $filename
    service_kebab="${filename%%-service*}"
    service_camel=`echo $service_kebab | sed -r 's/(^|-)(.)/\U\2\E/g'`
    echo $service_camel
    java -jar openapi-generator-cli.jar generate -i ${file} -o out/angular/${service_kebab} -g typescript-angular --skip-validate-spec --additional-properties="supportsES6=true,modelPropertyNaming=original,apiModulePrefix=$service_camel,fileNaming=kebab-case"
done
