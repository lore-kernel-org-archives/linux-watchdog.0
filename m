Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33236 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeGZGYJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 26 Jul 2018 02:24:09 -0400
Subject: Re: [PATCH] watchdog: sp805: Add clock-frequency property
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <1532335060-686-1-git-send-email-srinath.mannam@broadcom.com>
 <f6095ab0-5916-99c7-09eb-0bfde335bc38@roeck-us.net>
 <CABe79T5cDBwi2A-yYXfRcVMPYQdhpHqzsNFdgA_m2CuQNjZ6Kg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ca37de93-4079-4270-aa91-8411a07b168f@roeck-us.net>
Date: Wed, 25 Jul 2018 22:09:04 -0700
MIME-Version: 1.0
In-Reply-To: <CABe79T5cDBwi2A-yYXfRcVMPYQdhpHqzsNFdgA_m2CuQNjZ6Kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/25/2018 09:47 PM, Srinath Mannam wrote:
> Hi Guenter,
> 
> It was my mistake sorry for that. I thought to add as Rivewed-by your name..
> Many changes are made based on your review comments and suggestions.
> So, Can I add your name in Reviewed list?

You did that already below, and I am ok with that.

Guenter

> I will modify and send next patchset.
> 
> thank you.
> 
> Regards,
> Srinath.
> 
> On Thu, Jul 26, 2018 at 10:12 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 07/23/2018 01:37 AM, Srinath Mannam wrote:
>>>
>>> Use clock-frequency property given in _DSD object
>>> of ACPI device to calculate Watchdog rate as binding
>>> clock devices are not available as device tree.
>>>
>>> Note: There is no formal review process for _DSD
>>> properties
>>>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>
>>
>> I just noticed this. This is completely inappropriate. It is
>> the equivalent of forging a signature on a check.
>>
>> _Never_ add a Signed-off-by: statement for anyone but yourself.
>>
>> Guenter
>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>    drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
>>>    1 file changed, 25 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>>> index 9849db0..a896b1c 100644
>>> --- a/drivers/watchdog/sp805_wdt.c
>>> +++ b/drivers/watchdog/sp805_wdt.c
>>> @@ -11,6 +11,7 @@
>>>     * warranty of any kind, whether express or implied.
>>>     */
>>>    +#include <linux/acpi.h>
>>>    #include <linux/device.h>
>>>    #include <linux/resource.h>
>>>    #include <linux/amba/bus.h>
>>> @@ -22,6 +23,7 @@
>>>    #include <linux/math64.h>
>>>    #include <linux/module.h>
>>>    #include <linux/moduleparam.h>
>>> +#include <linux/of.h>
>>>    #include <linux/pm.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/spinlock.h>
>>> @@ -65,6 +67,7 @@ struct sp805_wdt {
>>>          spinlock_t                      lock;
>>>          void __iomem                    *base;
>>>          struct clk                      *clk;
>>> +       u64                             rate;
>>>          struct amba_device              *adev;
>>>          unsigned int                    load_val;
>>>    };
>>> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>>> unsigned int timeout)
>>>          struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>          u64 load, rate;
>>>    -     rate = clk_get_rate(wdt->clk);
>>> +       rate = wdt->rate;
>>>          /*
>>>           * sp805 runs counter with given value twice, after the end of
>>> first
>>> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>>> unsigned int timeout)
>>>    static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>>    {
>>>          struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>> -       u64 load, rate;
>>> -
>>> -       rate = clk_get_rate(wdt->clk);
>>> +       u64 load;
>>>          spin_lock(&wdt->lock);
>>>          load = readl_relaxed(wdt->base + WDTVALUE);
>>> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct
>>> watchdog_device *wdd)
>>>                  load += wdt->load_val + 1;
>>>          spin_unlock(&wdt->lock);
>>>    -     return div_u64(load, rate);
>>> +       return div_u64(load, wdt->rate);
>>>    }
>>>      static int
>>> @@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const
>>> struct amba_id *id)
>>>          if (IS_ERR(wdt->base))
>>>                  return PTR_ERR(wdt->base);
>>>    -     wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> -       if (IS_ERR(wdt->clk)) {
>>> -               dev_warn(&adev->dev, "Clock not found\n");
>>> -               ret = PTR_ERR(wdt->clk);
>>> -               goto err;
>>> +       if (adev->dev.of_node) {
>>> +               wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> +               if (IS_ERR(wdt->clk)) {
>>> +                       dev_err(&adev->dev, "Clock not found\n");
>>> +                       return PTR_ERR(wdt->clk);
>>> +               }
>>> +               wdt->rate = clk_get_rate(wdt->clk);
>>> +       } else if (has_acpi_companion(&adev->dev)) {
>>> +               /*
>>> +                * When Driver probe with ACPI device, clock devices
>>> +                * are not available, so watchdog rate get from
>>> +                * clock-frequency property given in _DSD object.
>>> +                */
>>> +               device_property_read_u64(&adev->dev, "clock-frequency",
>>> +                                        &wdt->rate);
>>> +               if (!wdt->rate) {
>>> +                       dev_err(&adev->dev, "no clock-frequency
>>> property\n");
>>> +                       return -ENODEV;
>>> +               }
>>>          }
>>>          wdt->adev = adev;
>>>
>>
> 

