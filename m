Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33375 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754234AbeGHSGH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 8 Jul 2018 14:06:07 -0400
Subject: Re: [RFC PATCH] watchdog: sp805: Add clock-frequency property
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1530760968-13104-1-git-send-email-srinath.mannam@broadcom.com>
 <f29c486a-2ac8-55e7-86ed-90e3cf71bcea@roeck-us.net>
 <CABe79T7wF461QA11BNkfBdtLtX5RpTHX3-WC7z0KtEPYKfzdOQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7cebc954-7118-ec5f-2f1c-d2e2291faed5@roeck-us.net>
Date: Sun, 8 Jul 2018 11:06:02 -0700
MIME-Version: 1.0
In-Reply-To: <CABe79T7wF461QA11BNkfBdtLtX5RpTHX3-WC7z0KtEPYKfzdOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/06/2018 01:18 AM, Srinath Mannam wrote:
> Hi Guenter,
> 
> Thank you very much for your feedback. Please find my comments.
> 
> On Thu, Jul 5, 2018 at 8:58 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 07/04/2018 08:22 PM, Srinath Mannam wrote:
>>>
>>> When using ACPI node, binding clock devices are
>>> not available as device tree, So clock-frequency
>>> property given in _DSD object of ACPI device is
>>> used to calculate Watchdog rate.
>>>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> ---
>>>    drivers/watchdog/sp805_wdt.c | 29 ++++++++++++++++++++++++-----
>>>    1 file changed, 24 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>>> index 9849db0..d830dbc 100644
>>> --- a/drivers/watchdog/sp805_wdt.c
>>> +++ b/drivers/watchdog/sp805_wdt.c
>>> @@ -22,6 +22,7 @@
>>>    #include <linux/math64.h>
>>>    #include <linux/module.h>
>>>    #include <linux/moduleparam.h>
>>> +#include <linux/of.h>
>>>    #include <linux/pm.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/spinlock.h>
>>> @@ -65,6 +66,7 @@ struct sp805_wdt {
>>>          spinlock_t                      lock;
>>>          void __iomem                    *base;
>>>          struct clk                      *clk;
>>> +       u64                             rate;
>>>          struct amba_device              *adev;
>>>          unsigned int                    load_val;
>>>    };
>>> @@ -80,7 +82,10 @@ static int wdt_setload(struct watchdog_device *wdd,
>>> unsigned int timeout)
>>>          struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>          u64 load, rate;
>>>    -     rate = clk_get_rate(wdt->clk);
>>> +       if (wdt->rate)
>>> +               rate = wdt->rate;
>>> +       else
>>> +               rate = clk_get_rate(wdt->clk);
>>
>>
>> No. Get the rate once during probe and store it in wdt->rate.
> clk_get_rate function was called multiple places in the driver.
> so that we thought, there may be cases where clock rate can change at run-time.
> That is the reason, I keep clk_get_rate function.

This is not an argument. A changing clock rate without notifying the driver
would be fatal for a watchdog driver, since it would affect the timeout and
- if the clock rate is increased - result in arbitrary reboots. If that can
happen with the clock used by this watchdog, some notification would have to
be implemented to let the driver know.

>>
>>>          /*
>>>           * sp805 runs counter with given value twice, after the end of
>>> first
>>> @@ -108,7 +113,10 @@ static unsigned int wdt_timeleft(struct
>>> watchdog_device *wdd)
>>>          struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>          u64 load, rate;
>>>    -     rate = clk_get_rate(wdt->clk);
>>> +       if (wdt->rate)
>>> +               rate = wdt->rate;
>>> +       else
>>> +               rate = clk_get_rate(wdt->clk);
>>
>>
>> Same here.
>>
>>>          spin_lock(&wdt->lock);
>>>          load = readl_relaxed(wdt->base + WDTVALUE);
>>> @@ -230,11 +238,22 @@ sp805_wdt_probe(struct amba_device *adev, const
>>> struct amba_id *id)
>>>          wdt->clk = devm_clk_get(&adev->dev, NULL);
>>>          if (IS_ERR(wdt->clk)) {
>>> -               dev_warn(&adev->dev, "Clock not found\n");
>>> -               ret = PTR_ERR(wdt->clk);
>>> -               goto err;
>>> +               dev_warn(&adev->dev, "Clock device not found\n");
>>
>>
>> "Clock _device_" ? Why this change ? And why retain that warning
>> unconditionally ?
> I mean, peripheral may have clock input but clock device node is not
> available to this driver.
> So I keep the warning.

There is now a warning even though everything is fine, if the clock rate
is provided with the "clock-frequency" property instead of the documented
properties. That is unacceptable. I don't want to get flooded with messages
from people asking what this message is about.

> I thought to handle this better, divide this part of code into two
> parts based on device tree and ACPI.
> But this driver implementation is independent of device tree and ACPI calls.
> To get device-tree properties watch-dog framework APIs are called ex: timeout.
> Can I add ACPI and device tree node availability check to get clock
> device and clock-frequency properties. Please advice.

Sorry, I fail to parse what you are trying to say.

Lets summarize: You are introducing a new means for this driver to obtain
the clock rate used by the watchdog. This is quite independent of the
instantiation method, since it works for both ACPI and non-ACPI systems.
This change needs to be documented and approved by devicetree maintainers.
Its implementation must then accept all valid methods to obtain the clock
rate without warning or error message.

Thanks,
Guenter

>>
>>> +               wdt->clk = NULL;
>>> +               /*
>>> +                * When Driver probe with ACPI device, clock devices
>>> +                * are not available, so watchdog rate get from
>>> +                * clock-frequency property given in _DSD object.
>>> +                */
>>> +               device_property_read_u64(&adev->dev, "clock-frequency",
>>> +                                        &wdt->rate);
>>> +               if (!wdt->rate) {
>>> +                       ret = -ENODEV;
>>
>>
>> This unconditionally overrides the original error.
> I accept, I will change.
>>
>>> +                       goto err;
>>> +               }
>>>          }
>>>    +
>>
>>
>> No whitespace changes, please.
> I will remove.
>>
>> Does that mean that ACPI doesn't support the clock subsystem and that each
>> driver
>> supporting ACPI must do this ? That would be messy. Also, the above does not
>> check
>> if the device was probed through ACPI. It just tries to find an undocumented
>> "clock-frequency" property which is quite different and would apply to
>> (probably mis-configured) devicetree files as well.
>>
>> Either case, I would rather have this addressed through the clock subsystem.
>> Otherwise, someone with subject knowledge will have to confirm that this is
>> the
>> appropriate solution. If so, the new property will have to be documented as
>> an
>> alternative to clock specifiers and accepted by devicetree maintainers.
>>
> I checked with ACPI maintainers, ACPI does not support common-clock
> framework and also no plan.
> AMBA framework also request for "apb_pclk" clock node to enable pclk.
> But ACPI does not do the same.
> So in device-tree use case, both apb_pclk and wdt clock nodes are
> required properties, so passing
> clock-frequency alone can not be alternative.
> Because ACPI does not support clk node method, I came up with
> alternate fixed-clock property clock-frequency.
> clock-frequency is only specific to ACPI case, so we can't add in
> binding document.
> I will add device tree and ACPI specific check to read clock nodes and
> clock-frequency properties separately.
> 
> If you are fine with this I will send the next patch with modifications.
> 
>> Guenter
>>
>>>          wdt->adev = adev;
>>>          wdt->wdd.info = &wdt_info;
>>>          wdt->wdd.ops = &wdt_ops;
>>>
>>
> Thank you,
> 
> Regards,
> Srinath.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

