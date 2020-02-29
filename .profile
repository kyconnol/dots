pod-yaml () {
	kubectl get pod $1 -oyaml
}

pod-make () {
	image=$2
	file=$3
	kubectl run $1 --generator=run-pod/v1 --image=${image:="nginx"} --dry-run --restart=Never -oyaml > ${file:="pod-file"}.yaml
}


pod-watch () {
	all=$1
	kubectl get pods ${all:+"-A"} -owide --watch
}

dep-make () {
	image=$2
	file=$3
	kubectl create deployment $1 --image=${image:="nginx"} --dry-run -oyaml > ${file:="dep-file"}.yaml
}

# EXPORT ALL FUNCS
export -f pod-yaml
export -f pod-make
export -f pod-watch
export -f dep-make
