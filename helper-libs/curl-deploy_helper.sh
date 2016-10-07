#!/bin/bash
#Test from command line using ./curl-deploy_helper.sh POST/DELETE iAPPNAME <custom>

CMD=$1
APPNAME=$2-helper
CUSTOM=$3


deployment="f5opencart.westus.cloudapp.azure.com"
type="linux"
level="high"
asm_policy="https://cdn.f5.com/product/blackbox/azure/asm-policy"
custom_asm_policy="none"

if [ $CUSTOM == "custom" ]
	then
	custom_asm_policy="https://raw.githubusercontent.com/sevedge/azure/master/helper-libs/custom-asm-policy.xml"
fi

if [ $CMD == "POST" ]
	then
	echo "Creating $APPNAME..."
	curl -sku admin:admin-X POST -H "Content-Type: application/json" https://localhost/mgmt/tm/sys/application/service/ -d '{"name":"'"$APPNAME"'","partition":"Common","strictUpdates":"disabled","template":"/Common/f5.policy_creator_beta","trafficGroup":"none","lists":[],"variables":[{"name":"variables__deployment","encrypted":"no","value":"'"$deployment"'"},{"name":"variables__type","encrypted":"no","value":"'"$type"'"},{"name":"variables__level","encrypted":"no","value":"'"$level"'"},{"name":"variables__asm_policy","encrypted":"no","value":"'"$asm_policy"'"},{"name":"variables__custom_asm_policy","encrypted":"no","value":"'"$custom_asm_policy"'"}]}' | jq .
fi
if [ $CMD == "DELETE" ]
	then
	echo "Deleting $APPNAME..."
	curl -sku admin:admin -X DELETE -H "Content-Type: application/json" https://localhost/mgmt/tm/sys/application/service/~Common~$APPNAME.app~$APPNAME
fi

