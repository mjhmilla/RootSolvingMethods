%%
% SPDX-FileCopyrightText: 2024 Matthew Millard <millard.matthew@gmail.com>
%
% SPDX-License-Identifier: MIT
%%
function figH = addFunctionAndRootPlot(figH,a,b,fcn,xR,yR,xErr,yErr,iter,fcnName)

x = [a:((b-a)/99):b];   
y = fcn(x);
plot(x,y,'DisplayName',fcnName);
hold on;
plot(xR,yR,'x');
hold on;
text(xR,yR,sprintf('%i iter\n%1.3e xError\n%1.3e yError',iter,xErr,yErr),...
    'FontSize',8,...
    'HorizontalAlignment','left',...
    'VerticalAlignment','top');
hold on;
xlabel('x');
ylabel('y');
grid on;
box off;
title([fcnName, ' Function']);
hold on;