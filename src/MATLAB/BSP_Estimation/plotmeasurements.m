%% Plots the mean of the parameteres measured and their standard deviation
function [P] = plotmeasurements()

%% Mean computed in the ods file given
P=[19.4;
    10;
    28.36;
    32.92;
    34.84;
    26.98;
    39.92;
    39.06;
    21.96;
    21.86;
    25.92;
    12.76;
    16.38;
    28.18;
    17.56;
    25.62;
    26.1;
    31.63;
    24.24;
    23.15;
    8.34;
    24.66;
    34.92;
    38.9;
    46.76;
    55.12;
    98.18;
    89.48;
    79.76;
    94.22;
    10.38;
    7;
    9.42;
    2.82;
    18.34;
    32.62;
    29.96;
    31.22;
    30.7;
    30.12;
    57.725];

% Standard deviation computed from the ods file given
std=[
    1.019803903;
    0.8093207028;
    2.532390175;
    1.325518766;
    2.107842499;
    0.3898717738;
    6.106308214;
    5.784289066;
    1.504327092;
    4.366119559;
    5.738640954;
    9.92537153;
    2.526262061;
    0.8348652586;
    0.8414273587;
    1.577022511;
    0.6284902545;
    0.882892972;
    1.543696861;
    3.228002478;
    0.4449719092;
    2.283199509;
    3.645819524;
    4.068169121;
    7.375838935;
    9.069013177;
    1.407835218;
    5.123670559;
    2.746452257;
    1.302689526;
    0.8786353055;
    1.027131929;
    1.249799984;
    0.4324349662;
    3.041874422;
    1.948589233;
    2.170944495;
    2.587856256;
    2.196588264;
    2.982783935;
    5.952800461;
    ];

%% Plots the values
figure;
e = errorbar(P,std,'o');
str='#f9a800';
color = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
title('Hanavan Parameters Mean and Standard Deviation', 'FontSize',12,'FontWeight','bold','Color',color);
xlabel('Parameter Number');
ylabel('cm');

e.Color = 'black';
e.CapSize = 10;

%fname = 'C:\Users\Steven\Desktop\EMARO 2ND YEAR\HMHC\lab\repo2final\src\Report\Figures';
%filename=strcat('Hanavan Parameters');
%saveas(gca,fullfile(fname, filename), 'jpeg');

end
