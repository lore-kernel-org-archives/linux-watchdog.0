Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751471AbdF0CRh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Jun 2017 22:17:37 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5R2EQoY026753
        for <linux-watchdog@vger.kernel.org>; Mon, 26 Jun 2017 22:17:37 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bb563v35g-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Mon, 26 Jun 2017 22:17:36 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-watchdog@vger.kernel.org> from <cbostic@linux.vnet.ibm.com>;
        Mon, 26 Jun 2017 22:17:35 -0400
Subject: Re: [2/2] drivers/watchdog: ASPEED reference dev tree properties for
 config
To: Guenter Roeck <linux@roeck-us.net>
References: <20170613203818.17399-3-cbostic@linux.vnet.ibm.com>
 <20170624221747.GA10038@roeck-us.net>
Cc: wim@iguana.be, joel@jms.id.au, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, andrew@aj.id.au
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Date: Mon, 26 Jun 2017 21:17:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170624221747.GA10038@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <222152c4-a014-703c-29a0-a2a9ffdec5e9@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 6/24/17 5:17 PM, Guenter Roeck wrote:
> On Tue, Jun 13, 2017 at 03:38:18PM -0500, Christopher Bostic wrote:
>> Reference the system device tree when configuring the watchdog.
>> Configure for external signal generation if optional attribute
>> 'external-signal' is present in device tree.  Configure for
>> reset system after timeout if the optional attribute
>> 'no-system-reset' is not present.  Disabling system reset may be
>> required in situations where one of the other watchdogs in the
>> systems is responsible for this.
>>
>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>> ---
>>   drivers/watchdog/aspeed_wdt.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>> index 1c65258..9deb4be 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>> +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -140,6 +140,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>   {
>>   	struct aspeed_wdt *wdt;
>>   	struct resource *res;
>> +	struct device_node *np;
>>   	int ret;
>>   
>>   	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>> @@ -170,8 +171,16 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>   	 * the SOC and not the full chip
>>   	 */
>>   	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
>> -		WDT_CTRL_1MHZ_CLK |
>> -		WDT_CTRL_RESET_SYSTEM;
>> +		WDT_CTRL_1MHZ_CLK;
>> +
>> +	np = pdev->dev.of_node;
>> +	if (np && !of_get_property(np, "no-system-reset", NULL))
>> +		wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
>> +
> Please use of_property_read_bool(). Also, checking np for NULL is unnecessary
> since the called function does that. Note that the above code as written is
> wrong - if np is NULL, WDT_CTRL_RESET_SYSTEM will no longer be set.

Will make the suggested changes.

Thanks
-Chris

> The new properties should probably start with "aspeed," but I'll leave that
> up to DT maintainers to decide.
>
>> +	if (np && of_get_property(np, "external-signal", NULL))
>> +		wdt->ctrl |= WDT_CTRL_WDT_EXT;
>> +
>> +	writel(wdt->ctrl, wdt->base + WDT_CTRL);
>>   
>>   	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
>>   		aspeed_wdt_start(&wdt->wdd);

