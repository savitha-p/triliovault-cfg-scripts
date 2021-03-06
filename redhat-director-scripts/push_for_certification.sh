#!/bin/bash -x

set -e

if [ $# -lt 1 ];then
   echo "Script takes exactly 1 argument"
   echo -e "./push_containers_redhat_registry.sh <CONTAINER_TAG>"
   echo -e "Example:"
   echo -e "		./push_containers_redhat_registry.sh 4.0.40-rhosp16"
   exit 1
fi



tag=$1



## trilio dockerhub registry login
docker login -u triliodocker -p triliopassword docker.io


docker pull docker.io/trilio/trilio-datamover-api:$tag
docker pull docker.io/trilio/trilio-datamover:$tag
docker pull docker.io/trilio/trilio-horizon-plugin:$tag


# Datamover container
docker login -u unused \
-p "eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJvc3BpZC03MjA1YjlkMy0wOTQxLTRiYWMtOTY4Mi00ZTIzZTIyNzE1OWQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlY3JldC5uYW1lIjoib3NwaWQtNzIwNWI5ZDMtMDk0MS00YmFjLTk2ODItNGUyM2UyMjcxNTlkLXNhLXRva2VuLXRneGJnIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6Im9zcGlkLTcyMDViOWQzLTA5NDEtNGJhYy05NjgyLTRlMjNlMjI3MTU5ZC1zYSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImZlNDkyMjRlLTYzNWMtMTFlYS04YTRjLTBhODk4ODEyYzkzMSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpvc3BpZC03MjA1YjlkMy0wOTQxLTRiYWMtOTY4Mi00ZTIzZTIyNzE1OWQ6b3NwaWQtNzIwNWI5ZDMtMDk0MS00YmFjLTk2ODItNGUyM2UyMjcxNTlkLXNhIn0.KXu_wdIKkSgVsQp1Ckyc96_1AMTyb4XhyoO6cjRMUzlOpcmspu-3Oj2w-YQQc-Azc3BmKZ9m362aSSSyPTeSXz4ebTsnYlklgqgyhLMNjugyGV7gZZFsto6-bUVUbYrkemeH7eW1z7gKONogxVUu1dBTUBP3jCOPqksUtOuR5NNluK9bFJq89nN0G5x67PspKwjQLO_ntQbQhKbYJXSdyZx0Egw0lc7nM_ITuizxd8K-zb4z4kTT9_Wor93FDmXmuZxfS_TubGQushogEBF6tvGtzff4vINA32YGTeq3BWILbJjvF1DLYoHf3Z2vwEnc1gkcjDf_wv6gPbSiiVmIgw" \
scan.connect.redhat.com
docker tag  docker.io/trilio/trilio-datamover:$tag scan.connect.redhat.com/ospid-7205b9d3-0941-4bac-9682-4e23e227159d/trilio-datamover:$tag
docker push scan.connect.redhat.com/ospid-7205b9d3-0941-4bac-9682-4e23e227159d/trilio-datamover:$tag


# Datamover api container
docker login -u unused \
-p "eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJvc3BpZC0zY2Q1NzFjMy0xOTdiLTRiNjQtYjhiMC1iOGQ5M2VjMzlkYzkiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlY3JldC5uYW1lIjoib3NwaWQtM2NkNTcxYzMtMTk3Yi00YjY0LWI4YjAtYjhkOTNlYzM5ZGM5LXNhLXRva2VuLWh6bXpqIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6Im9zcGlkLTNjZDU3MWMzLTE5N2ItNGI2NC1iOGIwLWI4ZDkzZWMzOWRjOS1zYSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjQwZDY5NDNmLTYzNWQtMTFlYS05ZjU4LTBhZTAyNjY4NDgyOSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpvc3BpZC0zY2Q1NzFjMy0xOTdiLTRiNjQtYjhiMC1iOGQ5M2VjMzlkYzk6b3NwaWQtM2NkNTcxYzMtMTk3Yi00YjY0LWI4YjAtYjhkOTNlYzM5ZGM5LXNhIn0.H-0qzIEFaBxrv5yngnq2if0aNeTZ5c1GVJGSG9BSDxvvxguzremhT5wMZQusKNcma7WRCvLRhNTGQRe94JLFvYtSzpk1rFn_VBiTCLqeBt0Af-r1PTafS1TR8lPEHUi-t77XX80qhvdmN1ndRhUxd_Droxiz74SgBlziJaXftgSNbJOA4fo4Ug63Wusz1Kg94tddgB_dUqtrntSuDSJxW8UfE0LNT54IwkMq75u67AyCUCp3qfM_FAFFscEyNZoBHaqFATauMYNQuL0_bTcS8cXjg2nBeFE6I5DFQGH1UsO-iLp-iYc62vYKJ4VVKJTlLlv4twRCAcGtxYP08SdAZQ" \
scan.connect.redhat.com

docker tag docker.io/trilio/trilio-datamover-api:$tag scan.connect.redhat.com/ospid-3cd571c3-197b-4b64-b8b0-b8d93ec39dc9/trilio-datamover-api:$tag
docker push scan.connect.redhat.com/ospid-3cd571c3-197b-4b64-b8b0-b8d93ec39dc9/trilio-datamover-api:$tag


# Horizon plugin container
docker login -u unused \
-p "eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJvc3BpZC0zOTA5ZTIwMy1hODgwLTRlZmEtOTljNC05OWY4NTdmNmQ0NzciLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlY3JldC5uYW1lIjoib3NwaWQtMzkwOWUyMDMtYTg4MC00ZWZhLTk5YzQtOTlmODU3ZjZkNDc3LXNhLXRva2VuLWxuNnBkIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6Im9zcGlkLTM5MDllMjAzLWE4ODAtNGVmYS05OWM0LTk5Zjg1N2Y2ZDQ3Ny1zYSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjlkNTg2YjEyLTYzNWQtMTFlYS05ZjU4LTBhZTAyNjY4NDgyOSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpvc3BpZC0zOTA5ZTIwMy1hODgwLTRlZmEtOTljNC05OWY4NTdmNmQ0Nzc6b3NwaWQtMzkwOWUyMDMtYTg4MC00ZWZhLTk5YzQtOTlmODU3ZjZkNDc3LXNhIn0.3hh2dHZ-MtfQDbrogfmbnQuNoitlMBr0YzUCy8BP6PnY8ssQG2BCVw3G9iT6TC_zl6lUZt7rG4-xryKTOV2BUAbeWH7sY4vu4LJ-jxau3UWNcJSyLnc9EhBV3JjGLgPHdIeC1XrlRPqLQPXOJGizvp6o5tot4dyZcrrMXT3OpPuF_lEwtsIgtj_nJ17a6oBcHAVkx__upzvRoRMhy4EO8zmmslqXnjxjKcQ_KRS53XfLMeOOFf0_9PLjHsXfeKXoDE62_BHUm_loz_uX9MJYtmlE5oRwAVnZ_FnZSjUUjNj1099N8TbiYrB5BeMvSH0nxLBrx3IZjGyeqWDLquOKvg" \
scan.connect.redhat.com
docker tag docker.io/trilio/trilio-horizon-plugin:$tag scan.connect.redhat.com/ospid-3909e203-a880-4efa-99c4-99f857f6d477/trilio-horizon-plugin:$tag
docker push scan.connect.redhat.com/ospid-3909e203-a880-4efa-99c4-99f857f6d477/trilio-horizon-plugin:$tag
