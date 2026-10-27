zmodload zsh/parameter

jobs_status_widget() {
	(( ${#jobstates} == 0 )) && return
	local j st rest cur pgid dir
	local -a lines
	for j in ${(kn)jobstates}; do
		st=${jobstates[$j]}
		rest=${st#*:}
		cur=${rest%%:*}
		pgid=${${rest#*:}%%=*}
		dir=${${jobdirs[$j]:-$PWD}/#$HOME/\~}
		lines+=("[${j}] ${cur:- } ${pgid}  ${st%%:*}  ${dir}  ${jobtexts[$j]}")
	done
	zle -M "${(F)lines}"
}

jobz_widget() {
	setopt localoptions nonotify
	(( ${#jobstates} == 0 )) && { zle -M "No active jobs"; return 0; }
	local j st rest cur pgid dir
	local -a rows
	for j in ${(kn)jobstates}; do
		st=${jobstates[$j]}
		rest=${st#*:}
		cur=${rest%%:*}
		pgid=${${rest#*:}%%=*}
		dir=${${jobdirs[$j]:-$PWD}/#$HOME/\~}
		rows+=("${j}"$'\t'"${cur:--}"$'\t'"${pgid}"$'\t'"${dir}"$'\t'"${jobtexts[$j]}")
	done
	local out=$(JOBZ_DATA="${(F)rows}" jobz)
	local -a reply=("${(@f)out}")
	local key=${reply[1]} job_id=${${(z)reply[2]}[1]}
	if [[ -n $job_id ]]; then
		zle -I
		[[ $key == "ctrl-b" ]] && bg "%${job_id}" || fg "%${job_id}"
	fi
	zle reset-prompt
	jobs_status_widget
}

zle -N zle-line-init jobs_status_widget
zle -N jobz_widget
