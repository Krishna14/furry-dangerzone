% files = dir('*.txt');
% numfiles = length(files);
% mydata = cell(1, numfiles);
% 
% for i=1:length(files)  
%     eval(['importdata ' files(i).name ' ']);
% end
% 
%---------------------------------------------->
% A Script in MATLAB for reading data and storing it in .mat file for the
% eeg signals.
% Author - R R Sreekrishna
% Organization - BITS PILANI
numFiles = 100;
MyData = zeros(4097,100);
startRow = 1;
endRow = 4097;

for i=10:20
    filename = sprintf('abvag%2d',i);
    MyData(:,i) = im(filename,startRow,endRow);
end
