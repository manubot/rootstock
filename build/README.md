# Building the manuscript

[`build.sh`](build.sh) builds the repository.
`sh build.sh` should be executed from the root directory of the repository.
`BUILD_DOCX=true sh build/build.sh` should be executed to build DOCX document, otherwise will be skipped.

## Environment

Install the [conda](https://conda.io) environment specified in [`environment.yml`](environment.yml) by running:

```sh
conda env create --file environment.yml
```

Activate with `source activate manubot`.
Currently, the environment requires Linux.
