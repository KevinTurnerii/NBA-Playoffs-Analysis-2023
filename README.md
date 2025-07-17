## Table of Contents
- [Project Overview](#nba-2023-playoff-player-performance-analysis)
- [Scoring Trends & Efficiency](#-scoring-trends--efficiency)
- [Assist Efficiency](#-assist-efficiency--playmaking)
- [Defensive Standouts](#️-defensive-standouts)
- [Rebounding Leaders](#-rebounding-leaders)
- [Correlation Analysis](#-correlation-analysis)
- [Weighted Rankings](#-weighted-score-rankings)
- [Top 10 Players](#-top-10-overall-performers-detailed-breakdown)
- [PCA & Clustering](#-pca--clustering-unsupervised-learning)
- [Power BI Dashboard](#-power-bi-dashboard)
- [Tools Used](#-tools--technologies-used)
- [Skills Demonstrated](#-skills-demonstrated)
- [Visual Gallery](#-visual-gallery)
- [Conclusion](#-conclusion)

---

# NBA 2023 Playoff Player Performance Analysis

This project presents a comprehensive performance analysis of NBA players during the **2023 Playoffs**, combining statistical modeling in **RStudio** with interactive reporting via **Power BI**. It applies key techniques from **data analytics, machine learning, and business intelligence**, aligning with SAS-based methodologies for real-world impact.

Players were segmented and ranked using:
- **Exploratory Data Analysis (EDA)**
- **Custom Weighted Scoring Models**
- **Correlation & Statistical Analysis**
- **PCA + KMeans Clustering**
- **Interactive KPI Dashboards**

The result is a dual-layered insight experience that simulates what a data analyst or BI consultant might deliver to an NBA front office, marketing team, or performance staff.

---

## 🏀 Scoring Trends & Efficiency
- **Devin Booker** led with **33.7 PPG**, driven by elite 2PT shooting.
- **Stephen Curry** averaged **30.5 PPG**, powered by 4.4 made 3s/game.
- **Jokić** and **Durant** dominated with highly efficient, balanced scoring.

> 🔍 **Insight:** Scoring efficiency came from maximizing different strengths — FT drawing (Durant), 3PT accuracy (Curry), and interior control (Jokić).

---

## 🎯 Assist Efficiency & Playmaking
- **Jokić**: 9.5 AST, 3.5 TOV — exceptional for a center.
- **Booker** & **Harden**: High assists, low turnovers.

> 🔍 **Insight:** Top playmakers not only passed well, but protected possessions.

---

## 🛡️ Defensive Standouts
- **Steals:** Butler, Harden (1.8 STL); Booker (1.7).
- **Blocks:** Davis (3.1), Embiid (2.8).
- **Davis** was the only top-10 player in **both steals and blocks**.

> 🔍 **Insight:** Defensive anchors showed versatility without excessive fouling.

---

## 🏀 Rebounding Leaders
- **Davis**: 14.1 RPG (11.7 DRB)
- **Jokić**: 13.5 RPG
- **Looney** & **Robinson**: Offensive rebounding specialists
  
>🔍 Insight: Dominant rebounders like Davis and Jokić controlled the defensive glass, while specialists like Looney and Robinson created extra possessions through offensive rebounding.

---

## 📈 Correlation Analysis
- **PTS & AST**: 0.81  
- **PTS & DRB**: 0.71  
- **AST & STL**: 0.74  
- **DRB & BLK**: 0.65  

> 🔍 **Insight:** Great scorers were often great facilitators and rebounders, showing all-around impact.

---

## 🏆 Weighted Score Rankings

Composite Score (20% each):  
**PTS + AST + STL + BLK + TRB**

Top performers included:
1. **Nikola Jokić**
2. **Devin Booker**
3. **Kevin Durant**
4. **Jayson Tatum**
5. **Anthony Davis**

> 🔍 **Insight:** Weighted metrics reveal balanced contributors beyond box score leaders.

---

## 📋 Top 10 Overall Performers (Detailed Breakdown)

| Rank | Player         | Key Stats |
|------|----------------|-----------|
| 1️⃣ | Jokić           | 30 PPG, 13.5 REB, 9.5 AST |
| 2️⃣ | Booker          | 33.7 PPG, 7.2 AST, 1.7 STL |
| 3️⃣ | Durant          | 29 PPG, 8.7 REB, 5.5 AST |
| 4️⃣ | Tatum           | 27.2 PPG, 10.5 REB, 5.3 AST |
| 5️⃣ | Davis           | 14.1 REB, 3.1 BLK, 22.6 PPG |
| 6️⃣ | Curry           | 30.5 PPG, 6.1 AST |
| 7️⃣ | LeBron James    | 24.5 PPG, 9.9 REB, 6.5 AST |
| 8️⃣ | Jimmy Butler    | 26.9 PPG, 1.8 STL |
| 9️⃣ | Jamal Murray    | 26.1 PPG, 7.1 AST |
| 🔟 | Jalen Brunson   | 27.8 PPG, 5.6 AST |

> 🔍 **Insight:** The top 10 performers were not just high scorers — most contributed across multiple categories, reinforcing the value of all-around impact over isolated stats.

---

## 🧩 PCA & Clustering (Unsupervised Learning)

- **PCA** reduced 9 features into 2D space (63% variance retained)
- **KMeans (K=3)** clustered players into:
  - 🟣 Superstars  
  - 🔴 Starters  
  - 🔵 Role Players

> 🔍 **Insight:** Data-driven clustering aligns with perceived roles and highlights undervalued contributors.

---

## 📊 Power BI Dashboard

An interactive report was created to summarize playoff insights using **Power BI**, supporting filtering by team, position, and cluster role:

- Top Performers (Weighted Score)
- Scoring Breakdown (2PT / 3PT / FT)
- AST vs TOV (Bubble = Weighted Score)
- Offensive & Defensive Rebounding
- Defensive Efficiency (STL, BLK, PF)

📁 Files:
- [`NBA_2023_Playoff_Analysis.pbix`](NBA_2023_Playoff_Analysis.pbix)
- ![Dashboard Screenshot](DashBoard%20ScreenShot.png)

---

## 🧰 Tools & Technologies Used
- **R / RStudio** – Data wrangling, modeling, and clustering
- **Power BI** – Interactive dashboard and stakeholder visuals
- **ggplot2**, **ggcorrplot**, **factoextra** – Correlation, PCA, and cluster visualization
- **tidyverse**, **dplyr**, **scales**, **readxl** – Data prep and formatting
- **KMeans / PCA** – Unsupervised learning methods
- **DAX (Power BI)** – Custom measures for scoring, filtering, and KPI logic


---

## 💼 Skills Demonstrated

- **Exploratory Data Analysis (EDA)**
- **Descriptive & Predictive Modeling** (Weighted Score logic)
- **PCA + KMeans Clustering**
- **Feature Engineering** (2PT/3PT/FT, AST:TOV, etc.)
- **BI Dashboard Development** (Power BI)
- **SAS-aligned Methods** (scorecards, segmentation, performance KPIs)
- **Data Mining & Segmentation Analysis**
- **Business Intelligence Reporting**
- **Tool Proficiency:** R, Power BI, `ggplot2`, SAS-style logic, clustering methods

---

## 📸 Visual Gallery

#### 🔹 Correlation Heatmap
![Correlation Heatmap](visuals_nba_2023_playoffs/correlation_heatmap.png)

#### 🔹 Shooting Breakdown of Top Scorers
![Top Scorers Shooting Breakdown](visuals_nba_2023_playoffs/top_scorers_shooting.png)

#### 🔹 Assist Leaders (AST vs TOV)
![Assist Leaders](visuals_nba_2023_playoffs/assist_turnover.png)

#### 🔹 Steals Leaders (STL vs PF)
![Steals Leaders](visuals_nba_2023_playoffs/steals_fouls.png)

#### 🔹 Block Leaders (BLK vs PF)
![Block Leaders](visuals_nba_2023_playoffs/blocks_fouls.png)

#### 🔹 Rebound Leaders (ORB vs DRB)
![Rebound Leaders](visuals_nba_2023_playoffs/rebound_breakdown.png)

#### 🔹 Top 10 Overall Players Breakdown
![Top 10 Overall Players](visuals_nba_2023_playoffs/top_overall_weighted.png)

#### 🔹 Elbow Method for Optimal Clusters
![Elbow Method](visuals_nba_2023_playoffs/elbow_method.png)

#### 🔹 PCA Clustering of Player Roles
![PCA Clustering](visuals_nba_2023_playoffs/pca_clustering_roles.png)

---

## 📌 Conclusion

This project demonstrates the integration of advanced data analytics, machine learning techniques, and business intelligence reporting to produce a polished, real-world deliverable focused on NBA player performance.

By combining tools like **R**, **Power BI**, and **SAS-aligned methodologies**, the analysis delivers:

- Statistically grounded insights  
- Objective player rankings using custom scoring metrics  
- Role-based clustering through PCA and KMeans  
- A stakeholder-ready dashboard for decision-making support

This work reflects applied expertise gained through:

- 🎓 A **Bachelor’s in Management Information Systems & Business Analytics**  
- 📘 A **Master’s in Data Analytics** (in progress, with a minor in **AI & Machine Learning**)  
- 📜 **4 SAS Certifications** covering data mining, predictive analytics, business intelligence, performance management, and machine learning

This portfolio project serves as a real-world demonstration of how analytics and data storytelling can drive strategic decisions in both sports and business environments.


