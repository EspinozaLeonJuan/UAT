global class HDI_LogErroresSchedule implements Schedulable {
    private Integer batchSize;

    global HDI_LogErroresSchedule(){}

    global HDI_LogErroresSchedule(Integer batchSize){
        this.batchSize = batchSize;
    }

    global void execute(SchedulableContext sc){
        if(this.batchSize == null){
            Database.executeBatch(new HDI_LogErroresBatch());
        } else {
            Database.executeBatch(new HDI_LogErroresBatch(), this.batchSize);
        }
    }
}