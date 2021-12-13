
function res = displaycarmodels ()
% loading cardata from cardata.mat
    car_data = load("cardata.mat");
%     Getting the unique values from the Cylinders column
    cy_options = unique(car_data.Cylinders);
%     Creating the menu for cylinder selection
    cylinder = menu("choose the number of cylinders : ",num2cell(cy_options));
    index = car_data.Cylinders == cy_options(cylinder);

    car_data_mod = car_data.Model(index,:);
%     Getting the unique values from the Model column
    model_options = unique(cellstr(car_data_mod));
%     Creating the menu for model selection
    model = menu("Choose your model",model_options);

%     Getting the row of the selected model
    rows = strtrim(string(car_data.Model)) == strtrim(string(model_options(model)));
    
%     Fetching details of the selected model
    horsepower = car_data.Horsepower(rows,:);
    weight = car_data.Weight(rows,:);
    origin = strtrim(string(car_data.Origin(rows,:)));
    
%     printing the car details
    for i = 1:numel(horsepower)
        fprintf("Horsepower: %d \n Weight (kg): %d \n Origin: %s\n\n", horsepower(i), weight(i), origin(i))
    end


