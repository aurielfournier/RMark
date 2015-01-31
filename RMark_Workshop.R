#R Mark Workshop Notes

library(RMark)

dat <- import.chdata('live_dead_enhist.txt')
dat.proc=process.data(dat,model="Burnham",groups=c("sex","age"),begin.time=2005)
dat.ddl=make.design.data(dat.proc)

S.dot=list(formula=~1)
p.dot=list(formula=~1)
r.dot=list(formula=~1)
F.dot=list(formula=~1)
S.sex.age.time=list(formula=~age+sex+time)
S.sex.age=list(formula=~age+sex)
S.sex.time=list(formula=~sex+time)
S.age.time=list(formula=~age+time)
S.age=list(formula=~age)
S.sex=list(formula=~sex)
S.time=list(formula=~time)
p.time=list(formula=~time)
F.age = list(formula=~age)


# model.1=mark(dat.proc, dat.ddl)
# model.2=mark(dat.proc, dat.ddl, model.parameters=list(S=S.sex, p=p.time))
# model.3=mark(dat.proc, dat.ddl, model.parameters=list(S=S.time,p=p.time))
# model.4=mark(dat.proc, dat.ddl, model.parameters=list(S=S.age, p=p.time))
# model.5=mark(dat.proc, dat.ddl, model.parameters=list(S=S.sex.time, p=p.time))
# model.6=mark(dat.proc, dat.ddl, model.parameters=list(S=S.age.time, p=p.time))
#model.7=mark(dat.proc, dat.ddl, model.parameters=list(S=S.sex.age.time))

cml=create.model.list(model="Burnham")
model.list=mark.wrapper(cml,data=dat.proc,ddl=dat.ddl)
model.list
