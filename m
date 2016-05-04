Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39513 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756337AbcEDCBi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 May 2016 22:01:38 -0400
Subject: Re: [PATCH] watchdog: qcom: Report reboot reason
To: Grant Grundler <grundler@chromium.org>
References: <1459816666-87185-1-git-send-email-groeck@chromium.org>
 <CANEJEGupo0pLKUEcbouz4exwcYX__7NPExNYr123=m4mq17x4Q@mail.gmail.com>
 <CANEJEGvHdD1VevOrZtTPe+O7gw7Fzb8H30mmvvRxO75mFxSgMA@mail.gmail.com>
Cc: Guenter Roeck <groeck@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <572957F4.1030406@roeck-us.net>
Date: Tue, 3 May 2016 19:01:24 -0700
MIME-Version: 1.0
In-Reply-To: <CANEJEGvHdD1VevOrZtTPe+O7gw7Fzb8H30mmvvRxO75mFxSgMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/03/2016 06:36 PM, Grant Grundler wrote:
> Ping? Did this change get accepted?
>

Hi Grant,

Should be. It is in my watchdog-next branch. I plan to send
a pull request to Wim early next week.

Guenter

> cheers,
> grant
>
> On Tue, Apr 5, 2016 at 12:07 PM, Grant Grundler <grundler@chromium.org> wrote:
>> On Mon, Apr 4, 2016 at 5:37 PM, Guenter Roeck <groeck@chromium.org> wrote:
>>> The Qualcom watchdog timer block reports if the system was reset by the
>>> watchdog. Pass the information to user space.
>>>
>>> Cc: Grant Grundler <grundler@chromium.org>
>>> Signed-off-by: Guenter Roeck <groeck@chromium.org>
>>
>> Reviewed-by: Grant Grundler <grundler@chromium.org>
>> Tested-by: Grant Grundler <grundler@chromium.org>
>>
>> Thanks Guenter! :)
>>
>> FTR, this landed in the chromeos-3.14 (and chromeos-3.18 shortly)
>> branches and will be included in a future update for TP-Link Onhub
>> devices.
>>
>> cheers,
>> grant
>>
>>> ---
>>>   drivers/watchdog/qcom-wdt.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
>>> index 20563cc..a043fa4 100644
>>> --- a/drivers/watchdog/qcom-wdt.c
>>> +++ b/drivers/watchdog/qcom-wdt.c
>>> @@ -21,6 +21,7 @@
>>>
>>>   #define WDT_RST                0x38
>>>   #define WDT_EN         0x40
>>> +#define WDT_STS                0x44
>>>   #define WDT_BITE_TIME  0x5C
>>>
>>>   struct qcom_wdt {
>>> @@ -108,7 +109,8 @@ static const struct watchdog_ops qcom_wdt_ops = {
>>>   static const struct watchdog_info qcom_wdt_info = {
>>>          .options        = WDIOF_KEEPALIVEPING
>>>                          | WDIOF_MAGICCLOSE
>>> -                       | WDIOF_SETTIMEOUT,
>>> +                       | WDIOF_SETTIMEOUT
>>> +                       | WDIOF_CARDRESET,
>>>          .identity       = KBUILD_MODNAME,
>>>   };
>>>
>>> @@ -171,6 +173,9 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>>>          wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
>>>          wdt->wdd.parent = &pdev->dev;
>>>
>>> +       if (readl(wdt->base + WDT_STS) & 1)
>>> +               wdt->wdd.bootstatus = WDIOF_CARDRESET;
>>> +
>>>          /*
>>>           * If 'timeout-sec' unspecified in devicetree, assume a 30 second
>>>           * default, unless the max timeout is less than 30 seconds, then use
>>> --
>>> 2.8.0.rc3.226.g39d4020
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

