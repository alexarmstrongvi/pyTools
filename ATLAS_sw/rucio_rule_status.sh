#python compare_sample_lists.py complete_tasks.txt turn_into_susynts.txt --keep_shared -o replicate_these_susynts.txt --plain
#source ~/LexTools/ATLAS_sw/rucio_replicate_samples.sh replicate_these_susynts.txt
#cat failed_tasks.txt | grep -oP [0-9]{4} | panda-resub-taskid

ifile=${1}
echo "Getting rule status for samples listed in $ifile"
rucio list-rules --account alarmstr > rucio_rules.txt
> replica_status_completed_tasks.txt
for s in $(cat $ifile); do echo $s; grep $s rucio_rules.txt >> replica_status_completed_tasks.txt; done

echo ""
echo -n "Number of results replicating " 
grep "REPLICATING\[" replica_status_completed_tasks.txt | wc -l
echo -n "Rules that are not OK or Replicating "
grep -v "OK\[" replica_status_completed_tasks.txt | grep -v "REPLICATING\[" | wc -l
echo -n "Number of results finished " 
grep "OK\[" replica_status_completed_tasks.txt | wc -l

