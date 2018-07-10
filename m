Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33439 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeGJIBd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jul 2018 04:01:33 -0400
Received: by mail-oi0-f68.google.com with SMTP id c6-v6so40970147oiy.0
        for <linux-watchdog@vger.kernel.org>; Tue, 10 Jul 2018 01:01:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABe79T4qj6SaZJzTn_ZY7XfGkj_z6JJ57+WfMm3zGE7XLbT4Lg@mail.gmail.com>
References: <1531131569-13727-1-git-send-email-srinath.mannam@broadcom.com>
 <055f7c8a-c3c9-af3a-d762-a26329270e4d@roeck-us.net> <CABe79T4qj6SaZJzTn_ZY7XfGkj_z6JJ57+WfMm3zGE7XLbT4Lg@mail.gmail.com>
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Tue, 10 Jul 2018 13:31:31 +0530
Message-ID: <CABe79T4DumpWbtXj_g-zGdE59JmsdJNtHVnQpbvXKM92t1FJhg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] watchdog: sp805: Add clock-frequency property
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

I missed your comment about "Clearing wdt->clk is useless." I will
remove that line.

Regards,
Srinath.

On Tue, Jul 10, 2018 at 1:27 PM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> Hi Guenter,
>
> Thank you for your feedback. Please find my answers in lined.
>
> On Mon, Jul 9, 2018 at 7:15 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 07/09/2018 03:19 AM, Srinath Mannam wrote:
>>>
>>> When using ACPI node, binding clock devices are
>>> not available as device tree, So clock-frequency
>>> property given in _DSD object of ACPI device is
>>> used to calculate Watchdog rate.
>>>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> ---
>>>   drivers/watchdog/sp805_wdt.c | 34 ++++++++++++++++++++++++++--------
>>>   1 file changed, 26 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>>> index 9849db0..ad5ed64 100644
>>> --- a/drivers/watchdog/sp805_wdt.c
>>> +++ b/drivers/watchdog/sp805_wdt.c
>>> @@ -11,6 +11,7 @@
>>>    * warranty of any kind, whether express or implied.
>>>    */
>>>   +#include <linux/acpi.h>
>>>   #include <linux/device.h>
>>>   #include <linux/resource.h>
>>>   #include <linux/amba/bus.h>
>>> @@ -22,6 +23,7 @@
>>>   #include <linux/math64.h>
>>>   #include <linux/module.h>
>>>   #include <linux/moduleparam.h>
>>> +#include <linux/of.h>
>>>   #include <linux/pm.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/spinlock.h>
>>> @@ -65,6 +67,7 @@ struct sp805_wdt {
>>>         spinlock_t                      lock;
>>>         void __iomem                    *base;
>>>         struct clk                      *clk;
>>> +       u64                             rate;
>>>         struct amba_device              *adev;
>>>         unsigned int                    load_val;
>>>   };
>>> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>>> unsigned int timeout)
>>>         struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>         u64 load, rate;
>>>   -     rate = clk_get_rate(wdt->clk);
>>> +       rate = wdt->rate;
>>>         /*
>>>          * sp805 runs counter with given value twice, after the end of
>>> first
>>> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>>> unsigned int timeout)
>>>   static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>>   {
>>>         struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>> -       u64 load, rate;
>>> -
>>> -       rate = clk_get_rate(wdt->clk);
>>> +       u64 load;
>>>         spin_lock(&wdt->lock);
>>>         load = readl_relaxed(wdt->base + WDTVALUE);
>>> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct
>>> watchdog_device *wdd)
>>>                 load += wdt->load_val + 1;
>>>         spin_unlock(&wdt->lock);
>>>   -     return div_u64(load, rate);
>>> +       return div_u64(load, wdt->rate);
>>>   }
>>>     static int
>>> @@ -228,10 +229,27 @@ sp805_wdt_probe(struct amba_device *adev, const
>>> struct amba_id *id)
>>>         if (IS_ERR(wdt->base))
>>>                 return PTR_ERR(wdt->base);
>>>   -     wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> -       if (IS_ERR(wdt->clk)) {
>>> +       if (adev->dev.of_node) {
>>> +               wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> +               if (IS_ERR(wdt->clk)) {
>>> +                       ret = PTR_ERR(wdt->clk);
>>> +                       wdt->clk = NULL;
>>
>>
>> Clearing wdt->clk is useless.
>
> If not, clk_prepare_enable and clk_disable_unprepare functions calls
> made in this driver will crash.
Sorry I missed your point. I will remove that.
>
>>
>>> +               } else
>>> +                       wdt->rate = clk_get_rate(wdt->clk);
>>
>>
>> The else branch should be in { } as well per coding style.
> I will add the change.
>>
>>> +       } else if (has_acpi_companion(&adev->dev)) {
>>> +               /*
>>> +                * When Driver probe with ACPI device, clock devices
>>> +                * are not available, so watchdog rate get from
>>> +                * clock-frequency property given in _DSD object.
>>> +                */
>>> +               device_property_read_u64(&adev->dev, "clock-frequency",
>>> +                               &wdt->rate);
>>
>>
>> Continuation line alignment is off.
> I missed it, Thank you, I will make the change.
>>
>> Still not documented. Maybe that is common for ACPI devices nowadays.
>> If so, I'll need at least a pointer to a document or something declaring
>> that ACPI devices do not use well documented properties, and a confirmation
>> that using such properties is acceptable in the Linux kernel.
>>
> patches listed below has same approach to add ACPI support.
> ex:
> 1. commit 515da746983bc6382e380ba8b1ce9345a9550ffe
> Author: Naveen Kaje <nkaje@codeaurora.org>
> Date:   Tue Oct 11 10:27:56 2016 -0600
>
>     i2c: qup: add ACPI support
>
> 2. commit 82a19035d000c8b4fd7d6f61b614f63dec75d389
> Author: Lendacky, Thomas <Thomas.Lendacky@amd.com>
> Date:   Fri Jan 16 12:47:16 2015 -0600
>
>     amd-xgbe: Add ACPI support
>
>>> +               if (!wdt->rate)
>>> +                       ret = -ENODEV;
>>> +       }
>>> +
>>> +       if (ret) {
>>>                 dev_warn(&adev->dev, "Clock not found\n");
>>> -               ret = PTR_ERR(wdt->clk);
>>>                 goto err;
>>>         }
>>
>>
>> Please move the error handling to where the error occurs. While doing that,
>> please change the message to dev_err() - this is an error, not a warning -
>> and change the second error message to match the error (it did not find
>> the property).
>>
>> Also, return directly - the goto just generates another error message
>> which is ridiculous.
> Thank you, I will add the changes.
>>
>> Thanks,
>> Guenter
>
> Regards,
> Srinath.
