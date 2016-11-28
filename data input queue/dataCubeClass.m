classdef dataCubeClass<matlab.mixin.Copyable
    properties
        data;
        nMax;
    end
    methods
        function obj = dataCubeClass(nMax)
            obj.nMax = nMax;
        end
        
        function index = sort(obj)
            index = sort(obj.data);
        end
        
        function res = sortByIndex(obj,index)
            try
                obj.data = obj.data(index);
                res = 1;
            catch ME
                res = 0;
            end
        end
        
    end
end
