require(boot);
data_all<-read.table("deltaVinaRF20.out_processed_score",header=TRUE);
aa<-c(1:nrow(data_all));

mycore<-function(x,indices)
{
  data_1<-matrix(NA,285,2);
  for(i in 1:285)
  {
    data_1[i,1]=data_all[x[indices][i],2];
    data_1[i,2]=data_all[x[indices][i],3];
  }
  data_2<-data.frame(data_1);
  names(data_2)<-c("a","b");
  cor(data_2$a,data_2$b);
};

data.boot<-boot(aa,mycore,R=10000,stype="i",sim="ordinary");
sink("deltaVinaRF20.out-ci.results");
a<-boot.ci(data.boot,conf=0.9,type=c("bca"));
print(a);
