#Name:Guanqi Lu
#EMAIL:glu24@wisc.edu
rm(list=ls())
require("astro")
cB58<-read.fitstab("cB58_Lyman_break.fit")
wavelength = 10^cB58[,1]
flux<-cB58[,2]
plot(x=wavelength,y=flux,type = "l")
#spectrum(x=wavelength,y=cB58[,2])
head(cB58)
files=list.files("data")
for (i in 1:length(files)){
  file=paste0("data/",files[i])
  noisy=read.fitstab(file)
}

#distance method
cB58_flux = scale(cB58[,2])#Scale the flux of cB58
shortest_dislist = rep(0,100)
shortest_loc = rep(0,100)
for (i in 1:length(files)) { 
  file=paste0("data/",files[i])
  noisy=read.fitstab(file)
  spec_flux = scale(noisy[,1])  # scale spectrum flux
  spec_len = length(spec_flux)
  cB58_len = length(cB58_flux)
  shortest = Inf
  #if (spec_len >= cB58_len) {
    for (j in 1:(spec_len+1-cB58_len)) { 
      spec_part = spec_flux[j:(j+cB58_len-1)]#shift to find the pefect location
      distance = sqrt(sum((spec_part - cB58_flux)^2))
      if (distance < shortest) {
        shortest = distance
        location = j  
      }
   # }
  }
  shortest_dislist[i] = shortest
  shortest_loc[i] = location
}
#
sorted <-files[order(shortest_dislist)]
sorted[c(1,2,3)]#the top three we choose
# first =shortest_loc[which(files == "spec-5324-55947-0886.fits")]
# second = shortest_loc[which(files == "spec-5328-55982-0218.fits")]
# third = shortest_loc[which(files == "spec-6064-56097-0818.fits")]
# file1<-read.fitstab("data/spec-5324-55947-0886.fits")
# file2<-read.fitstab("data/spec-5328-55982-0218.fits")
# file3<-read.fitstab("data/spec-6064-56097-0818.fits")
# plot(10^file1[,2], (file1[,1] - mean(file1[,1] ))/sd(file1[,1] ), type = "l", xlab = "wavelength", ylab = "flux")
# lines(10^file1[,2][first]:(10^file1[,2][first]+cB58_len-1), cB58_flux, type = "l", col = "red")
# plot(10^file2[,2], (file2[,1] - mean(file2[,1] ))/sd(file2[,1] ), type = "l", xlab = "wavelength", ylab = "flux")
# lines(10^file2[,2][second]:(10^file2[,2][second]+cB58_len-1), cB58_flux, type = "l", col = "red")
# plot(10^file3[,2], (file3[,1] - mean(file3[,1] ))/sd(file3[,1] ), type = "l", xlab = "wavelength", ylab = "flux")
# lines(10^file3[,2][third]:(10^file3[,2][third]+cB58_len-1), cB58_flux, type = "l", col = "red")

distance=shortest_dislist[order(shortest_dislist)]
spectrumID=sorted
i=shortest_loc[order(shortest_dislist)]
data<- data.frame(distance,spectrumID,i)
write.csv(data,file="hw2.csv",row.names = F)


