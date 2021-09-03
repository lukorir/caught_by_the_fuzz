# This is to replicate the Economist's daily chart of 2021/08/31
# On Covid-19 patients with severe symptoms suffer long-lasting cognitive impairments
# Author: Luke Korir
# Date: September 2021
# Data: "Cognitive deficits in people who have recovered from COVID-19", by A. Hampshire et al., EClinicalMedicine, 2021'
# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
library(ggplot2)

# Recreate the data as a dataframe
variable <- c("x5", "x4", "x3", "x2", "x1")

diff <- c(-0.03778, -0.07372, -0.12868, -0.26250, -0.46932)
serr <- c(0.01124, 0.01760, 0.07610, 0.08227, 0.15076)

dt <- data.frame(variable, diff, serr)
# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
# Start plotting
ggplot(dt, aes(diff, variable)) +
  theme_bw() +
  scale_x_continuous(limits = c(-0.8, 0), breaks = seq(-0.8, 0, by = 0.1), expand = c(0, 0), position = "top", 
                     labels = c("-0.8","-0.7","-0.6","-0.5","-0.4","-0.3", "-0.2", "-0.1", "0" )) +
  geom_boxplot(fill = "white", colour = "darkred", size = 1, weight = 2) +
  geom_errorbar(aes(xmax = diff + serr, xmin = diff - serr),
                position = "dodge", width = 0, size = 19, color = "lightblue", alpha = 0.5) +
  geom_vline(xintercept = 0, color = "red") +
  labs(title = "Caught by the fuzz",
       subtitle = "Difference in global cognitive score relative to people who had not had covid-19, standard deviation units",
       caption = 'Source: "Cognitive deficits in people who have recovered from COVID-19", by A. Hampshire et al., EClinicalMedicine, 2021') +
  theme(panel.border = element_blank(),
        panel.grid.major    = element_line(colour = "grey80", size = 1),
        panel.grid.minor    = element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 12),
        axis.ticks = element_blank(),
        plot.caption = element_text(hjust = 0), 
        plot.title.position = "plot",
        plot.caption.position =  "plot",
        axis.text.y = element_text(size = 12, hjust = 0.05)) + 
  scale_y_discrete('variable', labels = c(
    'x5' = 'Symptoms but without respiratory symptoms',
    'x4' = 'Respiratory symptoms, no assistance at home',
    'x3' = 'Respiratory symptoms, medical assistance at home',
    'x2' = 'Went to hospital but was not put on a ventilator',
    'x1' = 'Went to hospital and was put on a ventilator')) +
  geom_curve(aes(x = -0.38, y = 2.7, xend = -0.33, yend = 2.3), curvature = -.3, size = 0.6, arrow = arrow(type = "closed", length = unit(dt$serr, "cm"))) +
  geom_segment(aes(x = -0.5, xend = -0.5, y = 2.5, yend = 2.9),   color = "white", size =2) +
  geom_segment(aes(x = -0.4, xend = -0.4, y = 2.5, yend = 2.9),   color = "white", size =2) +
  annotate(geom = "text", x = -0.46, y = 2.75, label = "Standard error", color = "black", angle = 0)
ggsave('covid_19_and_cognition.png',  dpi = 100)
# _ _ _ _ _ _ _ _ _ _  END  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _