%%
%分类标签文件夹路径
str = './IRMA_annotate/IRMA2007__class_';
%输出文件夹名称
outstr = './IRMA2007__class_';
%待抽取图像路径（10986張 resized）
oringalPath = './Resize/';
%抽取类数，總共有116類
classnum = 116;
%每一類抽取图像数,設置0抽取當一類所有圖像
%imgnum = 100;
imgnum = 0;
%%
flag = 0;
for i = 1:116
    filename = [str,num2str(i)];  
    ID = fopen(filename);
    P = textscan(ID,'%s %s');
    
    if(imgnum == 0)
        outpath = [outstr,num2str(i)];
        mkdir(outpath);
        disp(outpath);
        flag = flag + 1;
        if flag > classnum
            break;
        end    
        disp(length(P{1}));
        for j = 1 : length(P{1})
            picname = P{1}{j,1};
            try
                copyfile([oringalPath,picname,'.pgm'],[outpath,'\',picname,'.pgm']);
            catch
                disp(picname);
                disp('文件不存在');
            end
        end
    else
        if(length(P{1}) >= imgnum && flag <= 116)
        %Pn(i) = length(P{1});
            outpath = [outstr,num2str(i)];
            mkdir(outpath);
            disp(outpath);
            flag = flag + 1;
            if flag > classnum
                break;
            end    
            for j = 1 : imgnum
                picname = P{1}{j,1};
                copyfile([oringalPath,picname,'.pgm'],[outpath,'\',picname,'.pgm']);
            end
        end
    end  
    fclose(ID);
%celldisp(C)  
end
if(flag < classnum)
    disp('數量不足，減少每一類抽取圖像數或抽取類數');
end


 
