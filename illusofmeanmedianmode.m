function illusofmeanmedianmode

clear all;
close all;

fs   = 18;

xlim = 6;

x    = linspace(0,xlim,1000);

Pgamma     = gampdf( x, 4, 0.5 );

Nsample    = 10000;

Sgamma     = gamrnd( 4, 0.5, 1, Nsample );

med_gamma  = quantile( Sgamma, 0.5 );

mean_gamma = mean( Sgamma );

Pmax       = max(Pgamma);

mode_gamma = x( Pgamma==Pmax );



figure;
hold on;
fill( [x(1), x, x(end)], [0, Pgamma, 0], [1.0, 0.8, 0.0], 'LineWidth', 2 );
plot( med_gamma*[1,1], 0.94 * Pmax*[0,1], 'k', 'LineWidth', 1 );
plot( mean_gamma*[1,1], 0.88 * Pmax*[0,1], 'k', 'LineWidth', 1 );
plot( mode_gamma*[1,1], Pmax*[0,1], 'k', 'LineWidth', 1 );
hold off
set(gca, 'PlotBoxAspectRatio', [2,1,1], 'Box', 'on', 'LineWidth', 1, 'XTick', [0], 'YTick', [0], 'YLim', Pmax*[0,1.2], 'FontSize', fs );
xlabel( 'X', 'FontSize', fs );
ylabel( 'P(X)', 'FontSize', fs );

text( mean_gamma, 0.95 * Pmax, 'mean', 'FontSize', fs );

text( med_gamma, 1.05 * Pmax, 'median', 'FontSize', fs );

text( mode_gamma, 1.15 * Pmax, 'mode', 'FontSize', fs );

print('illumeanmedianmode', '-painters', '-dpng');




return;