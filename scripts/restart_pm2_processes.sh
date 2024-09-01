#!/bin/bash

# Source the user's profile to ensure all necessary environment variables are set
source ~/.profile

# Use the full path to PM2
PM2_PATH=$(which pm2)

# Define paths to the potential start_var files
START_VAR_MINER="$(dirname "$0")/../.start_var_miner"
START_VAR_VALIDATOR="$(dirname "$0")/../.start_var_validator"

# Check if either .start_var_miner or .start_var_validator exists
if [ -f "$START_VAR_MINER" ] || [ -f "$START_VAR_VALIDATOR" ]; then
    echo "One of the start_var files exists."
    if [ -f "$START_VAR_MINER" ]; then
        echo "Loading variables from $START_VAR_MINER..."
        source "$START_VAR_MINER"
    elif [ -f "$START_VAR_VALIDATOR" ]; then
        echo "Loading variables from $START_VAR_VALIDATOR..."
        source "$START_VAR_VALIDATOR"
    fi
else
    echo "No start_var file found. Proceeding to check PM2 processes..."

    # Iterate through all PM2 processes
     # Iterate through all PM2 processes
      # Use pm2 jlist to get details of all processes
    pm2 jlist | jq -c '.[]' | while read -r process; do
        # Extract the necessary details using jq
        INSTANCE_NAME=$(echo "$process" | jq -r '.name')
        SCRIPT_PATH=$(echo "$process" | jq -r '.pm2_env.pm_exec_path')
        ARGS=$(echo "$process" | jq -r '.pm2_env.args | join(" ")')

        # Extract --netuid value from ARGS
        NETUID=$(echo "$ARGS" | grep -oP '(?<=--netuid\s)\S+')

        # Print the instance name, script path, and args for debugging
        echo "Checking $INSTANCE_NAME: $SCRIPT_PATH $ARGS"

        # Process only if netuid is 14
        if [ "$NETUID" = "1" ]; then
            # Initialize variables
            NEURON_TYPE=""
            OUTPUT_FILE=""
            NETWORK_UID="$NETUID"
            CHAIN_ENDPOINT=$(echo "$ARGS" | grep -oP '(?<=--subtensor.chain_endpoint\s)\S+')
            NETWORK=$(echo "$ARGS" | grep -oP '(?<=--subtensor.network\s)\S+')
            WALLET_NAME=$(echo "$ARGS" | grep -oP '(?<=--wallet.name\s)\S+')
            WALLET_HOTKEY=$(echo "$ARGS" | grep -oP '(?<=--wallet.hotkey\s)\S+')
            AXON=$(echo "$ARGS" | grep -oP '(?<=--axon.port\s)\S+')
            LOGGING_LEVEL="debug"
            DEFAULT_NEURON_ARGS="$ARGS"

            echo "found process $INSTANCE_NAME"

            # Determine the type and set the output file accordingly
            if [[ "$SCRIPT_PATH" == *"miner"* ]]; then
                NEURON_TYPE="MINER"
                OUTPUT_FILE="$START_VAR_MINER"
            elif [[ "$SCRIPT_PATH" == *"validator"* ]]; then
                NEURON_TYPE="VALIDATOR"
                OUTPUT_FILE="$START_VAR_VALIDATOR"
            fi


            echo "repo root: $REPO_ROOT"

            # Write to the appropriate output file
            if [ -n "$OUTPUT_FILE" ]; then
                {
                    [ -n "$NEURON_TYPE" ] && echo "NEURON_TYPE=$NEURON_TYPE"
                    [ -n "$NETWORK_UID" ] && echo "NETWORK_UID=$NETWORK_UID"
                    [ -n "$CHAIN_ENDPOINT" ] && echo "CHAIN_ENDPOINT=$CHAIN_ENDPOINT"
                    [ -n "$NETWORK" ] && echo "NETWORK=$NETWORK"
                    [ -n "$WALLET_NAME" ] && echo "WALLET_NAME=$WALLET_NAME"
                    [ -n "$WALLET_HOTKEY" ] && echo "WALLET_HOTKEY=$WALLET_HOTKEY"
                    [ -n "$LOGGING_LEVEL" ] && echo "LOGGING_LEVEL=$LOGGING_LEVEL"
                    [ -n "$AXON" ] && echo "AXON=$AXON"
                    [ -n "$DEFAULT_NEURON_ARGS" ] && echo "DEFAULT_NEURON_ARGS=\"$DEFAULT_NEURON_ARGS\""
                    [ -n "$INSTANCE_NAME" ] && echo "INSTANCE_NAME=$INSTANCE_NAME"
                } > "$OUTPUT_FILE"
                echo "Variables written to $OUTPUT_FILE"
            fi
        fi
    done
fi

# exit 1

# Ensure INSTANCE_NAME, DEFAULT_NEURON_ARGS, and NEURON_TYPE are loaded from start_var
if [ -z "$INSTANCE_NAME" ] || [ -z "$DEFAULT_NEURON_ARGS" ] || [ -z "$NEURON_TYPE" ]; then
    echo "INSTANCE_NAME, DEFAULT_NEURON_ARGS, or NEURON_TYPE not found in start_var. Exiting."
    exit 1
fi

# Determine which script to start based on NEURON_TYPE
if [ "$NEURON_TYPE" = "MINER" ]; then
    NEURON_SCRIPT="$(dirname "$0")/../neurons/miner.py"
elif [ "$NEURON_TYPE" = "VALIDATOR" ]; then
    NEURON_SCRIPT="$(dirname "$0")/../neurons/validator.py"
else
    echo "Unknown NEURON_TYPE: $NEURON_TYPE. Exiting."
    exit 1
fi

# Check if the process with INSTANCE_NAME exists and delete it if it does
PROCESS_STATUS=$($PM2_PATH list | grep "$INSTANCE_NAME")

if [ -n "$PROCESS_STATUS" ]; then
    echo "Process with instance name $INSTANCE_NAME found. Deleting it..."
    $PM2_PATH delete "$INSTANCE_NAME"
    echo "Process $INSTANCE_NAME deleted."
else
    echo "No process found with instance name $INSTANCE_NAME."
fi

$PM2_PATH save --force

# Remove all double quotes from DEFAULT_NEURON_ARGS
DEFAULT_NEURON_ARGS=$(echo "$DEFAULT_NEURON_ARGS" | tr -d '"')

# Start the process with the determined neuron script and saved arguments
echo "Starting $INSTANCE_NAME with script $NEURON_SCRIPT and arguments: $DEFAULT_NEURON_ARGS"

$PM2_PATH start $NEURON_SCRIPT --interpreter=python3 --name "$INSTANCE_NAME" -- $DEFAULT_NEURON_ARGS
echo "$NEURON_TYPE started successfully with instance name: $INSTANCE_NAME"

# Save the PM2 process list
$PM2_PATH save --force

echo "PM2 process started and saved successfully"

# Ensure this script exits
# exit 0