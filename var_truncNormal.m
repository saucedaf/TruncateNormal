function sigma = var_truncNormal_new( a, b, mu, sigma, data )

x1 = (a-mu)/sigma * normpdf( a, mu, sigma );
x2 = (b-mu)/sigma * normpdf( b, mu, sigma );

cx = normcdf( b, mu, sigma) - normcdf( a, mu, sigma );

yhat = var( data(data>(mu-6000)&data<(mu+6000)) );
sigma2 = yhat/((1+(x1-x2)/cx - ((normpdf(a,mu,sigma)-normpdf(b,mu, sigma))/cx)^2));
sigma = sqrt( sigma2 );

return;