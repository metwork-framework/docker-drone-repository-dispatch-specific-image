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
