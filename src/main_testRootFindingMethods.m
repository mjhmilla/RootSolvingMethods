%%
% SPDX-FileCopyrightText: 2024 Matthew Millard <millard.matthew@gmail.com>
%
% SPDX-License-Identifier: MIT
%%
clc;
close all;
clear all;

epsilon = eps;
k1 = 1;
k2 = 0.5*(1+2.618033988749895);
n0 = 5;

fig = figure;
set(groot, 'defaultTextInterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');


%Lambert function
fcnLambert = @(argX)( (argX.*exp(argX)-1).*-1 );
a = 0;
b = 1;
[xR,yR,xErr,yErr,iter] = calcITPMethod(a,b,epsilon,n0,k1,k2,fcnLambert);

subplot(2,2,1);
    fig = addFunctionAndRootPlot(fig,a,b,fcnLambert,...
                    xR,yR,xErr,yErr,iter,'Lambert');


%Polyfrac
fcnPolyFrac = @(xArg)(xArg+(2/3))./(xArg+(101/100));
a = -3/4;
b = 0;
[xR,yR,xErr,yErr,iter] = calcITPMethod(a,b,epsilon,n0,k1,k2,fcnPolyFrac);

subplot(2,2,2);
    fig = addFunctionAndRootPlot(fig,a,b,fcnPolyFrac,...
                    xR,yR,xErr,yErr,iter,'PolyFrac');

%Tan Poly
fcnTanPoly = @(xArg)( (xArg-(1/3)).^2 .* atan( xArg - (1/3) )  );
a = 0;
b = 1;
[xR,yR,xErr,yErr,iter] = calcITPMethod(a,b,epsilon,n0,k1,k2,fcnTanPoly);

subplot(2,2,3);
    fig = addFunctionAndRootPlot(fig,a,b,fcnTanPoly,...
                    xR,yR,xErr,yErr,iter,'TanPoly');    

%Sawtooth cubed
fcnSawToothCubed = @(xArg)( (202.*xArg - 2.*floor((2.*xArg + 0.01)./(0.02)) - (0.1)).^3 );
a = -0.0035;
b = 0.014;
[xR,yR,xErr,yErr,iter] = calcITPMethod(a,b,epsilon,n0,k1,k2,fcnSawToothCubed);

subplot(2,2,4);
    fig = addFunctionAndRootPlot(fig,a,b,fcnSawToothCubed,...
                    xR,yR,xErr,yErr,iter,'SawToothCubed');    

