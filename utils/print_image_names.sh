    SOURCES="${1%/}"
	
    LAYERS=$(find "${SOURCES}" -type d -a -iname images|grep recipes-core|sed -e "s/.*${SOURCES}\///g"|cut -d '/' -f1|sort -u -r)

    for FOLDER in ${LAYERS} 
    do
        RECO=""
        printf '%s\n' "From ${FOLDER}${RECO}:"
        F_IMAGE_FOLDERS=$(find "${SOURCES}/${FOLDER}" -type d -a -iname images|grep recipes-core)
        for IMG_FOLDER in ${F_IMAGE_FOLDERS}
        do
            F_IMAGES=$(find "${IMG_FOLDER}" -iname '*.bb')
            if [ -n "${F_IMAGES}" ]; then
                for img in ${F_IMAGES}
                do
                    name=$(basename "${img}"|sed 's/\.bb$//g')
                    summary=$(grep SUMMARY "${img}"|cut -d '=' -f2| sed 's/["/]//g')
                    if [ -z "${summary}" ]; then
                        summary="No Summary available"
                    fi
                    printf '%s\n' "    ${name}: ${summary}"
                done
            fi
        done
    done

