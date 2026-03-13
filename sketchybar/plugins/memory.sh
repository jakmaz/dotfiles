#!/bin/bash

# Get memory stats using vm_stat
MEMORY_STATS=$(vm_stat)

# Extract page size (usually 4096 bytes)
PAGE_SIZE=$(pagesize)

# Extract relevant memory values (in pages)
PAGES_FREE=$(echo "$MEMORY_STATS" | awk '/Pages free/ {print $3}' | tr -d '.')
PAGES_ACTIVE=$(echo "$MEMORY_STATS" | awk '/Pages active/ {print $3}' | tr -d '.')
PAGES_INACTIVE=$(echo "$MEMORY_STATS" | awk '/Pages inactive/ {print $3}' | tr -d '.')
PAGES_SPECULATIVE=$(echo "$MEMORY_STATS" | awk '/Pages speculative/ {print $3}' | tr -d '.')
PAGES_WIRED=$(echo "$MEMORY_STATS" | awk '/Pages wired down/ {print $4}' | tr -d '.')
PAGES_COMPRESSED=$(echo "$MEMORY_STATS" | awk '/Pages occupied by compressor/ {print $5}' | tr -d '.')

# Calculate memory in GB
TOTAL_MEMORY=$(sysctl -n hw.memsize | awk '{print $1 / 1073741824}')

# Used memory = Active + Wired + Compressed
USED_PAGES=$((PAGES_ACTIVE + PAGES_WIRED + PAGES_COMPRESSED))
USED_MEMORY=$(echo "$USED_PAGES $PAGE_SIZE" | awk '{printf "%.1f", ($1 * $2) / 1073741824}')

# Calculate percentage
MEMORY_PERCENT=$(echo "$USED_MEMORY $TOTAL_MEMORY" | awk '{printf "%.0f", ($1 / $2) * 100}')

sketchybar --set $NAME label="$MEMORY_PERCENT%"
