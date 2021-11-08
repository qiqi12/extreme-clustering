load matlab.mat;
dis=im_100;
sum=100;
b=dis;
c=ones(sum,sum);
for ii=1:sum
[b(ii,:),c(ii,:)]=sort(b(ii,:),'ascend');
end
density_radius=mean(b(:,4));
neighbourhood_radius=0.12648;

%computing density of objects
density=ones(1,sum);
for ii=1:sum
    jj=1;
    while(b(ii,jj)<density_radius)
        jj=jj+1;
    end
    density(ii)=jj;
end

%finding all extreme points
extremepoint=ones(sum,1);
extremepoint_num=0;% storaging the number of extreme points
status=zeros(1,sum);
for ii=1:sum
    if(status(ii)==0)
         jj=2;
         while(density(ii)>=density(c(ii,jj))&(b(ii,jj)<neighbourhood_radius))
               if(density(ii)==density(c(ii,jj)))
                     status(c(ii,jj))=1;
               end
               jj=jj+1;
         end
         if(b(ii,jj)>=neighbourhood_radius)
               extremepoint_num=extremepoint_num+1;
               extremepoint(extremepoint_num)=ii;
         end
     end
end
extremepoint(extremepoint_num+1:sum,:)=[];

%clustering
clustering_result=zeros(sum,1);%storaging the category of each object after clustering
for ii=1:size(extremepoint,1)
   clustering_result(extremepoint(ii))=ii;
   jj=2;
   while(b(extremepoint(ii),jj)<neighbourhood_radius)
      if(density(extremepoint(ii))==density(c(extremepoint(ii),jj)))
          clustering_result(c(extremepoint(ii),jj))=ii;
      end
      jj=jj+1;
   end    
end
for ii=1:sum
   if(clustering_result(ii)==0)
       queue=zeros(1,sum);
       s=1;
       queue(s)=ii;
       while 1
            jj=1;
            while(density(c(queue(s),jj))<=density(queue(s)))
                  jj=jj+1;
            end              
            if(clustering_result(c(queue(s),jj))==0)
                  s=s+1;
                  queue(s)=c(queue(s-1),jj);
            else
                  break;
            end
       end
       for g=1:s
            clustering_result(queue(g))=clustering_result(c(queue(s),jj));
       end
  end
end

%identifying noise objects, '-1' stands for noise
num=zeros(size(extremepoint,1),1);
for ii=1:sum
   num(clustering_result(ii))=num(clustering_result(ii))+1;
end
for ii=1:size(extremepoint,1)
    if(num(ii)<=4)
         for jj=1:sum
              if (clustering_result(jj)==ii)
                      clustering_result(jj)=-1;
              end
         end
    end
end
label_num=0;
label_max=max(clustering_result);
clustering_result_lin=-ones(sum,1);
for ii=1:label_max
    zz=0;
    for jj=1:sum
        if(clustering_result(jj)==ii)
            zz=1;
        end
    end
    if(zz==1)
        label_num=label_num+1;
        for jj=1:sum
            if(clustering_result(jj)==ii)
                clustering_result_lin(jj)=label_num;
            end
        end
    end
end
clustering_result=clustering_result_lin;
dp_image(imlist_100, clustering_result);



