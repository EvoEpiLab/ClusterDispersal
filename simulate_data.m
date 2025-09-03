%==========================================================================
% Simulation of microbial community assembly
% Created by Loïc Marrec
%==========================================================================

clear; close all; clc;

%% Parameters

% Dispersal rate 
c_values = logspace(-4, 4, 9);

% Replication rates
rA = 1;       % Species A
rB = 1.05;    % Species B

% Initial abundances
N0A = 0;      % Species A
N0B = 0;      % Species B

% Carrying capacity
K = 1e5;

% Cluster sizes
n_values = [1 2 5 10 20 50 100 200 500 1000];

% Abundance of A in the pool
pA = 0.5;

% Number of replicates
Nrep = 1e2;

% Preallocate result matrices
BC = NaN(length(c_values), length(n_values));      % Bimodality coefficient
NAmean = NaN(length(c_values), length(n_values));  % Mean relative abundance

%% Main Simulation Loop

for i = 1 : length(c_values)

    for j = 1 : length(n_values)
        
        % Simulate assembly
        [NAlist, ~] = Assembly(Nrep, rA, rB, pA, N0A, N0B, K, c_values(i), n_values(j));
        
        % Calculate metrics
        NAmean(i, j) = mean(NAlist) / K;
        BC(i, j) = bimodality_coefficient(NAlist ./ K);
        
        % Progress display
        fprintf('Simulation in progress -> c: %d/%d, n: %d/%d\n', i, length(c_values), j, length(n_values));

    end

end

%% Plot 1: BC vs Dispersal Rate (for each cluster size)

nb_n_values_plot1 = 4;
plot1 = gobjects(1, nb_n_values_plot1); 
colors_plot1 = lines(nb_n_values_plot1);

figure;
hold on;
for j = 1 : nb_n_values_plot1

    plot1(j) = plot(c_values, BC(:, j), 'o', 'MarkerFaceColor', colors_plot1(j, :), 'DisplayName', sprintf('n = %d', n_values(j)));

end
plot([min(c_values) max(c_values)], [1/3 1/3], '-', 'LineWidth', 1.5, 'Color', [200 200 200]./255);
plot([min(c_values) max(c_values)], [5/9 5/9], '-', 'LineWidth', 1.5, 'Color', [200 200 200]./255);
plot([min(c_values) max(c_values)], [1 1], '-', 'LineWidth', 1.5, 'Color', [200 200 200]./255);
hold off;
set(gca, 'XScale', 'log', 'FontName', 'Arial', 'FontSize', 14);
xlabel('Dispersal rate, c');
ylabel('Bimodality coefficient, BC');
legend(plot1, 'Location', 'NorthEast');
xlim([min(c_values) max(c_values)]);
ylim([0 1]);
title('Bimodality coefficient vs Dispersal rate');

%% Plot 2: BC vs Cluster Size (for lowest dispersal rate)

figure;
hold on;
plot(n_values, BC(1, :), 'o', 'Color', 'k', 'MarkerFaceColor', 'k');
plot([min(n_values) max(n_values)], [1/3 1/3], '-', 'LineWidth', 1.5, 'Color', [200 200 200]./255);
plot([min(n_values) max(n_values)], [5/9 5/9], '-', 'LineWidth', 1.5, 'Color', [200 200 200]./255);
plot([min(n_values) max(n_values)], [1 1], '-', 'LineWidth', 1.5, 'Color', [200 200 200]./255);
set(gca, 'XScale', 'log', 'FontName', 'Arial', 'FontSize', 14);
xlabel('Cluster size, n');
ylabel('Bimodality coefficient, BC');
xlim([min(n_values) max(n_values)]);
ylim([0 1]);
title('Bimodality coefficient vs Cluster size (c = 1e-4)');

%% Plot 3: Mean Abundance vs Dispersal Rate (for each cluster size)

nb_n_values_plot3 = 4;
plot3 = gobjects(1, nb_n_values_plot3); 
colors_plot3 = lines(nb_n_values_plot3);

figure;
hold on;
for j = 1 : nb_n_values_plot3

    plot3(j) = plot(c_values, NAmean(:, j) * 100, 'o', 'MarkerFaceColor', colors_plot3(j, :), 'DisplayName', sprintf('n = %d', n_values(j)));

end
plot([min(c_values) max(c_values)], [pA * 100 pA * 100], '-', 'LineWidth', 1.5, 'Color', [200 200 200]./255);
hold off;
set(gca, 'XScale', 'log', 'FontName', 'Arial', 'FontSize', 14);
xlabel('Dispersal rate, c');
ylabel('Mean relative abundance of A, \langle x_A \rangle (%)');
legend(plot3, 'Location', 'NorthEast');
ylim([0 100]);
title('Mean abundance of A vs Dispersal rate');

%% Plot 4: Mean Abundance vs Cluster Size (for lowest dispersal rate)

figure;
hold on;
plot(n_values, NAmean(1, :) * 100, 'o', 'Color', 'k', 'MarkerFaceColor', 'k');
plot([min(n_values) max(n_values)], [pA * 100 pA * 100], '-', 'LineWidth', 1.5, 'Color', [200 200 200]./255);
hold off;
set(gca, 'XScale', 'log', 'FontName', 'Arial', 'FontSize', 14);
xlabel('Cluster size, n');
ylabel('Mean relative abundance of A, \langle x_A \rangle (%)');
ylim([0 100]);
title('Mean abundance of A vs Cluster size (c = 1e-4)');
