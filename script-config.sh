#!/bin/bash
CONFIG_VERSION=3.3-Gigantuar
######################
#   USER VARIABLES   #
######################

####################### USER CONFIGURATION START #######################

### NOTIFICATION SETTINGS ###

# Address where the output will be emailed to.
# If you do not want to receive emails and rely on other notification
# methods, leave these fields empty.
EMAIL_ADDRESS="destination-email-goes-here"
FROM_EMAIL_ADDRESS="sender-email-goes-here"

# Enable if using S-nail to provide mailx for correct syntax
SNAIL_ENABLED=0
# Enable sending via SMTP Relay by defining the SMTP mta string in SNAIL_SMTP.
# If you do not wish to utilize a relay leave this field blank. Mail will be
# sent directly or honor the local mail.rc/.mailrc config.
SNAIL_SMTP="smtp://smtp-server-address-here"

# Use Healthchecks.io to report script errors. Set to 1 to enable.
# Please note that every "WARNING" will be reported as failure.
# When enabled, enter your Healthchecks UUID (not the full URL).
HEALTHCHECKS=0
HEALTHCHECKS_ID="your-uuid-here"

# Use Telegram to report script execution summary (not the whole report)
# Set 1 to enable. Create a bot using @botfather, then copy the API token.
# To get your chat ID, use @getidsbot
TELEGRAM=0
TELEGRAM_TOKEN="your-token-here"
TELEGRAM_CHAT_ID="your-chat-id-here"

# Use Discord to report script execution summary (not the whole report)
# Set 1 to enable.
# To get your Webhook URL go to the channel settings -> Integrations and
# create a web hook
DISCORD=0
DISCORD_WEBHOOK_URL="your-webhook-url"

# Use Pushover to report script execution summary (not the whole report)
# Set 1 to enable.
PUSHOVER=0
# Create your own Pushover API application key for the script.
# https://pushover.net/api#registration
PO_API_KEY="application-api-token-here"
PO_USER_KEY="user-key-here"
# Optional device to target for alert. Leave blank for all devices.
PO_DEVICE=
# Desired priority for notifications. Leave empty to disable invidual notification.
# https://pushover.net/api#priority
# -2 - Lowest Priority - will not generate any notification
# -1 - Low Priority - will not generate any sound or vibration
#  0 - Normal Priority - trigger an alert according to the user's device settings
#  1 - High Priority - bypass a user's quiet hours
#  2 - Emergency Priority - repeat until acknowledged by the user
PO_PRIORITY_JOBSTART=0
PO_PRIORITY_SUCCESS=0
PO_PRIORITY_WARNING=0
# Desired sound alerts for notifications.
# https://pushover.net/api#sounds
# pushover = default
# vibrate = vibrate only
# none = silent
PO_SOUND_JOBSTART=pushover
PO_SOUND_SUCCESS=pushover
PO_SOUND_WARNING=tugboat

# Custom notification service
# Set this to a script/service to be used instead of the default email
# notification. You may want to use a service not natively supported by this
# script or a mail service with custom formatting.
# If you don't want to use this option, don't make changes to this.
# $CURRENT_DIR can be used to get the running directory of the script.
# This script will pass the following parameters to HOOK_NOTIFICATION:
# 1st parameter will be the subject
# 2nd parameter will be the body
HOOK_NOTIFICATION=""

### SCRIPT AND SNAPRAID SETTINGS ###

# Check for necessary package availability and if necessary attempt to install
# the packages automatically. 1 to enable, any other value to disable.
PKG_CHECK=1

# Set the threshold of deleted files to stop the sync job from running. Note
# that depending on how active your filesystem is being used, a low number here
# may result in your parity info being out of sync often and/or you having to
# do lots of manual syncing.
DEL_THRESHOLD=500
UP_THRESHOLD=500

# Set number of warnings before we force a sync job. This option comes in handy
# when you cannot be bothered to manually start a sync job when DEL_THRESHOLD
# is breached due to false alarm. Set to 0 to ALWAYS force a sync (i.e. ignore
# the delete threshold above) Set to -1 to NEVER force a sync (i.e. need to
# manual sync if delete threshold is breached).
SYNC_WARN_THRESHOLD=-1

# Set percentage of array to scrub if it is in sync. i.e. 0 to disable and 100
# to scrub the full array in one go WARNING - depending on size of your array,
# setting to 100 will take a very long time!
SCRUB_PERCENT=5
SCRUB_AGE=10

# Set number of script runs before running a scrub. Use this option if you
# don't want to scrub the array every time.
# Set to 0 to disable this option and run scrub every time.
SCRUB_DELAYED_RUN=0

# Prehash Data To avoid the risk of a latent hardware issue, you can enable the
# "pre-hash" mode and have all the data read two times to ensure its integrity.
# This option also verifies the files moved inside the array, to ensure that
# the move operation went successfully, and in case to block the sync and to
# allow to run a fix operation. 1 to enable, any other value to disable.
PREHASH=1

# Forces the operation of syncing a file with zero size that before was not.
# If SnapRAID detects a such condition, it stops proceeding unless you enable
# this option. Useful when syncing system files which can genuinely get
# changed to zero.
# Disabled by default, 1 to enable.
FORCE_ZERO=0

# Set if disk spindown should be performed. Depending on your system, this may
# not work. 1 to enable, any other value to disable.
# hd-idle is required and must be already configured.
SPINDOWN=0

