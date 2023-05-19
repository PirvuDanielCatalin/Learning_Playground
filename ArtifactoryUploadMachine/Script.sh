#!/usr/bin/env bash
set -e

echo ""

read -p "Artifactory repository (default: ips-thirdparty) " repository
repository="${repository:-ips-thirdparty}"
echo ""

read -p "Group of the new artefact? (default: org.centos.rpm.x64.el7) " groupId
groupId="${groupId:-org.centos.rpm.x64.el7}"
echo ""

read -p "Directory name of the new artefact? " artifactId
echo ""

read -p "Version of the new artefact? " version
echo ""

read -p "Classifier of the new artefact? (default: el7.x86_64) " classifier
classifier="${classifier:-el7.x86_64}"
echo ""

read -p "Packaging of the new artefact? (default: rpm) " packaging
packaging="${packaging:-rpm}"
echo ""

read -p "File name of the new artefact? " file
echo ""

if [[ ! -z "$repository" ]] && \
    [[ ! -z $groupId ]] && \
    [[ ! -z $artifactId ]] && \
    [[ ! -z $version ]] && \
    [[ ! -z $classifier ]] && \
    [[ ! -z $packaging ]] && \
    [[ ! -z $file ]]; then
    mvn deploy:deploy-file \
        -DgitVersioning=false \
        -DrepositoryId=ips-group \
        -DgeneratePom=true \
        -DgroupId=${groupId} \
        -DartifactId=${artifactId} \
        -Dversion=${version} \
        -Dclassifier=${classifier} \
        -Dpackaging=${packaging} \
        -Dfile=${file} \
        -Durl=https://repo-api.mcvl-engineering.com/repository/${repository}

    echo "The artefact was uploaded successfully ^_^"
    echo "It can be downloaded from: "
    echo "=> https://ie-repo.vocalink.co.uk/ui/native/${repository}/${groupId//[.]/\/}/${artifactId}/${version}/ <="
    echo ""
else
    echo "Some parameters were not initiated -_-"
    echo "Please review them and run the script again"
    echo ""
fi
