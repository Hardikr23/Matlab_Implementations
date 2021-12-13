 
function [C, V] = mykmeans(Data, k)
    n = size(Data, 1); % Total points
    rand_idx = randi(n, [k,1]); % Selecting k random points as centroids
    centroid_mat = Data(rand_idx,:);
    V = []; % initialisation
    old_centroid_mat = zeros(size(centroid_mat));
    while true %loop to iter till our old and new centroids come same
        if old_centroid_mat == centroid_mat % breaking condition
            break
        else
            old_centroid_mat = centroid_mat; % update old_centroid value and continue execution
        end
        for idx = 1:n %loop to iter through all data points
            min_distance = Inf; % Assigning +ve infinity as initial min distance
            for centroid = 1:size(centroid_mat,1) % loop to check distance with over every centroid
                distance = pdist2(centroid_mat(centroid,:),Data(idx,:)); % calculatng distance with each centroid
                if distance < min_distance % condition to all the datapoint to the nearest centroid's cluster 
                    min_distance = distance;
                    V(idx) = centroid; % appending the cluster value to the V array.
                end
            end
        end
        for centroid_2 = 1:size(centroid_mat,1) % loop to re-calculate the new centroid
            if ismember(centroid_2,V) %checking to see if V has any elements of the cluster or not. Or else it return NaN
                all_points = find(centroid_2==V); % Getting index array of all points in one cluster
                all_cluster_data = Data(all_points,:); % Extracting the actual data points using the indices.
                centroid_mat(centroid_2,:) = sum(all_cluster_data)/size(all_cluster_data,1); % Re-calculating the centroid
            else
                continue
            end
        end
        
    end
    C = centroid_mat;
    hold on 
    for centroid_3 = 1:size(centroid_mat,1) % loop to plot the graphs of centroid and the cluster points
        all_cluster_idx = find(centroid_3==V); 
        all_cluster_data_1 = Data(all_cluster_idx,:);
        plot(all_cluster_data_1(:,1),all_cluster_data_1(:,2),'x','color',[rand rand rand]); % Plotting the cluster points
        plot(centroid_mat(centroid_3,1),centroid_mat(centroid_3,2),"d",MarkerFaceColor="red"); % Plotting the centroid points
    end
end