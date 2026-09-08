#!/bin/bash
set -e

# Answers the question "why does dbt say the database is locked?".
#
# DuckDB stores everything in one file, and that file allows either ONE writer
# or SEVERAL readers — never both at once. So while another tool has the
# database open, `dbt run` cannot get in. This script tells you which tool that
# is, and how to make it let go.
#
# It deliberately does NOT kill anything: closing a connection properly is
# always safer than killing the process that owns it.
#
# Usage: ./scripts/db.sh [status]

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DB="${1:-$REPO_ROOT/jaffle_shop/jaffle_shop.duckdb}"

if [ ! -f "$DB" ]; then
  echo "No database file at $DB"
  echo "Nothing can be holding it. Run 'dbt seed' from the jaffle_shop folder to create it."
  exit 0
fi

# Find the PIDs holding the file open. lsof is present on macOS and most
# codespaces; if it is missing we fall back to scanning /proc (Linux only).
find_holders() {
  if command -v lsof >/dev/null 2>&1; then
    lsof -t -- "$DB" 2>/dev/null || true
  elif [ -d /proc ]; then
    for fd in /proc/[0-9]*/fd/*; do
      if [ "$(readlink -f "$fd" 2>/dev/null)" = "$DB" ]; then
        echo "$fd" | cut -d/ -f3
      fi
    done | sort -u
  fi
}

PIDS="$(find_holders)"

if [ -z "$PIDS" ]; then
  echo "✓ The database is free — nothing has $DB open."
  echo "  If dbt still reports a lock, run this again while the error is happening."
  exit 0
fi

echo "The database is currently held by:"
echo

for pid in $PIDS; do
  ARGS="$(ps -p "$pid" -o args= 2>/dev/null || true)"
  [ -z "$ARGS" ] && continue

  # Match against the command with the project path removed: this repo is called
  # "academy-dbt-group-training", so the path alone would make every process
  # look like dbt.
  MATCH="${ARGS//$REPO_ROOT/}"

  case "$MATCH" in
    *dbcode*|*DBCode*)
      WHO="DBCode (the database panel in VS Code)"
      FIX="open the DBCode panel and click Disconnect on the Jaffle Shop connection" ;;
    */dbt*|*dbt-power*|*dbt_power*)
      WHO="a dbt process"
      FIX="if a 'dbt run' is going in a terminal, let it finish; if not, it is the dbt Power User extension — reload the VS Code window (Cmd/Ctrl+Shift+P → Developer: Reload Window)" ;;
    *duckdb*)
      WHO="a DuckDB session (CLI or notebook)"
      FIX="close that session, or run .exit in the duckdb prompt" ;;
    *)
      WHO="another program"
      FIX="close it, or restart it if you are not sure what it is" ;;
  esac

  echo "  PID $pid — $WHO"
  echo "    $ARGS" | cut -c1-100
  echo "    → to release it: $FIX"
  echo
done

echo "Once it lets go, dbt will connect on its own — it now waits about a minute"
echo "for a busy database before giving up, so you usually do not have to rush."
