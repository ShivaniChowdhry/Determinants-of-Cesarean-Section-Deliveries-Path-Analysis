set seed 2038947
sort urban
by urban: sample 20
count
mdesc #to see missing data frequency for each variable#
replace inshh = . if inshh==7
tab delcesr
replace delcesr = . if delcesr==9
tab delpl
replace delpl = . if  delpl==9
tab ancare
replace ancare = . if ancare==9
replace ancare = . if ancare==8
tab ancaresupnutr
replace ancaresupnutr = . if ancaresupnutr==9
replace ancaresupnutr = . if ancaresupnutr==8
tab ancaredelloc
replace ancaredelloc = . if ancaredelloc==9
tab ancareiron
replace ancareiron = . if ancareiron==9 | ancareiron==7 | ancareiron==8
mdesc


gen wgt=perweight/1000000
tabulate delpl , generate(delpl)
drop if delpl == 1
drop if delpl == 4
tabulate delpl

gsem (ancare -> delpl, family(bernoulli) link(logit)) (ancare -> delcesr, family(bernoulli) link(logit)) (ancaresupnutr -> delpl, family(bernoulli) link(logit)) (ancaresupnutr -> delcesr, family(bernoulli) link(logit)) (ancareiron -> delpl, family(bernoulli) link(logit)) (ancareiron -> delcesr, family(bernoulli) link(logit)) (ancaredelloc -> delpl, family(bernoulli) link(logit)) (ancaredelloc -> delcesr, family(bernoulli) link(logit)) (urban -> delpl, family(bernoulli) link(logit)) (urban -> delcesr, family(bernoulli) link(logit)) (wealthq -> delpl, family(bernoulli) link(logit)) (wealthq -> delcesr, family(bernoulli) link(logit)) (hheligwomen -> delpl, family(bernoulli) link(logit)) (hheligwomen -> delcesr, family(bernoulli) link(logit)) (inshh -> delpl, family(bernoulli) link(logit)) (inshh -> delcesr, family(bernoulli) link(logit)) (hheadsex -> delpl, family(bernoulli) link(logit)) (hheadsex -> delcesr, family(bernoulli) link(logit)) (delpl -> delcesr, family(bernoulli) link(logit)) [pweight = wgt], iterate(10) nocapslatent
estat ic
