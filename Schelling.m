classdef Schelling
    
    properties
        width
        height
        empty_ratio
        similarity_threshold
        n_iterations
        agents
        file_name
    end
    
    methods
        function obj = Schelling(width, height, empty_ratio, similarity_threshold, n_iterations, file_name)
            obj.width = width;
            obj.height = height;
            obj.empty_ratio = empty_ratio;
            obj.similarity_threshold = similarity_threshold;
            obj.n_iterations = n_iterations;
            obj.agents = zeros(obj.width, obj.height);
            obj.file_name = file_name;
        end
        
        function obj = populate(obj)
            obj.agents = randi([0 1],obj.width, obj.height);
            obj.agents(obj.agents == 0) = -1;
            empty_index = randi([1 obj.width*obj.height], 1, obj.width*obj.height*obj.empty_ratio);
            obj.agents(empty_index) = 0;
        end
        
        function val = is_unsatisfied(obj, x, y)
            current_agent = obj.agents(x,y);
            count_similar = 0;
            count_different = 0;
            neighbours_index = obj.get_neighbours_index(x,y);
            for i=1:1:length(neighbours_index)
                if current_agent == obj.agents(neighbours_index(i));
                    count_similar = count_similar+1;
                else
                    count_different = count_different+1;
                end
            end
            if count_similar+count_similar == 0
                val = true;
            else
                val = (count_similar/(count_similar+count_different)) < obj.similarity_threshold;
            end
        end
        
        function update(obj)
            agent_matrix = zeros(obj.width,obj.height,obj.n_iterations);
            agent_matrix(:,:,1) = obj.agents(:,:);
            for i=2:1:obj.n_iterations
                n_changes = 0;
                for j = 1:1:obj.width*obj.height
                    [x,y] = ind2sub([obj.width, obj.height],j);
                    if obj.agents(x,y) == 0
                       continue; 
                    end
                    if is_unsatisfied(obj,x,y) ~= 0
                        obj = move_to_empty(obj,x,y);
                        n_changes = n_changes+1;
                    end
                end
                spy(obj.agents(:,:) == -1,'b');
                hold on
                spy(obj.agents(:,:) == 1, 'r');
                hold off
                pause(0.01);
                agent_matrix(:,:,i) = obj.agents(:,:);
                fprintf('Iteration %d, changed %d \n',i,n_changes);
                if n_changes == 0
                    fprintf('System stabilized\n');
                    break;
                end
            end
            agent_matrix = agent_matrix(:,:,1:i);
            save(obj.file_name, 'agent_matrix','-v7.3');
        end
        
        
        function obj = move_to_empty(obj, x, y)
            current_agent = obj.agents(x,y);
            empty_houses = find(obj.agents==0);
            index_to_move = randi([1 length(empty_houses)],1);
            obj.agents(empty_houses(index_to_move)) = current_agent;
            obj.agents(x,y) = 0;
        end
        
        %Moore neighbourhood
        function [indexes] = get_neighbours_index(obj, x, y)
            indexes = [];
            
            if x>1
                indexes = [ indexes sub2ind([obj.width, obj.height],x-1, y)];
                if y>1
                    indexes =[ indexes sub2ind([obj.width, obj.height],x-1, y-1)];
                end
                if y<obj.height
                    indexes =[ indexes sub2ind([obj.width, obj.height],x-1, y+1)];
                end
            end
            
            if x<obj.width
                indexes =[ indexes sub2ind([obj.width, obj.height],x+1, y)];
                if y>1
                    indexes =[ indexes sub2ind([obj.width, obj.height],x+1, y-1)];
                end
                if y<obj.height
                    indexes =[ indexes sub2ind([obj.width, obj.height],x+1, y+1)];
                end
            end
            
            if y<obj.height
                indexes =[ indexes sub2ind([obj.width, obj.height],x, y+1)];
            end
            
            if y<obj.height && y>1
                indexes =[ indexes sub2ind([obj.width, obj.height],x, y-1)];
            end
        end
    end
    
end

