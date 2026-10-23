## What is this repository?

Didactical repository exemplifying how a Jupyter notebook can be converted into a script,
and how its execution can be automated, and parallelised, via Docker and Docker Compose.

It is part of the [Software Process Engineering](https://unibo-spe.github.io/) course at the University of Bologna
(cf. the [lecture on containerisation](https://unibo-spe.github.io/09-containerization/)),
and it is derived from [`gciatto/containerized-experiment`](https://github.com/gciatto/containerized-experiment).

## How to run the experiments

```bash
export HOST_UID=$(id -u) HOST_GID=$(id -g)   # let results in ./data be owned by you
docker compose up                             # runs all experiments in parallel
docker compose up experiment-svm              # runs just one experiment
```

Results are stored in `./data/<date>-<experiment>/`.
Experiments that were already executed (with the same parameters) are skipped,
so re-running `docker compose up` after an interruption only runs the missing ones.

## Pay attention to the history of commits

Run: `git log --oneline` to inspect the history of commits:

```plaintext
bfb0a13 feat: cap resources of each experiment, replace liblinear solver
1bbbe99 fix: do not leave empty output directories behind skipped experiments
dd0de24 fix: use tick_labels in boxplot, as labels is deprecated since matplotlib 3.9
ead3f0c chore(deps): drop notebook-only dependencies, update the others and Python to 3.14
b6823d3 fix: run experiments as the host user, rather than chown-ing results
1a83982 chore: add readme
19ba9fe feat: split experiments into different services
8293534 feat: support gridcv models parametrization
0fc62ff feat: organize experimental results to avoid repetitions
9e78fce fix: persmissions on data folder
9345702 feat: dockerize
84d3822 feat!: transform notebook into script
078562f feat: experiments notebook
```

1. Initially (`078562f`), the repository contained a Jupyter notebook with experiments
2. The first step (`84d3822`) was to convert the notebook into a script
3. The second step (`9345702`) was to dockerize the script (adding a `Dockerfile` and a `docker-compose.yml`)
4. To avoid issues with file permissions on the host, further changes (`9e78fce`) were made to the `Dockerfile`
5. The script was further improved (`0fc62ff`) to let the script recognize if a given experiment was already executed
6. The script was further improved (`8293534`) to allow for running scripts in parallel with different parameters
7. Experiments were split into different services (`19ba9fe`), one per model, which Docker Compose runs in parallel
8. Containers now run as the host user (`b6823d3`), instead of fixing the ownership of results at the end
9. Dependencies were cleaned up and updated (`ead3f0c`, `dd0de24`, `bfb0a13`), and resources were capped (`bfb0a13`)

> Use `git checkout <COMMIT_HASH>` to inspect the repository at a given commit

## Further possible improvements

+ Use GitHub Actions to automate the build of the Docker image
+ Use GitHub Actions to automate the execution of the experiments
+ Use Renovate or Dependabot to keep the dependencies up-to-date

## Exercise

1. Select some experiment of your choice
    + e.g. from a course you attended, from your thesis, or from a published paper
    + better if it is a Jupyter notebook

2. Dockerize the solution in such a way that:
    + only scripts are present (no notebooks)
    + the experiments are dockerized and can be run via Docker Compose
    + the results are saved in a folder on the host machine, owned by the host user
    + the parameters of the experiments can be parametrized via environment variables
    + if the experiments for a given assignment of parameters are already executed,
    the script should recognize it and skip the execution
    + different assignments of parameters run in parallel, each with capped resources
