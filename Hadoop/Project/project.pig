--Load Data from HDFS
inputDialogue4= LOAD 'hdfs:///user/thripura/input/episodeIV_dialogues.txt' USING PigStorage('\t') AS
(name:chararray, line:chararray);
inputDialogue5= LOAD 'hdfs:///user/thripura/input/episodeV_dialogues.txt' USING PigStorage('\t') AS
(name:chararray, line:chararray);
inputDialogue6= LOAD 'hdfs:///user/thripura/input/episodeVI_dialogues.txt' USING PigStorage('\t') AS
(name:chararray, line:chararray);

--Filter out the first 2 lines from each line
ranked4=RANK inputDialogue4;
OnlyDialogues4=FILTER ranked4 BY (rank_inputDialogues4 >2);
ranked5= RANK inputDialogues5;
OnlyDialogues5=FILTER ranked5 BY (rank_inputDialogues5 >2);
ranked6= RANK inputDialogues6;
OnlyDialogues6= FILTER ranked6 BY (rank_inputDialogues6 >2);

--Merge the three inputs
inputData = UNION OnlyDialogues4,OnlyDialogues5,OnlyDialogues6;

--Group by name
GROUP inputData BY name;

--Count the number of lines by each character
FOREACH groupByName GENERATE $0 as name, COUNT($1) as no_of_lines;
nameOrdered= ORDER names BY no_of_lines DESC;

--Remove the outputs folder
rmf hdfs:///user/thripura/outputs;

-Store result in HDFS
STORE namesOrdered INTO 'hdfs:///user/thripura/outputs' USING PigStorage('\t');