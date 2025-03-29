function illusofquantiles

clear all;
close all;

fs = 18;

xlim = 6;

x = linspace(-xlim,xlim,1000);

Pnormal = normpdf( x, 0, 1 );

Pgamma = gampdf( x, 4, 0.5 );


Pbroad  = normpdf( x, 0, 3.0 );

cmix    = 0.5;

Pplatykurtic = cmix * Pnormal + cmix * Pbroad;

Nsample = 10000;

Snormal = normrnd( 0, 1, 1, Nsample );
Sgamma  = gamrnd( 4, 0.5, 1, Nsample );

Splaty  = [ normrnd( 0, 3, Nsample/2 ), normrnd( 0, 1, Nsample/2 )];


med_normal = quantile( Snormal, 0.5 );
med_gamma  = quantile( Sgamma, 0.5 );
med_platy  = quantile( Splaty, 0.5 );

figure;
subplot(1,2,1)
hold on;
fill( [-xlim, x(x<med_normal), med_normal], [0, Pnormal(x<med_normal), 0], [0.7, 0.7, 1.0], 'LineWidth', 2 );
fill( [med_normal, x(x>=med_normal), xlim], [0, Pnormal(x>=med_normal), 0], [0.8, 0.8, 0.5], 'LineWidth', 2 );
hold off
set(gca, 'PlotBoxAspectRatio', [1,1,1], 'Box', 'on', 'LineWidth', 1, 'XTick', [0], 'YTick', [0], 'FontSize', fs );

xlabel( 'X', 'FontSize', fs );
ylabel( 'P(X)', 'FontSize', fs );


subplot(1,2,2);
hold on;
fill( [-xlim, x(x<med_gamma), med_gamma], [0, Pgamma(x<med_gamma), 0], [0.7, 0.7, 1.0], 'LineWidth', 2 );
fill( [med_gamma, x(x>=med_gamma), xlim], [0, Pgamma(x>=med_gamma), 0], [0.8, 0.8, 0.5], 'LineWidth', 2 );

hold off
set(gca, 'PlotBoxAspectRatio', [1,1,1], 'Box', 'on', 'LineWidth', 1, 'XTick', [0], 'YTick', [0], 'XLim', [0, xlim], 'FontSize', fs );

xlabel( 'X', 'FontSize', fs );
ylabel( 'P(X)', 'FontSize', fs );

print('illumedian', '-painters', '-dpng');


q_normal = quantile( Snormal, (0:4)/4 );
q_gamma  = quantile( Sgamma, (0:4)/4 );
q_platy  = quantile( Splaty, (0:4)/4 );



figure;

clrmap = colormap('jet');

subplot(1,2,1)
hold on;

for i = 1 : 4
    ix = find( q_normal(i) <= x & x < q_normal(i+1) );   
    fill( [x(ix(1)), x(ix), x(ix(end))], [0, Pnormal(ix), 0], clrmap(i*64,:), 'LineWidth', 1 );
end

plot( x, Pnormal, 'k', 'LineWidth', 2 );
hold off
set(gca, 'PlotBoxAspectRatio', [1,1,1], 'Box', 'on', 'LineWidth', 1, 'XTick', [0], 'YTick', [0], 'FontSize', fs );

xlabel( 'X', 'FontSize', fs );
ylabel( 'P(X)', 'FontSize', fs );


subplot(1,2,2);
hold on;
for i = 1 : 4
    ix = find( q_gamma(i) <= x & x < q_gamma(i+1) );   
    fill( [x(ix(1)), x(ix), x(ix(end))], [0, Pgamma(ix), 0], clrmap(i*64,:), 'LineWidth', 1 );
end

plot( x, Pgamma, 'k', 'LineWidth', 2 );
hold off
set(gca, 'PlotBoxAspectRatio', [1,1,1], 'Box', 'on', 'LineWidth', 1, 'XTick', [0], 'YTick', [0], 'XLim', [0,xlim], 'FontSize', fs );

xlabel( 'X', 'FontSize', fs );
ylabel( 'P(X)', 'FontSize', fs );

print('illuquartiles', '-painters', '-dpng');









return;