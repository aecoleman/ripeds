#' IPEDS fetch
#'
#' Downloads and reads data from the NCES IPEDS for the year provided.
#'
#' @param year integer, the 4 digit year for which data will be downloaded
#'
#' @return list, containing data.frames of the data for the provided year
#' @export
#'
ipeds.fetch <- function(year){

  # Strings that when combined with sprintf and a year will generate an NCES/IPEDS filename
  ipeds.files <- c( 'HD%04d',
                    'IC%04d',
                    'IC%04d_AY',
                    'IC%04d_PY',
                    'EFFY%04d',
                    'EFIA%04d',
                    'C%04d_A')
                    # 'C%04d_B',
                    # 'C%04d_C',
                    # 'C%04dDEP'

  temp <- paste0(tempfile(), '.zip')

  server <- 'https://nces.ed.gov/ipeds/datacenter/data'

  to.download <- sprintf(ipeds.files, year)

  out <- vector(mode = 'list',
                length = length(to.download) )

  for(i in seq(to.download)){

    download.file(url = paste(server,
                              paste0(to.download[i],
                                     '.zip'),
                              sep = '/'),
                  destfile = temp,
                  mode = 'wb')

    out[[i]] <- read.csv( unz(temp,
                              filename = stringr::str_to_lower(paste0(to.download[i], '.csv') ) ),
                          stringsAsFactors = FALSE )

    names(out)[i] <- to.download[i]

  }

  out

}

