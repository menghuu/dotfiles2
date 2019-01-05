if exists('g:loadded_config_leaderf_m')
    finish
endif
let g:loadded_config_leaderf_m = 1

let g:Lf_WildIgnore = {
	\ 'dir': ['.svn','.git','.hg'],
	\ 'file': ['*.sw?','~$*','*.exe','*.o','*.so','*.py[co]']
	\}
