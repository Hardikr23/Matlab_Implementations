
% Reading all files data abd making a cell array of each.
RR_file = fopen("RedRidingHood.txt","r");
RR_data = textscan(RR_file,"%s");
RR_data = lower(RR_data{1});

PP_file = fopen("PrincessPea.txt","r");
PP_data = textscan(PP_file,"%s");
PP_data = lower(PP_data{1});

CD_file=fopen("Cinderella.txt","r");
CD_data = textscan(CD_file,"%s");
CD_data = lower(CD_data{1});

C1_file = fopen("CAFA1.txt","r");
C1_data = textscan(C1_file,"%s"); 
C1_data = lower(C1_data{1});

C2_file = fopen("CAFA2.txt","r");
C2_data = textscan(C2_file,"%s"); 
C2_data = lower(C2_data{1});

C3_file = fopen("CAFA3.txt","r");
C3_data = textscan(C3_file,"%s"); 
C3_data = lower(C3_data{1});


% Creating the corpus of unique words accross all files.
corpus = unique([RR_data; PP_data; CD_data; C1_data; C2_data; C3_data]);

% Creating a cell array of words with respect to each document.
doc_data = {RR_data, PP_data, CD_data, C1_data, C2_data, C3_data};

% Initialisation dor efficiancy
tf_idfs_cell = cell(1,6);

% Loop to iter over each document and create its tf-idf vector
for doc = 1:numel(doc_data)
    doc_tf_idf = cell(1,numel(corpus));
%     Loop to iter over each word from the corpus and creates its tf-idf
%     score
    for word = 1:numel(corpus)
        a_tf = sum(ismember(doc_data{doc},corpus(word)));
        idf = word_count(doc_data,corpus(word));
        b_idf = log10(numel(doc_data)/idf);
        doc_tf_idf{word} = a_tf * b_idf;
    end
%     Appending each document vector in a parent cell array
    tf_idfs_cell{doc} = doc_tf_idf;
end


doc_similarity_mat = zeros([6,6]);

% Comparing each document vector with itself and all other vectors.
for tf_idf = 1:numel(tf_idfs_cell)
    vec_1 = cell2mat(tf_idfs_cell{tf_idf});
    for tf_idf_1 = 1:numel(tf_idfs_cell)
        vec_2 = cell2mat(tf_idfs_cell{tf_idf_1});
%         Calculating the cos of the 2 vectors.
        cos_theta = (dot(vec_1,vec_2)/(norm(vec_1)*norm(vec_2)));
        cos_degrees = 1 - cos_theta;
        doc_similarity_mat(tf_idf, tf_idf_1) = cos_degrees;
    end
end

% Plotting the similarity graph.
imagesc(doc_similarity_mat);
colormap("gray");
colorbar;
xticklabels = {'RRH', 'PPea', 'Cinde', 'CAFA1', 'CAFA2', 'CAFA3'};
set(gca, 'XTick', [1:6], 'XTickLabel', xticklabels);
set(gca, 'YTick', [1:6], 'YTickLabel', xticklabels);
title("Cosine Distance")