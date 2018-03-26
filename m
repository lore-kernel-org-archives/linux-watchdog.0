Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751677AbeCZWIV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Mar 2018 18:08:21 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2QM4np4048225
        for <linux-watchdog@vger.kernel.org>; Mon, 26 Mar 2018 18:08:21 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gy6rv6908-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Mon, 26 Mar 2018 18:08:21 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Mon, 26 Mar 2018 18:08:20 -0400
Subject: Re: [PATCH] aspeed: watchdog: Add status function
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        joel@jms.id.au, openbmc@lists.ozlabs.org
References: <1522099028-20347-1-git-send-email-eajames@linux.vnet.ibm.com>
 <eeaa2de8-937d-4371-1b32-931b3221f6ce@roeck-us.net>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Mon, 26 Mar 2018 17:08:16 -0500
MIME-Version: 1.0
In-Reply-To: <eeaa2de8-937d-4371-1b32-931b3221f6ce@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <e3870f44-fa97-bd2d-8871-732cf68dc147@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 03/26/2018 05:00 PM, Guenter Roeck wrote:
> On 03/26/2018 02:17 PM, Eddie James wrote:
>> Populate the status watchdog operation to return the "timeout status"
>> register of the ASPEED watchdog.
>>
>> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
>> ---
>>   drivers/watchdog/aspeed_wdt.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/watchdog/aspeed_wdt.c 
>> b/drivers/watchdog/aspeed_wdt.c
>> index a5b8eb2..d6dd5c9 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>> +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -55,6 +55,7 @@ struct aspeed_wdt_config {
>>   #define   WDT_CTRL_WDT_INTR        BIT(2)
>>   #define   WDT_CTRL_RESET_SYSTEM        BIT(1)
>>   #define   WDT_CTRL_ENABLE        BIT(0)
>> +#define WDT_TIMEOUT_STATUS    0x10
>>     /*
>>    * WDT_RESET_WIDTH controls the characteristics of the external 
>> pulse (if
>> @@ -138,6 +139,13 @@ static int aspeed_wdt_ping(struct 
>> watchdog_device *wdd)
>>       return 0;
>>   }
>>   +static unsigned int aspeed_wdt_status(struct watchdog_device *wdd)
>> +{
>> +    struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
>> +
>> +    return readl(wdt->base + WDT_TIMEOUT_STATUS);
>> +}
>
> Does the register report WDIOF_* status flags/bits as defined in the 
> API ?
> This seems more than unlikely.

Ah, I see I'm misusing the API. It does not... I will rework.

Thanks,
Eddie

>
> Guenter
>
>> +
>>   static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
>>                     unsigned int timeout)
>>   {
>> @@ -171,6 +179,7 @@ static int aspeed_wdt_restart(struct 
>> watchdog_device *wdd,
>>       .start        = aspeed_wdt_start,
>>       .stop        = aspeed_wdt_stop,
>>       .ping        = aspeed_wdt_ping,
>> +    .status        = aspeed_wdt_status,
>>       .set_timeout    = aspeed_wdt_set_timeout,
>>       .restart    = aspeed_wdt_restart,
>>       .owner        = THIS_MODULE,
>>
>

