# Load Required Libraries
library(tidyverse)
library(readxl)
library(ggplot2)
library(scales)
library(dplyr)
library(ggcorrplot)
library(factoextra)


# Set File Path
file_path <- "C:/Users/kevin/OneDrive/Desktop/Data Analysis Projects/data sets/NBA 2023 Playoff Data Analysis.xlsx"

# Read the Excel file
playoff_totals <- read_excel(file_path, sheet = "Playoff Totals")

# Rename Columns for Simplicity (no spaces or %)
playoff_totals <- playoff_totals %>%
  rename(
    Games_Played = `Games Played`,
    FG_pct = `FG%`,
    ThreeP_pct = `3P%`,
    TwoP_pct = `2P%`,
    eFG_pct = `eFG%`,
    FT_pct = `FT%`
  )

# View the first few rows
head(playoff_totals)

# Check Data Structure
str(playoff_totals)

# Check Missing Values
colSums(is.na(playoff_totals))

# Fill Missing Shooting % with 0
playoff_totals <- playoff_totals %>%
  mutate(
    FG_pct = replace_na(FG_pct, 0),
    ThreeP_pct = replace_na(ThreeP_pct, 0),
    TwoP_pct = replace_na(TwoP_pct, 0),
    eFG_pct = replace_na(eFG_pct, 0),
    FT_pct = replace_na(FT_pct, 0)
  )

# Filter Players with at Least 8 Games Played
playoff_totals <- playoff_totals %>%
  filter(Games_Played >= 8)

# Compute Summary Statistics for Key Metrics
summary_stats <- playoff_totals %>%
  summarise(
    Mean_PTS = mean(PTS, na.rm = TRUE),
    Median_PTS = median(PTS, na.rm = TRUE),
    SD_PTS = sd(PTS, na.rm = TRUE),
    Mean_AST = mean(AST, na.rm = TRUE),
    Mean_TRB = mean(TRB, na.rm = TRUE),
    Mean_ORB = mean(ORB, na.rm = TRUE),
    Mean_DRB = mean(DRB, na.rm = TRUE)
  )

# Print Summary Statistics
print(summary_stats)

# Compute Correlation Matrix (Key Metrics)
cor_matrix <- playoff_totals %>%
  select(PTS, AST, ORB, DRB, STL, BLK) %>%
  cor(use = "pairwise.complete.obs")

# Print Correlation Matrix
print(cor_matrix)

# Generate Correlation Heatmap
ggcorrplot(cor_matrix, 
           method = "square",
           type = "full",
           lab = TRUE,
           lab_size = 5,
           colors = c("blue", "white", "red"),
           title = "🏀 Correlation Heatmap: Key Playoff Metrics",
           ggtheme = theme_minimal()) +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 16))

# Compute Weighted Score for Total Performance
playoff_totals <- playoff_totals %>%
  mutate(
    Weighted_Score = 
      (PTS * 0.20) +  
      (AST * 0.20) +
      (STL * 0.20) +
      (BLK * 0.20) +
      (TRB * 0.20)
  )

# 🎯 Shooting Breakdown for Top Scorers
top_scorers_shooting <- playoff_totals %>%
  arrange(desc(PTS)) %>%
  select(Player, Team, Games_Played, PTS, `2P`, `3P`, FT, TOV) %>%
  mutate(
    TwoPT_Points = (PTS - (`3P` * 3) - FT),
    ThreePT_Points = `3P` * 3,
    FT_Points = FT,
    TOV = -TOV
  ) %>%
  head(10)

# Convert to Long Format for Visualization
top_scorers_long <- top_scorers_shooting %>%
  pivot_longer(cols = c(TwoPT_Points, ThreePT_Points, FT_Points, TOV),
               names_to = "Stat_Type", values_to = "Points")

# Generate Stacked Bar Chart
ggplot(top_scorers_long, aes(x = reorder(Player, -PTS), y = Points, fill = Stat_Type)) +
  geom_bar(stat = "identity", color = "black", width = 0.8) +  
  geom_text(aes(label = round(Points, 1)), position = position_stack(vjust = 0.5), 
            size = 5, fontface = "bold", color = "white") +  
  scale_fill_manual(values = c("TwoPT_Points" = "blue", "ThreePT_Points" = "green", "FT_Points" = "orange", "TOV" = "red")) +
  theme_minimal() +
  labs(title = "🏀 Shooting Breakdown of Top 10 Scorers (Including Turnovers)",
       x = "Player", y = "Total Points & Turnovers", fill = "Stat Type") +
  theme(axis.text.x = element_text(angle = 30, hjust = 1, face = "bold"),
        plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
        legend.title = element_text(face = "bold"),
        legend.text = element_text(size = 12))

# 🎯 Top 10 Assist Leaders (AST vs TOV)
top_assist_leaders <- playoff_totals %>%
  arrange(desc(AST)) %>%
  select(Player, Team, AST, TOV) %>%
  head(10)

top_assist_long <- top_assist_leaders %>%
  pivot_longer(cols = c(AST, TOV), names_to = "Metric", values_to = "Value")

