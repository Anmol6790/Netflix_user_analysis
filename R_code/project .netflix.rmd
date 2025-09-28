# ================================================================
# Netflix Churn Analysis with Boxplots
# ================================================================

# ----------------------------------------------------------------
# 1. Load Required Libraries
# ----------------------------------------------------------------
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}
library(tidyverse)

# ----------------------------------------------------------------
# 2. Load Datasets
# ----------------------------------------------------------------
# Make sure the CSV files are placed in your working directory
netflix_titles <- read.csv("C:/Users/anmol/OneDrive/Desktop/New folder (2)/netflix_titles (1).csv")
user_activity  <- read.csv("C:/Users/anmol/OneDrive/Desktop/New folder (2)/user_activity_dataset.csv")

# ----------------------------------------------------------------
# 3. Content Data Cleaning
# ----------------------------------------------------------------
titles_clean <- netflix_titles %>%
  select(-starts_with("Unnamed")) %>%                # Drop redundant columns
  separate_rows(listed_in, sep = ", ") %>%           # Split multiple genres
  rename(genre = listed_in) %>%
  select(show_id, type, genre)

# ----------------------------------------------------------------
# 4. Merge Activity with Titles Data
# ----------------------------------------------------------------
merged_data <- user_activity %>%
  mutate(
    watch_date = as.Date(watch_date)   # convert to Date format
  ) %>%
  rename(
    watch_time   = watch_time_minutes,
    device       = device_type,
    churn_status = subscription_status
  ) %>%
  left_join(titles_clean, by = "show_id")


# ----------------------------------------------------------------
# 5. Feature Engineering
# ----------------------------------------------------------------

# 5a. Churn Target (last status for each user)
churn_target <- merged_data %>%
  group_by(user_id) %>%
  arrange(watch_date) %>%
  slice_tail(n = 1) %>%
  select(user_id, churn_status) %>%
  mutate(churn = ifelse(churn_status == "Churned", 1, 0)) %>%
  select(-churn_status)

# 5b. User-Level Features
user_features <- merged_data %>%
  group_by(user_id) %>%
  summarise(
    total_watch_time    = sum(watch_time, na.rm = TRUE),
    total_activities    = n(),
    avg_watch_time      = mean(watch_time, na.rm = TRUE),
    unique_shows_watched = n_distinct(show_id),
    unique_genres        = n_distinct(genre),
    most_freq_device     = names(which.max(table(device))),
    most_freq_country    = names(which.max(table(country))),
    most_freq_type       = names(which.max(table(type))),
    .groups = "drop"
  )

# 5c. Final Modeling Dataset
model_df <- user_features %>%
  left_join(churn_target, by = "user_id") %>%
  mutate(
    most_freq_device  = as.factor(most_freq_device),
    most_freq_country = as.factor(most_freq_country),
    most_freq_type    = as.factor(most_freq_type),
    churn             = as.factor(churn)
  ) %>%
  drop_na(churn)

# ----------------------------------------------------------------
# 6. Dataset Summary
# ----------------------------------------------------------------
cat("\n--- Final Dataset Structure ---\n")
str(model_df)

cat("\n--- Churn Distribution ---\n")
print(table(model_df$churn))

# ----------------------------------------------------------------
# 7. Boxplot Analysis
# ----------------------------------------------------------------

# Boxplot: Total Watch Time vs Churn
ggplot(model_df, aes(x = churn, y = total_watch_time, fill = churn)) +
  geom_boxplot() +
  labs(
    title = "Total Watch Time vs Churn",
    x = "Churn Status (0 = Active, 1 = Churned)",
    y = "Total Watch Time"
  ) +
  theme_minimal()

# Boxplot: Average Watch Time vs Churn
ggplot(model_df, aes(x = churn, y = avg_watch_time, fill = churn)) +
  geom_boxplot() +
  labs(
    title = "Average Watch Time vs Churn",
    x = "Churn Status",
    y = "Average Watch Time"
  ) +
  theme_minimal()

# Boxplot: Unique Shows Watched vs Churn
ggplot(model_df, aes(x = churn, y = unique_shows_watched, fill = churn)) +
  geom_boxplot() +
  labs(
    title = "Unique Shows Watched vs Churn",
    x = "Churn Status",
    y = "Number of Unique Shows"
  ) +
  theme_minimal()

# Boxplot: Unique Genres Watched vs Churn
ggplot(model_df, aes(x = churn, y = unique_genres, fill = churn)) +
  geom_boxplot() +
  labs(
    title = "Unique Genres Watched vs Churn",
    x = "Churn Status",
    y = "Number of Unique Genres"
  ) +
  theme_minimal()

# ================================================================
# End of Script
# ================================================================

