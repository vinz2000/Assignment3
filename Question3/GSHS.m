function f = GSHS(field,lam,th,ldesired)

% VISU2GSHSAG calculates a global spherical harmonic synthesis for any grid
% defined by lam and phi (each vectors). The radius must be scalar. The output
% is the distrubing potential and any derivative up to the fourth.
%
% HOW:     f = GSHS(field,lam,th,h,ldesired,cap,quant)
%
% Input: field [c x s]   gravity field in cs or sc format
%        lam   [n x 1]   longitude [deg]
%        th    [m x 1]   co-latitude [deg]
%        lmdesired  [1 x 1]   maximum degree (optional)
%
% Output: f    [n x m]   field quantity
%
% Note:    - h must be scalar!
%
% Weigelt, DoGE @ UofC                                             25.10.05

%----------------------------------------------------------------------------
% uses
% m-files: visu2normalklm.m, cs2sc.m, visu2isotf_ww.m
%----------------------------------------------------------------------------
% revision history
%
% Wouter
% ldesired, synthesis up to this degree
% constants_Grace
%
% January 30, 2009
% Add conversion to uplift rate
%
% June 14, 2010
% added: east-west component of the gravity tensor (T_{lambda lambda})
% see Novak and Grafarend (Stud Geophys Geod 2006) equation 55
%
% January 14, 2010
% added: horizontal displacement (same as horizontal gravity but with unit
% zero).
%
% March 10, 2011
% Corrected: horizontal gravity, derivative of Plm(costheta) does not give
% a sine(theta). This term is now removed.
%
% June 13, 2022
% Adapted for the PPI course
%
%----------------------------------------------------------------------------
% remarks
%----------------------------------------------------------------------------
%

%----------------------------------------------------------------------------
% INPUT CHECK and PREPARATION
%----------------------------------------------------------------------------

% Size determination for field
[row, col]=size(field);
if (row~=col) && (col~=2*row-1)
    error('Input ''field'' not in cs or sc format');
elseif col~=row
    % if data is in cs-format we transfer it to sc-format
    field=sc2cs(field);
    [row,col]=size(field);
end
lmax = row-1;

% check if r, lam and th are vectors
if ~any(size(lam)==1)
    error('''lam'' must be scalar or vectorial.');
elseif ~any(size(th)==1)
    error('''phi'' must be scalar or vectorial.');
end

% prepare coordinates
th   = sort(th(:));
lam  = lam(:).*pi/180;

% use the desired degree
if nargin < 5 || isempty(ldesired), ldesired = lmax; end
if ldesired < lmax
    field = field(1:ldesired+1,1:ldesired+1);
    lmax  = ldesired;
end

% rearrange field and substract reference field
field     = cs2sc(field);
[row,col] = size(field);

% prepare cosine and sine --> cos(m*lam) and sin(m*lam)
m       = [0:lmax];
l       = m';
mlam    = [lam*m]';
cosmlam = cos(mlam);
sinmlam = sin(mlam);

%----------------------------------------------------------------------------
% CALCULATION
%----------------------------------------------------------------------------
for m = 0:row-1
    if m==0
            P = Legendre_functions(l,m,th);         % calc fully normalized Legendre Polynoms
        % ------------------------------------------------------------------
        Cnm = field(:,row+m);           % get column with order 0
        Snm = zeros(row,1);             % there are no Sn0 coefficients
        TA(:,1) = P*Cnm;
        TB(:,1) = P*Snm;
    else        
            P = Legendre_functions(l,m,th);         % calc fully normalized Legendre Polynoms       
        % ------------------------------------------------------------------
        Cnm = field(:,row+m);           % get Cnm coefficients for order m
        Snm = field(:,row-m);           % get Snm coefficients for order m
        TA(:,m+1) = P*Cnm;
        TB(:,m+1) = P*Snm;
    end
end

% now do the final summation
f = TA*cosmlam+TB*sinmlam;


