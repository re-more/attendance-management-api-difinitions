#!/bin/sh
rm -r out/angular/*

for file in `\find ./definitions/ -maxdepth 1 -type f`; do
    filename=`basename ${file} .yaml`
    echo $filename
    service_kebab="${filename%%-service*}"
    service_camel=`echo $service_kebab | sed -r 's/(^|-)(.)/\U\2\E/g'`
    echo $service_camel
    java -jar openapi-generator-cli.jar generate -i ${file} -o out/angular/${service_kebab} -g typescript-angular --additional-properties="supportsES6=true,modelPropertyNaming=original,apiModulePrefix=$service_camel,fileNaming=kebab-case,npmName=@ec-apis/$service_kebab,npmRepository=http://158.201.254.20:8081/repository/npm-private/"
done


