load('outX.mat')

x1o = 0.95836586; x2o = -0.322958325;
finalSize = 10000;

stimStorage = zeros(finalSize, 10);
iStorage = zeros(1, 10);
foundStorage = zeros(1, 10);
area = zeros(1, 10);
index = ceil(0.1:0.1:length(outX));

% for counter = 1:68
for counter = 1:1
    counter2 = 1;
%     while counter2 <= 10
    while counter2 <= 1
        [counter counter2]
       [found z i] = gradAlg(x1o, x2o, outX(counter, 1), outX(counter, 2));

       iStorage(counter2) = i;
       stimStorage(:, counter2) = z';
       area(counter2) = trapz(linspace(0, 100, 10000), z .^ 2);
       foundStorage(counter2) = found;
       counter2 = counter2 + 1;   
    end
    save(['optInOut' int2str(counter) '.mat']);
end

