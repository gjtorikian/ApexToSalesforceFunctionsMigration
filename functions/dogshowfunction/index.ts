import { InvocationEvent, Context, Logger, RecordQueryResult } from "sf-fx-sdk-nodejs";
import fetch from 'node-fetch';

/**
 * Describe Dogshowfunction here.
 *
 * The exported method is the entry point for your code when the function is invoked.
 *
 * Following parameters are pre-configured and provided to your function on execution:
 * @param event: representative of the data associated with the occurrence of an event,
 * and supporting metadata about the source of that occurrence.
 * @param context: represents the connection to the the execution environment and the Customer 360 instance that
 * the function is associated with.
 * @param logger: represents the logging functionality to log given messages at various levels
 */

 export default async function execute(event: InvocationEvent<any>, context: Context, logger: Logger): Promise<RecordQueryResult> {
    logger.info(`Invoking Dogshowfunction with payload ${JSON.stringify(event.data || {})}`);

    const accounts = event.data.accounts;

    accounts.forEach(async (account) => {
        const response = await fetch('https://dog.ceo/api/breeds/image/random');
        const data = await response.json();
        const message = ` And their favorite dog is ${data.message}`

        const recordForUpdate = {
            type: 'Account',
            fields: {
              id: account.id,
              Description: `${account.Description} ${message}`
            }
          }
        context.org.dataApi.updateRecord(recordForUpdate);
    });
}
