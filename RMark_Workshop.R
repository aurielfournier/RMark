#R Mark Workshop Notes

library(RMark)
data(dipper)
myfirstmodel=mark(dipper)
dat <- import.chdata('live_dead_enhist.txt')
dat.proc=process.data(dat,model="Burnham",groups=c("sex","age"),begin.time=2005)
dat.ddl=make.design.data(dat.proc)

S.dot=list(formula=~1)
p.dot=list(formula=~1)
r.dot=list(formula=~1)

S.sex.age.time=list(formula=~age+sex+tile)
S.sex.age=list(formula=~age+sex)
S.sex.time=list(formula=~sex+time)
S.age.time=list(formula=~age+time)
S.age=list(formula=~age)
S.sex=list(formula=~sex)
S.time=list(formula=~time)

p.sex.age=list(formula=~age+sex)
p.sex.time=list(formula=~sex+tile)
p.age.time=list(formula=~age+tile)
p.age=list(formula=~age)
p.sex=list(formula=~sex)
p.time=list(formula=~tile)

r.sex.age=list(formula=~age+sex)
r.sex.time=list(formula=~sex+tile)
r.age.time=list(formula=~age+tile)
r.age=list(formula=~age)
r.sex=list(formula=~sex)
r.time=list(formula=~tile)


model.1=mark(dat.proc, dat.ddl)
model.2=mark(dat.proc, dat.ddl, model.parameters=list(S=S.sex))
model.3=mark(dat.proc, dat.ddl, model.parameters=list(S=S.time))
model.4=mark(dat.proc, dat.ddl, model.parameters=list(S=S.age))
model.5=mark(dat.proc, dat.ddl, model.parameters=list(S=S.sex.time))
model.6=mark(dat.proc, dat.ddl, model.parameters=list(S=S.age.time))
#model.7=mark(dat.proc, dat.ddl, model.parameters=list(S=S.sex.age.time))

cml=create.model.list(model="Burnham")
model.list=mark.wrapper(cml,data=dat.proc,ddl=dat.ddl)
model.list
