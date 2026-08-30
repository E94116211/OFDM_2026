% OFDM Subcarrier Spacing Analysis (Frequency Domain: k = 1.5, 2.0)
clear; clc; close all;

output_dir = fileparts(mfilename('fullpath'));

f = linspace(-2, 5, 1000); % Frequency vector

k_values = [1.5, 2.0];
titles_k = {'k = 3/2', 'k = 2'};
filenames = {'15', '20'};

for i = 1:length(k_values)
    k = k_values(i);
    
    fig_freq = figure('Position', [100, 100, 500, 300], 'Visible', 'on');
    
    % 使用原始 sinc 函數 (不取絕對值)
    sinc1 = sin(pi * f) ./ (pi * f); % Reference subcarrier
    sinc1(f == 0) = 1;
    shifted_f = f - k;
    sinc2 = sin(pi * shifted_f) ./ (pi * shifted_f); % Adjacent subcarrier
    sinc2(shifted_f == 0) = 1;
    
    % 使用與參考圖片相同的 MATLAB 預設藍、橘色系
    plot(f, sinc1, '-', 'Color', [0 0.4470 0.7410], 'LineWidth', 1.5); hold on;
    plot(f, sinc2, '-', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1.5); 
    
    % 完全比照附圖的 Y 軸刻度格式
    ylim([-0.4, 1.05]);
    yticks(-0.4:0.2:1);
    
    title(titles_k{i}, 'FontSize', 14);
    xlabel('Frequency', 'FontSize', 12); 
    ylabel('Amplitude', 'FontSize', 12);
    
    grid on;
    
    exportgraphics(gcf, fullfile(output_dir, sprintf('k_%s_freq.eps', filenames{i})), 'ContentType', 'vector');
    saveas(fig_freq, fullfile(output_dir, sprintf('k_%s_freq.png', filenames{i})));
end

