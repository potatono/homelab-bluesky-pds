#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

echo "NOTE: This does not update all of PDS, it only updates the admin scripts."
echo "Updating pdsadmin scripts.."

PDSADMIN_BASEURL="https://raw.githubusercontent.com/bluesky-social/pds/refs/heads/main/pdsadmin"

curl --silent -o $PDS_ROOT/bin/account.sh $PDSADMIN_BASEURL/account.sh
curl --silent -o $PDS_ROOT/bin/create-invite-code.sh $PDSADMIN_BASEURL/create-invite-code.sh
curl --silent -o $PDS_ROOT/bin/help.sh $PDSADMIN_BASEURL/help.sh
curl --silent -o $PDS_ROOT/bin/request-crawl.sh $PDSADMIN_BASEURL/request-crawl.sh



