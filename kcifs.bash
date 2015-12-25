user=plex
data="/root"

echo ""
if [ -a ${data}/cifs-mon.txt ]; then
echo "Montior file found!"
else
echo "[NOTICE!] No Monitor file, using current mounts for monitor"
echo "$(mount | grep cifs | awk -F " " '{print $3}')" > ${data}/cifs-mon.txt
fi
echo "$(mount | grep cifs | awk -F " " '{print $3}')" > ${data}/.currmp
echo "NuStor CIFS K.A. by Kazari"
echo "= Connected =========="
for mp in $(cat ${data}/.currmp)
do
echo -n "$mp"
su $user -c "touch $mp/$(hostname).ka" 2> /dev/null
if [ -a $mp/$(hostname).ka ]; then
echo "	[ OK ]"
else
echo "	[FAIL]"
fi
done
echo "= Disconnected ======="
for nmp in $(awk 'FNR==NR{a[$0];next}!($0 in a)' ${data}/.currmp ${data}/cifs-mon.txt)
do
echo -n "$nmp"
rm "$nmp/$(hostname).ka" 2> /dev/null
if [ -a $nmp/$(hostname).ka ]; then
echo -n "	[FAIL-"
else 
echo -n "	[ OK -"
fi
mount $nmp 2> /dev/null
if [ -a $nmp/$(hostname).ka ]; then
echo " OK ]"
else 
echo "FAIL]"
fi

done
echo "======================"
