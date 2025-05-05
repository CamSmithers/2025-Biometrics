library(tidyverse)
eating <- read_csv(
    "/Users/camsmithers/Documents/CalTracker.csv",
    col_names = FALSE)
eating_names <- c("meal", "description", "calories", "cheat", 
                  "day", "year_time")
names(eating) <- eating_names

eating <- eating %>%
    mutate(
        year_time = str_replace_all(year_time, "\\s*[\u202F\u00A0]+\\s*", " "),
        year_time = str_trim(year_time)) %>%
    separate(year_time, into = c("year", "time"), sep = " at ") %>%
    mutate(
        time = parse_time(time, format = "%I:%M %p"),
        time = format(time, "%H:%M"))

daily_summary <- eating %>%
    group_by(day) %>%
    summarise(daily_calories = sum(calories))