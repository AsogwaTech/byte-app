import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
    additionalProperties:
        AdditionalProperties(pubName: 'api', pubAuthor: 'Gibah Joseph..'),
    inputSpecFile: 'openapi-spec.yaml',
    generatorName: Generator.dioNext,
    typeMappings: {'State': 'StateModel'},
    alwaysRun: true,
    outputDirectory: 'api')
class OpenSdkConfiguration {}
