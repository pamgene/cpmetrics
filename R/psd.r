psd = function(value, grp){
  vpg = data.frame(value, grp) %>% group_by(grp) %>% dplyr::summarise(gvar = var(value), gn = length(value))

  vpg = vpg %>% mutate(wvar = (gn-1)* gvar)

  psd = sqrt( sum(vpg$wvar) /(sum(vpg$gn) - length(vpg$gn)) )
}
