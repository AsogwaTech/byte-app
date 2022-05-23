#!/bin/bash

flutter pub run build_runner build --delete-conflicting-outputs
java -jar C:\jcodes\dev\sdk\flutter\.pub-cache\hosted\pub.dartlang.org\openapi_generator_cli-3.3.0\lib\openapi-generator.jar generate -i openapi-spec.yaml -g dart-dio-next -o api --type-mappings=State=StateModel "--additional-properties=pubName=api,pubAuthor=Gibah Joseph.."