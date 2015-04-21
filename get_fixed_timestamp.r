get_fixed_timestamp <- function(x)
{
  if(!is.numeric(x))
    {stop("input must be a valid unix timestamp")}
  
  floor((x-1427808600)/86400)*86400+1427808600

}