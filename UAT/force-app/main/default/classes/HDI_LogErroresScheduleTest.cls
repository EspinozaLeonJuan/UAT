@isTest
public class HDI_LogErroresScheduleTest {
    private static String CRON_EXP = '0 0 0 3 9 ? 2022';
    @isTest
    static void testSchedule() {
        Integer batchSize = 5;
        String jobId = System.schedule('test Schedule', CRON_EXP, new HDI_LogErroresSchedule(batchSize));
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id =: jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
    }

    @isTest
    static void testScheduleNullSize() {
        Integer batchSize = 5;
        String jobId = System.schedule('test Schedule null size', CRON_EXP, new HDI_LogErroresSchedule());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id =: jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
    }
}