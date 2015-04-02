Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33282 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbDBBJH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Apr 2015 21:09:07 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YdTd4-000VY2-Qr
	for linux-watchdog@vger.kernel.org; Thu, 02 Apr 2015 01:09:07 +0000
Message-ID: <551C96AA.2060906@roeck-us.net>
Date: Wed, 01 Apr 2015 18:08:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: James Hogan <james.hogan@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH V2 1/3] watchdog: imgpdc: Allow timeout to be set in device-tree
References: <1427910196-28568-1-git-send-email-abrestic@chromium.org> <20150401222218.GB13077@jhogan-linux.le.imgtec.org>
In-Reply-To: <20150401222218.GB13077@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/01/2015 03:22 PM, James Hogan wrote:
> Hi Andrew,
>
> On Wed, Apr 01, 2015 at 10:43:14AM -0700, Andrew Bresticker wrote:
>> Since the heartbeat is statically initialized to its default value,
>> watchdog_init_timeout() will never look in the device-tree for a
>> timeout-sec value.  Instead of statically initializing heartbeat,
>> fall back to the default timeout value if watchdog_init_timeout()
>> fails.
>
> Whoops. Sorry about that. I wasn't aware that a timeout-sec value was
> expected. It isn't mentioned in the DT binding documentation for this
> device :-(.
>
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>> Cc: James Hogan <james.hogan@imgtec.com>
>> ---
>> New for v2.
>> ---
>>   drivers/watchdog/imgpdc_wdt.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
>> index 0deaa4f..89b2abc 100644
>> --- a/drivers/watchdog/imgpdc_wdt.c
>> +++ b/drivers/watchdog/imgpdc_wdt.c
>> @@ -42,7 +42,7 @@
>>   #define PDC_WDT_MIN_TIMEOUT		1
>>   #define PDC_WDT_DEF_TIMEOUT		64
>>
>> -static int heartbeat = PDC_WDT_DEF_TIMEOUT;
>> +static int heartbeat;
>>   module_param(heartbeat, int, 0);
>>   MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds "
>>   	"(default=" __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
>> @@ -195,9 +195,9 @@ static int pdc_wdt_probe(struct platform_device *pdev)
>>
>>   	ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
>>   	if (ret < 0) {
>> -		pdc_wdt->wdt_dev.timeout = pdc_wdt->wdt_dev.max_timeout;
>> +		pdc_wdt->wdt_dev.timeout = PDC_WDT_DEF_TIMEOUT;
>
> The watchdog_init_timeout kerneldoc comment suggests that the old value
> should be the default timeout, i.e. that timeout should be set to
> PDC_WDT_DEF_TIMEOUT before calling watchdog_init_timeout, rather than
> whenever ret < 0.
>
> Indeed, if heartbeat is set to an invalid non-zero value,
> watchdog_init_timeout will still try and set timeout from DT, but also
> still returns -EINVAL regardless of whether that succeeds, and this
> would incorrectly override the timeout from DT with the hardcoded
> default.
>
>>   		dev_warn(&pdev->dev,
>> -			 "Initial timeout out of range! setting max timeout\n");
>> +			 "Initial timeout out of range! setting default timeout\n");
>
> It feels wrong for a presumably safe & normal situation (i.e. no default
> in DT, which arguably shouldn't contain policy anyway) to show a
> warning, but it can also show due to an invalid module parameter (or
> invalid DT property) which is most definitely justified.
>

Agreed. I would suggest to leave that part alone and set the default prior
to calling watchdog_init_timeout().

Guenter


> The caller can check (ret < 0 && heartbeat) to tell if heartbeat was
> invalid, but unfortunately it can't easily tell if the DT property is
> out of range rather than simply absent.
>
> Cheers
> James
>
>>   	}
>>
>>   	pdc_wdt_stop(&pdc_wdt->wdt_dev);
>> --
>> 2.2.0.rc0.207.ga3a616c
>>

