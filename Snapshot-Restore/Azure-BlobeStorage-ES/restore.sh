#!/bin/bash
## Time format should be in (MM/DD/YYYY)
SnapTime=01/01/2019
ESHost='http://10.50.144.190:9200' # include https:// and avoid trailing /
RepoName='development-elasticsearch-storage' # the Elasticsearch API endpoint _snapshot/registryname


EpochSnapTime=$(date "+%s%3N" -d "$SnapTime UTC 00:00:00")
echo "Need to find a snapshot which had taken before $EpochSnapTime"
LatestSnapTime=0

if [[ $? -ne 0 ]] ; then
    echo "SnapTime format is incorrect; Time format should be in (MM/DD/YYYY)"
    exit 1
fi


SnapEpochTime=$(curl -s $ESHost/_cat/snapshots/$RepoName | cut -d" " -f1 | cut -d"-" -f2)
for i in $SnapEpochTime; do
    if [[ $i -gt $EpochSnapTime ]] ; then
        echo "snapshot : snapshot-$i had taken after $SnapTime, so neglecting..."
    else
        if [[ $i -gt $LatestSnapTime ]] ; then
            LatestSnapTime=$i ; echo "latest snapshot is : snapshot-$LatestSnapTime"
        fi
    fi
done


if [[ ! $LatestSnapTime -eq 0 ]] ; then
    echo "Last snapshot before $SnapTime ; snapshot-$LatestSnapTime is being restoring"
    curl -XPOST $ESHost/_snapshot/$RepoName/snapshot-$LatestSnapTime/_restore?wait_for_completion=true
fi