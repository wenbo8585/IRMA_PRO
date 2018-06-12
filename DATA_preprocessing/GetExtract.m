
warning off 
% IRMA2007__class__real標籤文件 
fid = fopen('C:\Users\Administrator\Desktop\图像检索项目组\IRMA_annotate\IRMA_annotate\IRMA2007__class__real');
% 要提取圖像的文件夾目錄
p = genpath('C:\Users\Administrator\Desktop\图像检索项目组\IRMA_annotate\test');% 获得文件夹data下所有子文件的路径，这些路径存在字符串p中，以';'分割  

%%
% 生成所有圖像的label
% output： A--文件名矩陣：1x10986
%          B--label矩陣： 1x10986
%%
if ~exist('DATA_lable.mat','file')==0
    outstr = 'IRMA2007__class_';
    lines = 0;
    s = [];
    while ~feof(fid)
        f = fgetl(fid);   
        P = textscan(f,'%d %s %s');
        lines = lines + 1;
        A(lines) = P{1};
        b = strrep(char(P{3}), outstr, s); 
        b = str2num(b);
        B(lines) = b;   
    end
    save('DATA_lable.mat', 'A', 'B');
    fclose(fid);
else
    W = load('DATA_lable.mat');
    A = W.A;
    B = W.B;
end

%%
% 目錄操作
%%
length_p = size(p,2);%字符串p的长度  
path = {};%建立一个单元数组，数组的每个单元中包含一个目录  
temp = [];  

for i = 1:length_p %寻找分割符';'，一旦找到，则将路径temp写入path数组中  
    if p(i) ~= ';'  
        temp = [temp p(i)];  
    else   
        temp = [temp '\']; %在路径的最后加入 '\'  
        path = [path ; temp];  
        temp = [];  
    end  
end   

clear p length_p temp b;  
%%
% 至此获得data文件夹及其所有子文件夹（及子文件夹的子文件夹）的路径，存于数组path中。  
% 下面是逐一文件夹中读取图像，提取數據和對於標籤保存在data_extracted.mat
% output：  data_extracted.mat
%                       C 提取數據矩陣
%                       D label矩陣
%%
file_num = size(path,1);% 子文件夹的个数  
all_num = 0;
for i = 1:file_num  
    file_path =  path{i}; % 图像文件夹路径  
    img_path_list = dir(strcat(file_path,'*.pgm'));  
    img_num = length(img_path_list); %该文件夹中图像数量  
    
    if img_num > 0  
        for j = 1:img_num  
            image_name = img_path_list(j).name;% 图像名  
            image =  imread(strcat(file_path,image_name));
            image_N = strrep(image_name,'.pgm', '');
            %[id,idx] = ismember(C, image_N, 'rows');
            % 提取圖片標籤
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [iid,iidx] = find(A == str2num(image_N));
            all_num = all_num + 1;
            D(all_num) = B(iidx);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            figure(1)
            imshow(image)
            title('原始图像') 
            % 提取圓環特征
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            center = [60,60];
            maxR =60;
            minR =maxR*sqrt(1.0/17);

            inR = 0;
            outR = minR;
            for q=1:17
                if outR <= maxR
                    [ringImg, graymean, graystd] = GetRingGray(image,center,inR,outR);
                    C(2*q-1, all_num) = graymean;
                    C(2*q, all_num) = graystd; 
                end
            end    
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
            fprintf('%d %d %s\n',i,j,strcat(file_path,image_name));% 显示正在处理的路径和图像名  
            %图像处理过程 省略  
        end  
    end  
end  
save('data_extracted.mat', 'C', 'D');

