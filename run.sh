#!/usr/bin/env bash
# Runs the experiment, storing its outputs in a fresh sub-directory of $DATA_DIR
set -euo pipefail
export OUTPUT_DIR="$DATA_DIR/$(date +%Y-%m-%d-%H-%M-%S)-$(hostname)"
mkdir -p "$OUTPUT_DIR"
python experiment.py | tee "$OUTPUT_DIR/output.log"
# If the experiment was skipped (as already executed), there is nothing worth keeping
if ! compgen -G "$OUTPUT_DIR/*.yaml" > /dev/null; then
    rm -r "$OUTPUT_DIR"
fi
