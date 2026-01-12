library(ggplot2)

data <- read.csv("ADANIPORTS.csv")

data$Date <- as.Date(data$Date)

sample_data <- data[1:10, ]

ggplot(sample_data, aes(x = Open, y = Close)) +
  geom_point(size = 3, color = "blue") +
  labs(title = "Scatter Plot: Open vs Close Price",
       x = "Open Price",
       y = "Close Price")

volume_data <- data.frame(
  Type = c("Deliverable", "Non-Deliverable"),
  Volume = c(sum(data$Deliverable.Volume, na.rm = TRUE),
             sum(data$Volume, na.rm = TRUE) - sum(data$Deliverable.Volume, na.rm = TRUE))
)

ggplot(volume_data, aes(x = "", y = Volume, fill = Type)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  labs(title = "Pie Chart of Deliverable vs Non-Deliverable Volume")

hl_data <- sample_data

ggplot(hl_data, aes(x = as.factor(Date), ymin = Low, ymax = High)) +
  geom_linerange(size = 2, color = "red") +
  geom_point(aes(y = Low), color = "blue", size = 3) +
  geom_point(aes(y = High), color = "green", size = 3) +
  labs(title = "High-Low Price Chart",
       x = "Date",
       y = "Price")