top_assist_long$Player <- factor(top_assist_long$Player, levels = top_assist_leaders$Player)

assist_colors <- c("AST" = "#FFD700", "TOV" = "red")

ggplot(top_assist_long, aes(x = Player, y = Value, fill = Metric)) +
  geom_bar(stat = "identity", color = "black", width = 0.75) +  
  geom_text(aes(label = round(Value, 1)), 
            position = position_stack(vjust = 0.5),
            size = 6, fontface = "bold", color = "white") +
  scale_fill_manual(values = assist_colors) +
  theme_minimal() +
  labs(title = "🏀 Top 10 Assist Leaders (AST vs TOV)",
       subtitle = "Assists in Gold, Turnovers in Red",
       x = "Player", y = "Total Assists & Turnovers", fill = "Metric") +
  theme(axis.text.x = element_text(angle = 30, hjust = 1, face = "bold", size = 12),
        axis.title.y = element_text(size = 14, face = "bold"),
        plot.title = element_text(size = 16, face = "bold"))

# 🎯 Top 10 Steals Leaders (STL vs PF)
top_steals <- playoff_totals %>%
  arrange(desc(STL)) %>%
  select(Player, Team, STL, PF) %>%
  head(10)

top_steals_long <- top_steals %>%
  pivot_longer(cols = c(STL, PF), names_to = "Metric", values_to = "Value")

top_steals_long$Player <- factor(top_steals_long$Player, levels = top_steals$Player)
top_steals_long$Metric <- factor(top_steals_long$Metric, levels = c("PF", "STL"))

steal_colors <- c("STL" = "red", "PF" = "#595959")

ggplot(top_steals_long, aes(x = Player, y = Value, fill = Metric)) +
  geom_bar(stat = "identity", color = "black", width = 0.7) +
  geom_text(aes(label = round(Value, 1)), position = position_stack(vjust = 0.5),
            size = 6, fontface = "bold", color = "white") +
  scale_fill_manual(values = steal_colors) +
  theme_minimal() +
  labs(title = "🏀 Top 10 Steals Leaders (STL vs Fouls)",
       subtitle = "Steals (Red) vs Personal Fouls (Dark Gray)",
       x = "Player", y = "Total STL & PF", fill = "Metric") +
  theme(axis.text.x = element_text(angle = 30, hjust = 1, face = "bold", size = 12),
        axis.title.y = element_text(size = 14, face = "bold"),
        plot.title = element_text(size = 16, face = "bold"))

# 🎯 Top 10 Block Leaders (BLK vs PF)
top_blocks <- playoff_totals %>%
  arrange(desc(BLK)) %>%
  select(Player, Team, BLK, PF) %>%
  head(10)

top_blocks_long <- top_blocks %>%
  pivot_longer(cols = c(BLK, PF), names_to = "Metric", values_to = "Value")

top_blocks_long$Player <- factor(top_blocks_long$Player, levels = top_blocks$Player)
top_blocks_long$Metric <- factor(top_blocks_long$Metric, levels = c("PF", "BLK"))

block_colors <- c("BLK" = "black", "PF" = "#595959")

ggplot(top_blocks_long, aes(x = Player, y = Value, fill = Metric)) +
  geom_bar(stat = "identity", color = "black", width = 0.7) +
  geom_text(aes(label = round(Value, 1)), position = position_stack(vjust = 0.5),
            size = 6, fontface = "bold", color = "white") +
  scale_fill_manual(values = block_colors) +
  theme_minimal() +
  labs(title = "🏀 Top 10 Block Leaders (BLK vs Fouls)",
       subtitle = "Blocks (Black) vs Personal Fouls (Dark Gray)",
       x = "Player", y = "Total BLK & PF", fill = "Metric") +
  theme(axis.text.x = element_text(angle = 30, hjust = 1, face = "bold", size = 12),
        axis.title.y = element_text(size = 14, face = "bold"),
        plot.title = element_text(size = 16, face = "bold"))

# 🎯 Top 10 Rebounders (ORB vs DRB)
top_rebounders <- playoff_totals %>%
  arrange(desc(TRB)) %>%
  select(Player, Team, TRB, ORB, DRB) %>%
  head(10)

top_rebounders_long <- top_rebounders %>%
  pivot_longer(cols = c(ORB, DRB),
               names_to = "Rebound_Type", values_to = "Value")

top_rebounders_long$Player <- factor(top_rebounders_long$Player, levels = top_rebounders$Player)

rebound_colors <- c("DRB" = "red", "ORB" = "blue")

ggplot(top_rebounders_long, aes(x = Player, y = Value, fill = Rebound_Type)) +
  geom_bar(stat = "identity", color = "black", width = 0.75) +  
  geom_text(aes(label = round(Value, 1)), 
            position = position_stack(vjust = 0.5),
            size = 6, fontface = "bold", color = "white") +
  scale_fill_manual(values = rebound_colors) +
  theme_minimal() +
  labs(title = "🏀 Top 10 Rebounders (Defensive & Offensive Breakdown)",
       subtitle = "Defensive (Red) & Offensive (Blue) Rebounds",
       x = "Player", y = "Total Rebounds", fill = "Rebound Type") +
  theme(axis.text.x = element_text(angle = 30, hjust = 1, face = "bold", size = 12),
        axis.title.y = element_text(size = 14, face = "bold"),
        plot.title = element_text(size = 16, face = "bold"))

# 🎯 Top 10 Overall Players (Weighted Score)
top_overall_players <- playoff_totals %>%
  arrange(desc(Weighted_Score)) %>%
  select(Player, Team, PTS, AST, STL, BLK, TRB, Weighted_Score) %>%
  head(10)

# ✅ MISSING STEP: Pivot for visualization
top_overall_long <- top_overall_players %>%
  pivot_longer(cols = c(PTS, AST, STL, BLK, TRB),
               names_to = "Metric", values_to = "Value")

# Maintain player order
top_overall_long$Player <- factor(top_overall_long$Player, levels = top_overall_players$Player)

# Colors for bar segments
metric_colors <- c("AST" = "#FFD700", "STL" = "red", "PTS" = "green", "BLK" = "black", "TRB" = "purple")

# Plot
ggplot(top_overall_long, aes(x = Player, y = Value, fill = Metric)) +
  geom_bar(stat = "identity", color = "black", width = 0.75) +
  geom_text(aes(label = round(Value, 1)), 
            position = position_stack(vjust = 0.5),
            size = 6, fontface = "bold", 
            color = ifelse(top_overall_long$Metric == "AST", "black", "white")) +
  scale_fill_manual(values = metric_colors) +
  theme_minimal() +
  labs(title = "🏀 Top 10 Overall Players (Final Weighted Score Breakdown)",
       subtitle = "Scores are weighted equally for a balanced ranking",
       x = "Player", y = "Total Contribution", fill = "Metric") +
  theme(axis.text.x = element_text(angle = 30, hjust = 1, face = "bold", size = 12),
        axis.title.y = element_text(size = 14, face = "bold"),
        plot.title = element_text(size = 16, face = "bold"))




# Select Performance and Efficiency Metrics
pca_features <- playoff_totals %>%
  select(PTS, AST, TRB, STL, BLK, FG_pct, ThreeP_pct, FT_pct, TOV)

# Standardize the Data
nba_scaled <- scale(pca_features)

# Perform PCA
nba_pca <- prcomp(nba_scaled, center = TRUE, scale. = TRUE)

# Add PCA Scores to Original Data
pca_scores <- as.data.frame(nba_pca$x)
playoff_totals_pca <- cbind(playoff_totals, pca_scores)

# 🔍 Elbow Method to Determine Optimal Clusters
set.seed(123)
wss <- sapply(1:10, function(k) {
  kmeans(nba_scaled, centers = k, nstart = 25)$tot.withinss
})

elbow_data <- data.frame(Clusters = 1:10, WSS = wss)

# Elbow Plot
ggplot(elbow_data, aes(x = Clusters, y = WSS)) +
  geom_point(color = "red", size = 3) +
  geom_line(color = "red", size = 1) +
  geom_vline(xintercept = 3, linetype = "dashed", color = "blue", size = 1) +  # K = 3 Highlighted
  labs(title = "Elbow Method: Optimal Clusters = 3",
       x = "Number of Clusters (K)",
       y = "Within-Cluster Sum of Squares (WSS)") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5))

# 🧩 KMeans Clustering (K = 3)
set.seed(123)
kmeans_result <- kmeans(pca_scores[, 1:2], centers = 3, nstart = 25)
playoff_totals_pca$Cluster <- factor(kmeans_result$cluster)

# Determine Cluster Centers and Assign Labels Based on Weighted Score
cluster_centers <- playoff_totals_pca %>%
  group_by(Cluster) %>%
  summarise(Average_Score = mean(Weighted_Score)) %>%
  arrange(desc(Average_Score))

# Assign Cluster Labels: Superstar → Starter → Role Player
cluster_centers$True_Label <- c("Superstar", "Starter", "Role Player")
label_map <- setNames(cluster_centers$True_Label, cluster_centers$Cluster)
playoff_totals_pca$Cluster_Label <- label_map[as.character(playoff_totals_pca$Cluster)]

# Correct Color Mapping
playoff_totals_pca$Cluster_Label <- factor(playoff_totals_pca$Cluster_Label,
                                           levels = c("Superstar", "Starter", "Role Player"))
correct_colors <- c("Superstar" = "purple", "Starter" = "red", "Role Player" = "blue")

# Final PCA Cluster Visualization
ggplot(playoff_totals_pca, aes(x = PC1, y = PC2, color = Cluster_Label, label = Player)) +
  geom_point(size = 3) +
  scale_color_manual(values = correct_colors) +
  geom_text_repel(size = 3, fontface = "bold", max.overlaps = 25, force = 0.75) +
  labs(title = "🏀 PCA Clustering of NBA Players by Role",
       subtitle = "Purple: Superstars, Red: Starters, Blue: Role Players",
       x = "Principal Component 1",
       y = "Principal Component 2",
       color = "Cluster") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
        plot.subtitle = element_text(size = 12, face = "bold", hjust = 0.5),
        legend.title = element_text(face = "bold"))


