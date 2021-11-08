function []= dp_image(imlist, ret)
% close all;
im = cell(10,1);
m = length(ret);
for i=1:m/20
    im{i} = cat(2, imlist{[(20*i-19):20*i]});
end
img = cat(1, im{:});
n_clu = max(ret);
%cmap = colormap(hsv);
cmap = colormap(prism);
%pcolor([1;33;1;33]');
%brighten(0);
% cmap = colormap;
imshow(img,'border','tight');
hold on;

%C=linspecer(6);
for ii=1:length(ret)
    m=mod(ii-1,20);
    n=floor((ii-1)/20);
    if ret(ii)==-1
         ic = int8(1);
         patch([m*92+1 92*(m+1) (m+1)*92 m*92+1], [n*112+1 n*112+1 (n+1)*112 (n+1)*112],cmap(ic,:),'facealpha',0, 'linestyle', 'none');
    else
        ic = int8((ret(ii)*64.)/(n_clu*1.));
%         ic = ret(ii);
 %       patch([m*92 92*(m+1) (m+1)*92 m*92]+1, [n*112 n*112 (n+1)*112 (n+1)*112]+1,cmap(ic,:),'facealpha',0.35, 'linestyle', 'none');
 
 % plot([m*92 92*(m+1) (m+1)*92 m*92]+1, [n*112 n*112 (n+1)*112 (n+1)*112]+1,cmap(ic,:),'facealpha',0.35,'linestyle', 'none');
  %patch([m*92 92*(m+1) (m+1)*92 m*92]+1, [n*112 n*112 (n+1)*112 (n+1)*112]+1,cmap(ic,:),'facealpha',0.35,'linestyle', 'none');
 % A=rand(15);
%  patch([m*92 92*(m+1) (m+1)*92 m*92]+1, [n*112 n*112 (n+1)*112 (n+1)*112]+1,cmap(ic,:),'facealpha',0.35,'linestyle', 'none');
        patch([m*92 92*(m+1) (m+1)*92 m*92]+1, [n*112 n*112 (n+1)*112 (n+1)*112]+1,cmap(ic,:),'facealpha',0.35, 'linestyle', 'none');

    end
end
hold off;