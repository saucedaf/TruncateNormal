function ci99 = getCI99( data )

mu = median( data );
sigma = std( data );
fprintf( 1, 'initial sigma = %.1f\n', sigma );
sigma = var_truncNormal_new( mu-3000, mu+3000, mu, sigma, data );
fprintf( 1, 'updated sigma = %.1f\n', sigma );
sigma = var_truncNormal_new( mu-3000, mu+3000, mu, sigma, data );
fprintf( 1, 'updated sigma = %.1f\n', sigma );

ci99 = 2*mu-norminv( 0.01, mu, sigma );
ci99point9 = 2*mu-norminv( 0.001, mu, sigma );
ci99point99 = 2*mu-norminv( 0.0001, mu, sigma );

step = 500;
xAxisLim = 70000;
figure( 'visible', 'on' );
hist( data, 5000:step:xAxisLim );
[nh] = hist( data, 5000:step:xAxisLim );  

hold;
%[n2, xx] = ksdensity( data, 'npoints', 100 );
[n2, xx] = ksdensity( data, 5000:step:xAxisLim );
plot( xx, n2*length(data)*step, 'r' );

hdl = plot( xx, normpdf( xx, mu, sigma )*length(data)*step, 'g' );
set( hdl, 'linewidth', 2 );

line( [ci99 ci99], [0 300], 'color', 'g');
line( [ci99point9 ci99point9], [0 300], 'color','g' );
line( [ci99point99 ci99point99], [0 300], 'color','g' );


axis( [5000 xAxisLim 0 ceil( max(normpdf( xx, mu, sigma )*length(data)*step))+10] );

hold;

print( '-dpdf', 'testFigure' );

hold;


return;