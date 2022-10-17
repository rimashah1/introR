### Part 1 Exercises ###
#1 Function that converts temp (F) to temp (K)

temp_conv <- function(temp_f) {
  temp_c <-  (temp_f - 32) * 5 / 9
  temp_k <-  temp_c + 273.15
  return (temp_k)
}
temp_conv(70)

#2 Round temp_k to 1 digit
round(temp_conv(70), digits=1)
