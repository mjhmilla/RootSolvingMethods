%%
% SPDX-FileCopyrightText: 2024 Matthew Millard <millard.matthew@gmail.com>
%
% SPDX-License-Identifier: MIT
%%
function [xRoot,yRoot,xError,yError,k] = calcITPMethod(a,b,epsilon,n0,k1,k2,fcn)
% I. F. D. Oliveira and R. H. C. Takahashi. 2020. An Enhancement of the 
% Bisection Method Average Performance Preserving Minmax Optimality. ACM 
% Trans. Math. Softw. 47, 1, Article 5 (March 2021), 24 pages. 
% https://doi.org/10.1145/3423597

assert( a <= b);
assert(epsilon > 0);
assert(n0 >= 0);
assert(k1 > 0);
%k2 < 1+phi, where phi is the golden ratio: 0.5*(1+sqrt(5));
assert(1 <= k2 && k2 < (2.618033988749895));

ySign = 1;
ya= ySign*fcn(a);
yb= ySign*fcn(b);

if(ya > 0 && yb < 0)
    ySign = -1;
    ya= ySign*ya;
    yb= ySign*yb;    
end

assert(ya < 0);
assert(yb > 0);

xTmp = (b-a)/(2*epsilon);
log2xTmp = log(xTmp)/log(2);
nHalf= ceil(log2xTmp);
nMax = nHalf+n0;
k=0;

xt=0;
xTilde=0;
while (b-a) > 2*epsilon
    %Interpolation
    xf = (yb*a - ya*b)/(yb-ya);
    %Truncation
    xHalf = (a+b)*0.5;
    sigma = sign(xHalf-xf);
    delta = k1*( (b-a).^k2);
    if (delta <= abs(xHalf-xf)) 
        xt=xf +sigma*delta;
    else
        xt=xHalf;
    end
    %Projection
    r = epsilon*(2^(nMax-k)) - (b-a)*0.5;

    if( abs(xt-xHalf)<=r)
        xTilde=xt;
    else
        xTilde = xHalf-sigma*r;
    end

    %Updating
    yTilde = ySign*fcn(xTilde);
    if( yTilde > 0 )
        b = xTilde;
        yb = yTilde;
    elseif( yTilde < 0)
        a =xTilde;
        ya = yTilde;
    else
        a = xTilde;
        b = xTilde;
    end
    k = k+1;
end
xRoot= xTilde;
yRoot= ySign*yTilde;
xError = abs(b-a);
yError = abs(yb-ya);