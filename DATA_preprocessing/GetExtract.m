
warning off 
% IRMA2007__class__real�˻`�ļ� 
fid = fopen('C:\Users\Administrator\Desktop\ͼ�������Ŀ��\IRMA_annotate\IRMA_annotate\IRMA2007__class__real');
% Ҫ��ȡ�D����ļ��AĿ�
p = genpath('C:\Users\Administrator\Desktop\ͼ�������Ŀ��\IRMA_annotate\test');% ����ļ���data���������ļ���·������Щ·�������ַ���p�У���';'�ָ�  

%%
% �������ЈD���label
% output�� A--�ļ�����ꇣ�1x10986
%          B--label��ꇣ� 1x10986
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
% Ŀ䛲���
%%
length_p = size(p,2);%�ַ���p�ĳ���  
path = {};%����һ����Ԫ���飬�����ÿ����Ԫ�а���һ��Ŀ¼  
temp = [];  

for i = 1:length_p %Ѱ�ҷָ��';'��һ���ҵ�����·��tempд��path������  
    if p(i) ~= ';'  
        temp = [temp p(i)];  
    else   
        temp = [temp '\']; %��·���������� '\'  
        path = [path ; temp];  
        temp = [];  
    end  
end   

clear p length_p temp b;  
%%
% ���˻��data�ļ��м����������ļ��У������ļ��е����ļ��У���·������������path�С�  
% ��������һ�ļ����ж�ȡͼ����ȡ�����͌�춘˻`������data_extracted.mat
% output��  data_extracted.mat
%                       C ��ȡ�������
%                       D label���
%%
file_num = size(path,1);% ���ļ��еĸ���  
all_num = 0;
for i = 1:file_num  
    file_path =  path{i}; % ͼ���ļ���·��  
    img_path_list = dir(strcat(file_path,'*.pgm'));  
    img_num = length(img_path_list); %���ļ�����ͼ������  
    
    if img_num > 0  
        for j = 1:img_num  
            image_name = img_path_list(j).name;% ͼ����  
            image =  imread(strcat(file_path,image_name));
            image_N = strrep(image_name,'.pgm', '');
            %[id,idx] = ismember(C, image_N, 'rows');
            % ��ȡ�DƬ�˻`
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [iid,iidx] = find(A == str2num(image_N));
            all_num = all_num + 1;
            D(all_num) = B(iidx);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
            figure(1)
            imshow(image)
            title('ԭʼͼ��') 
            % ��ȡ�A�h����
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
            fprintf('%d %d %s\n',i,j,strcat(file_path,image_name));% ��ʾ���ڴ����·����ͼ����  
            %ͼ������� ʡ��  
        end  
    end  
end  
save('data_extracted.mat', 'C', 'D');

