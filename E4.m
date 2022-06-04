%Gabriel Alexandre de Souza Braga
clear;
close all;
clc;
%% Parâmetros iniciais %%
% Carrega o trecho do audio do comercial na memória
[comercial, Fs] = audioread('palavroes_tigre.mp3');
comercial = comercial(:,1);     % Como o som é estereo, considera somente um canal para simplificar
soundsc(comercial,Fs);  % toca o áudio completo

load salame_mingue.mat;  % Carrega o vetor p com 1s do áudio do palavrão
soundsc(p, Fs);  % Toca na caixa de som

Ts = 1/Fs;      % Período de amostragem [s]
tc = 0:Ts:Ts*(length(comercial)-1); % Tempo do comercial
tp = 0:Ts:Ts*(length(p)-1);  % Tempo do palavrao

%% Identifica palavrão %%
id = xcorr(comercial, p);   % Faz correlação cruzada, dessa maneira o pedaço que é igual tem um ganho
[m, ti] = max(id);  % Identifica o maio valor no vetor, ou seja, o inicio de onde é igual
ti = Ts*(ti-((length(id)-1)/2)-1);  % Calcula o tempo em que foi dito o palavrão
strPrint = ['O tempo do palavrão é ' num2str(ti) ' segundos.']; % Prepara a string que será impressa
disp(strPrint); % Imprime o resultado encontrado

Ti = -Ts*((length(id)-1)/2):Ts:Ts*((length(id)-1)/2);   % % Tempo da correlação cruzada

%% Plota o sinal no tempo s(t) %%
% Cria figura
figure1 = figure('PaperOrientation', 'landscape', 'PaperUnits', 'centimeters',...
    'PaperType', 'A4',...
    'WindowState', 'maximized',...
    'Color', [1 1 1],...
    'Renderer', 'painters');

% Cria subplot do comercial
subplot1 = subplot(2, 1, 1, 'Parent', figure1);
hold(subplot1, 'on');

% Cria plot
plot(tc, comercial, 'DisplayName', 'Forma de onda do comercial', 'Parent', subplot1, 'LineWidth', 3);

% Cria rotulo y e x
ylabel('Amplitude   (V)', 'FontWeight', 'bold', 'FontName', 'Times New Roman');
xlabel('Tempo   (s)', 'FontWeight', 'bold',...
    'FontName', 'Times New Roman');

% Cria titulo
title('Forma de onda do comercial');

% Define limites do plot, para x e y
xlim(subplot1, [0 Ts*(length(comercial)-1)]);
ylim(subplot1, [-0.3 0.3]);

% Liga as grades e etc
box(subplot1, 'on');
grid(subplot1, 'on');
hold(subplot1, 'off');

% Define as propriedades restantes dos eixos
set(subplot1, 'AlphaScale', 'log', 'ColorScale', 'log', 'FontName',...
    'Times New Roman', 'FontSize', 16, 'FontWeight', 'bold', 'GridAlpha', 0.5,...
    'LineWidth', 1.5, 'MinorGridAlpha', 0.5);

% Plota o audio do palavrão
% Cria subplot
subplot2 = subplot(2, 1, 2, 'Parent', figure1);
hold(subplot2, 'on');

% Cria plot
plot(tp, p, 'DisplayName', 'Forma de onda do palavrão', 'Parent', subplot2, 'LineWidth', 3,...
    'Color', [0.85 0.33 0.098]);

% Cria rotulo y e x
ylabel('Amplitude   (V)', 'FontWeight', 'bold', 'FontName', 'Times New Roman');
xlabel('Tempo  (s)', 'FontWeight', 'bold',...
    'FontName', 'Times New Roman');

% Cria titulo
title('Forma de onda do palavrão');

% Define limites do plot, para x e y
xlim(subplot2, [0 Ts*(length(p)-1)]);
ylim(subplot2, [-0.3 0.3]);

% Liga as grades e etc
box(subplot2, 'on');
grid(subplot2, 'on');
hold(subplot2, 'off');

% Define as propriedades restantes dos eixos
set(subplot2, 'AlphaScale', 'log', 'ColorScale', 'log', 'FontName',...
    'Times New Roman', 'FontSize', 16, 'FontWeight', 'bold', 'GridAlpha', 0.5,...
    'LineWidth', 1.5, 'MinorGridAlpha', 0.5);

% Plota o audio da correlação cruzada
% Cria figura
figure2 = figure('PaperOrientation', 'landscape', 'PaperUnits', 'centimeters',...
    'PaperType', 'A4',...
    'WindowState', 'maximized',...
    'Color', [1 1 1],...
    'Renderer', 'painters');

% Cria subplot do comercial
axes1 = axes('Parent', figure2);
hold(axes1, 'on');

% Cria plot
plot1 = plot(Ti, id, 'LineWidth', 3);
set(plot1,'DisplayName', 'Forma de onda da correlação cruzada', 'Color', [0.00,0.45,0.74]);

% Cria rotulo y e x
ylabel('Amplitude   (V)', 'FontWeight', 'bold', 'FontName', 'Times New Roman');
xlabel('Tempo   (s)', 'FontWeight', 'bold',...
    'FontName', 'Times New Roman');

% Cria titulo
title('Forma de onda da correlação cruzada');

% Define limites do plot, para x e y
xlim(axes1, [0 Ts*(length(id)-1)/2]);
ylim(axes1, [-100 100]);

% Liga as grades e etc
box(axes1, 'on');
grid(axes1, 'on');
hold(axes1, 'off');

% Define as propriedades restantes dos eixos
set(axes1, 'AlphaScale', 'log', 'ColorScale', 'log', 'FontName',...
    'Times New Roman', 'FontSize', 16, 'FontWeight', 'bold', 'GridAlpha', 0.5,...
    'LineWidth', 1.5, 'MinorGridAlpha', 0.5);
