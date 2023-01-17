function helperVisualizeAnomalies(anomalies, errorAll, featureTest)
% HELPERVISUALIZEANOMALIES creates a plot of the detected anomalies
anomalyIdx = find(anomalies);
anomalyErr = errorAll(anomalies);


figure;



plot(errorAll)
hold on
plot(anomalyIdx, anomalyErr, 'x')
hold off
ylabel("Reconstruction Error")
xlabel("Observation")
legend("Error", "Candidate Anomaly")


end