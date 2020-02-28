make-pod () {
	kubectl run $1 --generator=run-pod/v1 --image=${$2:=nginx} --dry-run -oyaml > ${$3:=pod-file}.yaml
}


watch-pods () {
	kubectl get pods -owide --watch
}

# EXPORT ALL FUNCS
export -f make-pod
export -f watch-pods

