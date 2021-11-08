function [  ] = Visualization( data, clustering_result, is_showingnoise )
%Input:
%     data:is the data to be analyzed
%     clustering_result:is the result of 'Extreme_Clustering.m'
%     is_showingnoise:is 'true' or 'false', if 'true', show noises
%Output: is a visualization of clustering result
sum=size(data,1);
dim=size(data,2);
if dim>2
    dis=pdist(data);
    dis=squareform(dis);
    [v,stress]=mdscale(dis,2,'criterion','strain');
    data=v;
end
a=['r','g','b','m','c'];
b=['o','+','*','x'];
for ii=1:max(clustering_result)
   h=0;
   z=zeros(sum,2);
   for jj=1:sum
      if(clustering_result(jj)==ii)
         h=h+1;
         z(h,:)=data(jj,:);
      end
   end
   z(h+1:sum,:)=[];
   s=mod(ii,5)+1;
   t=mod(ii,4)+1;
   scatter(z(:,1),z(:,2),a(s),b(t))
   set(gca,'FontSize',15);
   xlabel('attribute 1','fontsize',18);
   ylabel('attribute 2','fontsize',18);
   title('Extreme clustering');
   hold on
end
if is_showingnoise
    h=0;
    z=zeros(sum,2);
    for jj=1:sum
        if(clustering_result(jj)==-1)
            h=h+1;
            z(h,:)=data(jj,:);
        end
    end
    z(h+1:sum,:)=[];
    scatter(z(:,1),z(:,2),'k','.')
end

end

