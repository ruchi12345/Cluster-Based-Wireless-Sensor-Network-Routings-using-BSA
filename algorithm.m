 
function [best_fit,best_idx]=algorithm()

global sense_node sense_range pop_size sensor_selected generation_size target_x target_y distance target_covered_for_each_node 

sensor_selected(:,:,1)=rand(pop_size,sense_node)>0.5; %  
target_covered_for_each_node=zeros(length(target_x(:,1)),length(target_x(1,:)),sense_node); %  

for k=1:sense_node %  
    for i=1:length(target_x(:,1)) 
        for j=1:length(target_x(1,:))
            if distance(i,j,k)<=sense_range
                target_covered_for_each_node(i,j,k)=1;
            end
        end
    end
end


for i=1:generation_size %  
    % 
   [f,temp1,temp2]=fitness(i);
   [best_fit,best_idx]=max(f);
   fprintf('\n generation=%d/%d  best_fit=%f  ave_fit=%f  coverage_ratio=%f  active_node_ratio=%f',i,...
       generation_size+1,max(f),sum(f)/pop_size,temp1(best_idx)/(length(target_x(1,:))*length(target_y(:,1))),temp2(best_idx)/(sense_node));
   sensor_selected(:,:,i+1)= BSA_OPT(f, sensor_selected(:,:,i), sense_node, 0.5, 0.07,1);
   sensor_selected(:,:,i+1)=global_search(sensor_selected(:,:,i+1));
end
  [f,temp1,temp2]=fitness(generation_size+1);
  fprintf('\n generation=%d/%d  best_fit=%f  ave_fit=%f',generation_size+1,generation_size+1,max(f),sum(f)/pop_size);
  [best_fit,best_idx]=max(fitness(generation_size+1)); % 
  fprintf('\n coveraged target ratio=%d/%d active_node_num=%d',temp1(best_idx),length(target_x(1,:))*length(target_y(:,1)),temp2(best_idx));



