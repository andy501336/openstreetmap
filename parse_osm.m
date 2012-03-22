% File:         parse_osm.m
% Author:       Ioannis Filippidis, jfilippidis@gmail.com
% Date:         2010.11.20
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      parse loaded OpenStreetMap xml structure
% Copyright:    Ioannis Filippidis, 2010-

function [parsed_osm] = parse_osm(osm)
parsed_osm.bounds = parse_bounds(osm.bounds);
parsed_osm.node = parse_node(osm.node);
parsed_osm.way = parse_way(osm.way);
parsed_osm.relation = parse_relation(osm.relation);
parsed_osm.Attributes = osm.Attributes;

function [parsed_bounds] = parse_bounds(bounds)
bounds = bounds.Attributes;

ymax = str2double(bounds.maxlat);
xmax = str2double(bounds.maxlon);
ymin = str2double(bounds.minlat);
xmin = str2double(bounds.minlon);

parsed_bounds = [xmin, xmax; ymin, ymax];

function [parsed_node] = parse_node(node)
Nnodes = size(node,2);

id = zeros(1, Nnodes);
xy = zeros(2, Nnodes);
for i=1:Nnodes
    id(1,i) = str2double(node{i}.Attributes.id);
    xy(:,i) = [str2double(node{i}.Attributes.lon);...
               str2double(node{i}.Attributes.lat)];
end
parsed_node.id = id;
parsed_node.xy = xy;

function [parsed_way] = parse_way(way)
Nways = size(way,2);

id = zeros(1,Nways);
nd = cell(1,Nways);
tag = cell(1,Nways);
for i=1:Nways
    waytemp = way{i};
    
    id(1,i) = str2double(waytemp.Attributes.id);
    
    Nnd = size(waytemp.nd, 2);
    ndtemp = zeros(1,Nnd);
    for j=1:Nnd
        ndtemp(1,j) = str2double(waytemp.nd{j}.Attributes.ref);
    end
    nd{1,i} = ndtemp;
    
    tag{1,i} = waytemp.tag;
%     Ntag = size(waytemp.tag,2);
%     for k=1:Ntag
%         if(strcmp(waytemp.tag{k}.Attributes.k,'name'))
%             tag{1,i} = gr2gren(waytemp.tag{k}.Attributes.v);
%         end
%     end
end
parsed_way.id = id;
parsed_way.nd = nd;
parsed_way.tag = tag;

function [parsed_relation] = parse_relation(relation)
Nrelations = size(relation,2);

% id = zeros(1,Nrelation);
% member = cell{1,Nrelation};
% tag = cell{1,Relation};
% for i = 1:Nrelation
%     relationtemp = osm.relation{i};
%     
%     id(1,i) = str2double(relationtemp.Attributes.id);
% end
    
parsed_relation = [];
