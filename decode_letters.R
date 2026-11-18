base_url <- "https://byuistats.github.io/M335/data/"
read_text <- function(file) {
  paste(readr::read_lines(paste0(base_url, file)), collapse = "")
}
text <- read_text("randomletters.txt")
numbered <- read_text("randomletters_wnumbers.txt")

# Keep position 1, then each multiple of 1700. Stop at the first period.
positions <- c(1L, seq(1700L, nchar(text), by = 1700L))
sampled <- paste(substring(text, positions, positions), collapse = "")
quote_text <- sub("\\..*$", ".", sampled)

# Match whole numbers so, for example, 24 becomes x rather than bd.
numbers <- regmatches(numbered, gregexpr("[0-9]+", numbered))[[1]]
message_text <- paste(letters[as.integer(numbers)], collapse = "")

# Removing spaces and periods first lets vowel runs span those characters.
clean <- gsub("[ .]", "", text)
runs <- regmatches(clean, gregexpr("[aeiou]+", clean))[[1]]
longest <- runs[which.max(nchar(runs))]

cat("Quote:", quote_text, "\n")
cat("Message:", message_text, "\n")
cat("Longest vowel sequence:", longest, "(length", nchar(longest), ")\n")
