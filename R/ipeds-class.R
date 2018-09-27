library(data.table)

ipeds.data <- ipeds.fetch(year = 2016)

.ipeds <- setClass(Class = 'ipeds',
                   slots = c('hd' = 'data.frame',
                             'ic' = 'data.frame',
                          'ic_ay' = 'data.frame',
                          'ic_py' = 'data.frame',
                           'effy' = 'data.frame',
                           'efia' = 'data.frame',
                            'c_a' = 'data.frame',
                            'c_b' = 'data.frame',
                            'c_c' = 'data.frame',
                          'c_dep' = 'data.frame') )

ipeds.cl <-
  new('ipeds',
         hd = ipeds.data$HD2016,
         ic = ipeds.data$IC2016,
      ic_ay = ipeds.data$IC2016_AY,
      ic_py = ipeds.data$IC2016_PY,
       effy = ipeds.data$EFFY2016,
       efia = ipeds.data$EFIA2016,
        c_a = ipeds.data$C2016_A,
        c_b = ipeds.data$C2016_B,
        c_c = ipeds.data$C2016_C,
      c_dep = ipeds.data$C2016DEP )

dim(ipeds.cl@hd)

dim(ipeds.cl@ic)

dim(ipeds.cl@effy)

dim(ipeds.cl@efia)

grep('^X', names(ipeds.cl@ic))
grep('^X', names(ipeds.cl@ic_ay))
grep('^X', names(ipeds.cl@ic_py))
grep('^X', names(ipeds.cl@effy))
grep('^X', names(ipeds.cl@efia))

institution <-
  ipeds.cl@hd[,c('UNITID', 'INSTNM', 'IALIAS', 'ADDR', 'CITY', 'STABBR', 'ZIP',
                 'FIPS', 'SECTOR', 'DEGGRANT', 'LOCALE', 'ACT', 'OPENPUBL',
                 'HOSPITAL', 'MEDICAL', 'INSTCAT', 'INSTSIZE', 'CBSA',
                 'CBSATYPE', 'CSA', 'NECTA', 'COUNTYCD', 'LONGITUD', 'LATITUDE')]

institution$ZIP5 <- substr(institution$ZIP, 1, 5)

effy <- data.table(ipeds.cl@effy)

effy[]
