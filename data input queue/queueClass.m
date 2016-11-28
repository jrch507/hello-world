classdef queueClass<dataCubeClass
    properties
        % data  should be in row
    end
    methods
        
        function obj = queueClass(nMax)
            obj = obj@dataCubeClass(nMax);
        end
        
        function nleft = in(obj,data)
            if iscolumn(data)
                data = data';
            end
            obj.data = [obj.data,data];
            nleft = numel(obj.data);
        end
        
        function data = out(obj)
            data = obj.data(1);
            obj.data = obj.data(2:end);
        end
        
    end
end