#!/bin/zsh

# $1 = design name
# $2 = vivado project directory (containing the runs folder)
# $3 = output format flag (0 for simple, 1 for CSV)

DESIGN_NAME=$1
PROJ_DIR=$2
OUT_FORMAT=${3:-0}

# Find the power report in the vivado project structure
# Look for .runs/impl_*/neuralut_power_routed.rpt
POWER_RPT=`find "$PROJ_DIR" -name "${DESIGN_NAME}_power_routed.rpt" 2>/dev/null | head -n 1`

if [[ -z "$POWER_RPT" ]]; then
  echo "Error: Power report not found in $PROJ_DIR" >&2
  exit 1
fi

cp "$POWER_RPT" /tmp/$DESIGN_NAME.pwr

# Parse power report for the summary values
# Look for: "| Total On-Chip Power (W)  | 0.424"
TOTAL_POWER=`grep "^| Total On-Chip Power" /tmp/$DESIGN_NAME.pwr | awk -F'|' '{print $3}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'`

# Look for: "| Dynamic (W)              | 0.222"
DYNAMIC_POWER=`grep "^| Dynamic (W)" /tmp/$DESIGN_NAME.pwr | awk -F'|' '{print $3}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'`

if [[ -z "$DYNAMIC_POWER" ]] || [[ -z "$TOTAL_POWER" ]]; then
  echo "Error: Could not parse power values from report" >&2
  exit 1
fi

# Convert to mW (multiply by 1000)
DYNAMIC_MW=`echo "$DYNAMIC_POWER * 1000" | bc -l | cut -d'.' -f1`
TOTAL_MW=`echo "$TOTAL_POWER * 1000" | bc -l | cut -d'.' -f1`

if [[ $OUT_FORMAT -eq 0 ]] ; then
  echo $DESIGN_NAME ${DYNAMIC_MW}mW ${TOTAL_MW}mW
else
  echo \'$DYNAMIC_MW\', \'$TOTAL_MW\'
fi
