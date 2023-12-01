# docker-drone-repository-dispatch-specific-image

[//]: # (automatically generated from https://github.com/metwork-framework/github_organization_management/blob/master/common_files/README.md)

**Status (master branch)**

[![GitHub CI](https://github.com/metwork-framework/docker-drone-repository-dispatch-specific-image/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/metwork-framework/docker-drone-repository-dispatch-specific-image/actions?query=workflow%3ACI+branch%3Amaster)
[![DockerHub](https://github.com/metwork-framework/resources/blob/master/badges/dockerhub_link.svg)](https://hub.docker.com/r/metwork/drone-repository-dispatch-specific-image/)
[![Maintenance](https://raw.githubusercontent.com/metwork-framework/resources/master/badges/maintained.svg)](https://github.com/metwork-framework/resources/blob/master/badges/maintained.svg)




## What is it ?

This is a custom drone plugin to trigger branch repository build with repository-dispatch from a drone build of another repository
(for our use case and our CI hardware).

The idea is to get a conditional "downstream" plugin. If there is a `.drone_downstream_bypass`
file in the working directory, the step is bypassed.

## Configuration example

```
pipeline:
  step:
    image: metwork/drone-repository-dispatch-specific-image:latest
    secrets: [ downstream_github_token ]
    repositories:
      - metwork-framework/mfserv
      - metwork-framework/mfbase@integration
    params:
      - foo1=bar1
      - foo2=bar2
    when:
      branch: master
      event: push
      status: success
```






## Contributing guide

See [CONTRIBUTING.md](CONTRIBUTING.md) file.



## Code of Conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) file.



## Sponsors

*(If you are officially paid to work on MetWork Framework, please contact us to add your company logo here!)*

[![logo](https://raw.githubusercontent.com/metwork-framework/resources/master/sponsors/meteofrance-small.jpeg)](http://www.meteofrance.com)