# Set the option to log SMART info collected by SnapRAID. 1 to enable and any
# other value to disable.
SMART_LOG=1

# Increase verbosity of the email output. NOT RECOMMENDED!
# If set to 1, TOUCH and DIFF outputs will be kept in the email, producing
# a mostly unreadable email. You can always check TOUCH and DIFF outputs
# using the TMP file or use the feature KEEP_LOG.
# 1 to enable, any other value to disable.
VERBOSITY=0

# SnapRAID detailed output retention for each run.
# Default behaviour is RETENTION_DAYS=0: every time your run SnapRAID, the
# output is saved to "/tmp" and is overridden during every run.
# To enable retention, set RETENTION_DAYS to the days of output you want to
# keep in your home folder. Files will have timestamps.
# SNAPRAID_LOG_DIR can be changed to any folder you like.
RETENTION_DAYS=0
SNAPRAID_LOG_DIR="$HOME"

# Run 'snapraid status' command to show array general information.
# 1 to enable, any other value to disable.
SNAP_STATUS=0

### DOCKER CONTAINERS MANAGEMENT ###

# Set to 1 to manage docker containers. They will be paused/stopped or
# resumed/restarted accordingly. If set to 0, all other options related to Docker
# will be ignored.
MANAGE_SERVICES=0

# Choose how to manage your containers: 1 to pause/unpause, 2 to stop/restart
# This option does not have any effect if MANAGE_SERVICES is set to 0
DOCKER_MODE=1

# Containers to manage (separated with spaces). Please ensure these containers
# are always running before executing the script, otherwise an error will be logged.
SERVICES='container1 container2 container3'

# Manage docker containers running on a remote machine. To use this feature,
# you must setup passwordless ssh access between snapRAID host and Docker host.
# Set to 1 to enable, then enter Docker host SSH user and machine IP or hostname.
# You can manage multiple remote Docker hosts.
# Please note: for this configuration DO NOT separate containers with spaces.
# Use a comma instead.
# Reference:
# ('HOSTIP1:container1,container2,container3' 'HOSTIP2:container1,container2,container3,container4')
# Example:
# ('192.168.0.125:code-server,portainer,plex' '192.168.0.126:nextcloud,handbrake,transmission')
# Delay is the number of seconds to wait before sending the next docker
# command to avoid errors. Change it if you're experiencing errors.
DOCKER_REMOTE=0
DOCKER_USER="sshusernamegoeshere"
DOCKER_HOST_SERVICES=('HOSTIP1:container1,container2,container3' 'HOSTIP2:container1,container2,container3,container4')
DOCKER_DELAY=10

### CUSTOM HOOKS ###

# Hooks are shell commands that the scripts executes for you.
# You can specify 'before_hook' to perform preparation steps before SnapRAID
# actions and 'after_hook' to perform steps afterwards.

# Set to 1 to enable custom hooks
CUSTOM_HOOK=0

# Custom hook before SnapRAID activities
# This custom hook executes when pre-processing is complete and before
# SnapRAID operations.
# This option does not have any effect if CUSTOM_HOOK is set to 0
# Use NAME for a friendly name, CMD for the command itself.
BEFORE_HOOK_NAME=""
BEFORE_HOOK_CMD=""

# Custom hook after SnapRAID activities
# This custom hook executes after SnapRAID operations and will be the
# last command.
# This option does not have any effect if CUSTOM_HOOK is set to 0
# Use NAME for a friendly name, CMD for the command itself.
AFTER_HOOK_NAME=""
AFTER_HOOK_CMD=""

####################### USER CONFIGURATION END #######################

####################### SYSTEM CONFIGURATION #######################
# Please make changes only if you know what you're doing

# location of the snapraid binary
SNAPRAID_BIN="/usr/bin/snapraid"
# location of the mail program binary
MAIL_BIN="/usr/bin/mailx"

# Init variables
CHK_FAIL=0
DO_SYNC=0
EMAIL_SUBJECT_PREFIX="(SnapRAID on $(hostname))"
SERVICES_STOPPED=0
SYNC_WARN_FILE="$CURRENT_DIR/snapRAID.warnCount"
SCRUB_COUNT_FILE="$CURRENT_DIR/snapRAID.scrubCount"
TMP_OUTPUT="/tmp/snapRAID.out"
SNAPRAID_LOG="/var/log/snapraid.log"
SECONDS=0 #Capture time
SNAPRAID_CONF="/etc/snapraid.conf"

# Expand PATH for smartctl
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# Extract info from SnapRAID config
SNAPRAID_CONF_LINES=$(grep -E '^[^#;]' $SNAPRAID_CONF)

IFS=$'\n'
# Build an array of content files
CONTENT_FILES=(
  $(echo "$SNAPRAID_CONF_LINES" | grep snapraid.content | cut -d ' ' -f2)
)

# Build an array of parity all files...
PARITY_FILES=(
  $(echo "$SNAPRAID_CONF_LINES" | grep -E '^([2-6z]-)*parity' | cut -d ' ' -f2- | tr ',' '\n')
)

# Build an array of all data disk mount points...
DATA_DISKS=(
  $(echo "$SNAPRAID_CONF_LINES" | grep '^data' | cut -d ' ' -f3)
)
unset IFS
