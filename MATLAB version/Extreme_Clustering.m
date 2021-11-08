function [ clustering_result ] = Extreme_Clustering( data,neighbourhood_radius,isGaussian )
%Input:
%     data:is the data to be analyzed
%     neighbourhood_radius:is the radiu of neighbourhood
%     isGaussian: is 'true' or 'false'. If 'true', then use Gaussian density
%Output:
%     clustering_result:is the result of extreme clustering, and stored the
%                       category of objects.'-1' stands for noise.

dis=pdist(data);
dis=squareform(dis);
sum=size(data,1);
b=dis;
c=ones(sum,sum);
for ii=1:sum
[b(ii,:),c(ii,:)]=sort(b(ii,:),'ascend');
end
dimensional=size(data,2);

%computing density of objects
if ~isGaussian
    density_radius=mean(b(:,floor(sum*0.02)));
    density=ones(1,sum);
    for ii=1:sum
        jj=1;
        while(b(ii,jj)<density_radius)
            jj=jj+1;
        end
        density(ii)=jj;
    end
else
    dis1=dis;
    position=round(size(dis1,2)*0.013);  
    sda=sort(dis1); 
    dc=sda(position);  
    density=zeros(1,sum); 
    for i=1:sum-1  
        for j=i+1:sum 
            density(i)=density(i)+exp(-(dis(i,j)/dc)*(dis(i,j)/dc));  
            density(j)=density(j)+exp(-(dis(i,j)/dc)*(dis(i,j)/dc));  
        end  
    end  
end

%finding all extreme points
extremepoint=ones(sum,dimensional+1);
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
               extremepoint(extremepoint_num,1:dimensional)=data(ii,1:dimensional);
               extremepoint(extremepoint_num,dimensional+1)=ii;
         end
     end
end
extremepoint(extremepoint_num+1:sum,:)=[];


%clustering
clustering_result=zeros(1,sum);%storaging the category of each object after clustering
for ii=1:size(extremepoint,1)
   clustering_result(extremepoint(ii,dimensional+1))=ii;
   jj=2;
   while(b(extremepoint(ii,dimensional+1),jj)<neighbourhood_radius)
      if(density(extremepoint(ii,dimensional+1))==density(c(extremepoint(ii,dimensional+1),jj)))
          clustering_result(c(extremepoint(ii,dimensional+1),jj))=ii;
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
num_mean=mean(num);
for ii=1:size(extremepoint,1)
    if(num(ii)<=num_mean*0.05)
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

end

