Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45153 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbbKCOqO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 09:46:14 -0500
Subject: Re: [RFC PATCH 02/13] watchdog: bcm47xx_wdt: use core restart handler
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446514586-31455-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <56381B3B.70202@roeck-us.net> <20151103142112.GA26902@ketchup.mtl.sfl>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5638C8B2.8020505@roeck-us.net>
Date: Tue, 3 Nov 2015 06:46:10 -0800
MIME-Version: 1.0
In-Reply-To: <20151103142112.GA26902@ketchup.mtl.sfl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/03/2015 06:21 AM, Vivien Didelot wrote:
> Hi Guenter,
>
> On Nov. Monday 02 (45) 06:26 PM, Guenter Roeck wrote:
>> On 11/02/2015 05:36 PM, Damien Riegel wrote:
>>> Get rid of the custom restart handler by using the one provided by the
>>> watchdog core.
>>>
>>> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
>>> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
>
> <snip>
>
>>> @@ -221,23 +222,15 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
>>>   	if (ret)
>>>   		goto err_timer;
>>>
>>> -	wdt->restart_handler.notifier_call = &bcm47xx_wdt_restart;
>>> -	wdt->restart_handler.priority = 64;
>>> -	ret = register_restart_handler(&wdt->restart_handler);
>>> -	if (ret)
>>> -		goto err_notifier;
>>> -
>>>   	ret = watchdog_register_device(&wdt->wdd);
>>>   	if (ret)
>>> -		goto err_handler;
>>> +		goto err_notifier;
>>
>> 		goto err_handler;
>
> I think we want err_notifier here, since it is the label which
> unregisters the reboot notifier, and err_handler gets removed.
>
Yes, you are right. Sorry for the noise.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>>
>>>
>>>   	dev_info(&pdev->dev, "BCM47xx Watchdog Timer enabled (%d seconds%s%s)\n",
>>>   		timeout, nowayout ? ", nowayout" : "",
>>>   		soft ? ", Software Timer" : "");
>>>   	return 0;
>>>
>>> -err_handler:
>>> -	unregister_restart_handler(&wdt->restart_handler);
>>>   err_notifier:
>>>   	unregister_reboot_notifier(&wdt->notifier);
>>>   err_timer:
>
> Thanks,
> -v
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

