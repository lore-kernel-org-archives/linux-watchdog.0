Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp3.mail.ru ([94.100.176.131]:48878 "EHLO fallback.mail.ru"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751156AbeFEEaW (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 5 Jun 2018 00:30:22 -0400
Received: from [10.161.22.24] (port=44544 helo=smtp54.i.mail.ru)
        by fallback21.m.smailru.net with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1fQ3bv-0005D8-DH
        for linux-watchdog@vger.kernel.org; Tue, 05 Jun 2018 07:30:19 +0300
Subject: Re: watchdog: orion_wdt: add wdt status init for handle_boot_enabled
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
References: <0334679d-12c5-00ba-e896-abbf5b6eaa01@inbox.ru>
 <20180604013818.GA306@roeck-us.net>
From: Maxim Kochetkov <fido_max@inbox.ru>
Message-ID: <9722abc0-c450-d209-f044-ee704cb34a6b@inbox.ru>
Date: Tue, 5 Jun 2018 07:29:57 +0300
MIME-Version: 1.0
In-Reply-To: <20180604013818.GA306@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--- linux-4.17/drivers/watchdog/orion_wdt.c.orig    2018-06-04 
07:54:05.176000000 +0300
+++ linux-4.17/drivers/watchdog/orion_wdt.c    2018-06-04 
08:00:13.156000000 +0300
@@ -581,6 +581,8 @@ static int orion_wdt_probe(struct platfo
       */
      if (!orion_wdt_enabled(&dev->wdt))
          orion_wdt_stop(&dev->wdt);
+    else
+        set_bit(WDOG_HW_RUNNING, &dev->wdt.status);

      /* Request the IRQ only after the watchdog is disabled */
      irq = platform_get_irq(pdev, 0);

04.06.2018 04:38, Guenter Roeck wrote:
> On Wed, May 30, 2018 at 07:59:12AM +0300, Maxim Kochetkov wrote:
>> This patch add init of wdt.status for CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED
>>
>> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> I can not get this patch to apply. Can you rebase to mainline and resend,
> or at least let us know what you used as base version ?
> 
> Thanks,
> Guenter
> 
>> ---
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --- a/drivers/watchdog/orion_wdt.c.orig	2018-04-19 09:54:12.000000000 +0300
>> +++ b/drivers/watchdog/orion_wdt.c	2018-05-29 15:00:29.560000000 +0300
>> @@ -581,6 +581,8 @@ static int orion_wdt_probe(struct platfo
>>    	 */
>>    	if (!orion_wdt_enabled(&dev->wdt))
>>    		orion_wdt_stop(&dev->wdt);
>> +	else
>> +		set_bit(WDOG_HW_RUNNING, &dev->wdt.status);
>>
>>    	/* Request the IRQ only after the watchdog is disabled */
>>    	irq = platform_get_irq(pdev, 0);
