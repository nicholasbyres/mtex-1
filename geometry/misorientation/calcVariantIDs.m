function [variantList] = calcVariantIDs(parentOri,childOri,p2c,variantIDs)
%
% Syntax
%
%   variantList = calcVariantIDs(parentOri,childOri,p2c,variantIDs)
%
% Input
%  parentOri  - parent @orientation
%  childOri   - child @orientation
%  p2c        - parent to child mis@orientation
%  variantIDs - order of child variants 
%
% Output
%  variantList  - child variant Id
%
% Description
%
%

parentOri = parentOri.project2FundamentalRegion;

% all child variants
childVariants  = variants(p2c, parentOri);

if nargin == 4
   childVariants = childVariants(:,variantIDs); 
end

if size(childVariants,1) == 1
  childVariants = repmat(childVariants,length(childOri),1);
end
  
% compute distance to all possible variants
d = dot(childVariants,repmat(childOri,1,size(childVariants,2)));

% take the best fit
[~,variantList] = max(d,[],2);
% remove variants for which no parent orientation exists
variantList(all(isnan(d),2)) = nan;

end