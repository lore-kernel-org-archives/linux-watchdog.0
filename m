Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45820 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387759AbeGKNwS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Jul 2018 09:52:18 -0400
Subject: Re: [RFC PATCH v3] watchdog: sp805: Add clock-frequency property
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
 <20180710213557.GC27827@roeck-us.net>
 <CABe79T4+S2vxx8RoNkEtY7ncaKGvXVf0n_yqN81gmtHnhgqg9A@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <3868f0c7-e45e-d3b4-5365-12a6a0646f6f@roeck-us.net>
Date: Wed, 11 Jul 2018 06:47:49 -0700
MIME-Version: 1.0
In-Reply-To: <CABe79T4+S2vxx8RoNkEtY7ncaKGvXVf0n_yqN81gmtHnhgqg9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/11/2018 06:22 AM, Srinath Mannam wrote:
> Hi Guenter,
> 
> Thank you very much for all the help with your feedback and review
> comments to complete the changes very fast.
> 
> About the documentation..
> I have gone through few similar patches available in the kernel are
> listed in the mail of previous version.
> No documentation available in Linux for the properties used in those
> patches also.

" No documentation available _in Linux_"

Emphasis mine. Yes, I noticed this as well. I was asking for a reference
to documentation _outside_ Linux. Sorry for not being more specific.

Guenter

> For example,
> 1: "src-clock-hz" property added in the part of ACPI support with the
> below patch.
> Patch details: commit 515da746983bc6382e380ba8b1ce9345a9550ffe
> Author: Naveen Kaje <nkaje@codeaurora.org>
> Date:   Tue Oct 11 10:27:56 2016 -0600
> 
>      i2c: qup: add ACPI support
> 2: "amd,dma-freq" property added in the part of ACPI support with the
> below patch
> commit 82a19035d000c8b4fd7d6f61b614f63dec75d389
> Author: Lendacky, Thomas <Thomas.Lendacky@amd.com>
> Date:   Fri Jan 16 12:47:16 2015 -0600
> 
>      amd-xgbe: Add ACPI support
> 
> Regards,
> Srinath.
> 
> 
> 
> 
> On Wed, Jul 11, 2018 at 3:05 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Tue, Jul 10, 2018 at 02:14:39PM +0530, Srinath Mannam wrote:
>>> When using ACPI node, binding clock devices are
>>> not available as device tree, So clock-frequency
>>> property given in _DSD object of ACPI device is
>>> used to calculate Watchdog rate.
>>>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>
>> I am ok with the patch itself. All that is missing now is a
>> reference to the _DSD property documentation. Is that published
>> somewhere or is it all wild-wild-west ?
>>
>> Thanks,
>> Guenter
>>
>>> ---
>>>   drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
>>>   1 file changed, 25 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>>> index 9849db0..a896b1c 100644
>>> --- a/drivers/watchdog/sp805_wdt.c
>>> +++ b/drivers/watchdog/sp805_wdt.c
>>> @@ -11,6 +11,7 @@
>>>    * warranty of any kind, whether express or implied.
>>>    */
>>>
>>> +#include <linux/acpi.h>
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
>>>        spinlock_t                      lock;
>>>        void __iomem                    *base;
>>>        struct clk                      *clk;
>>> +     u64                             rate;
>>>        struct amba_device              *adev;
>>>        unsigned int                    load_val;
>>>   };
>>> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>>>        struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>        u64 load, rate;
>>>
>>> -     rate = clk_get_rate(wdt->clk);
>>> +     rate = wdt->rate;
>>>
>>>        /*
>>>         * sp805 runs counter with given value twice, after the end of first
>>> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>>>   static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>>   {
>>>        struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>> -     u64 load, rate;
>>> -
>>> -     rate = clk_get_rate(wdt->clk);
>>> +     u64 load;
>>>
>>>        spin_lock(&wdt->lock);
>>>        load = readl_relaxed(wdt->base + WDTVALUE);
>>> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>>                load += wdt->load_val + 1;
>>>        spin_unlock(&wdt->lock);
>>>
>>> -     return div_u64(load, rate);
>>> +     return div_u64(load, wdt->rate);
>>>   }
>>>
>>>   static int
>>> @@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>>>        if (IS_ERR(wdt->base))
>>>                return PTR_ERR(wdt->base);
>>>
>>> -     wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> -     if (IS_ERR(wdt->clk)) {
>>> -             dev_warn(&adev->dev, "Clock not found\n");
>>> -             ret = PTR_ERR(wdt->clk);
>>> -             goto err;
>>> +     if (adev->dev.of_node) {
>>> +             wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> +             if (IS_ERR(wdt->clk)) {
>>> +                     dev_err(&adev->dev, "Clock not found\n");
>>> +                     return PTR_ERR(wdt->clk);
>>> +             }
>>> +             wdt->rate = clk_get_rate(wdt->clk);
>>> +     } else if (has_acpi_companion(&adev->dev)) {
>>> +             /*
>>> +              * When Driver probe with ACPI device, clock devices
>>> +              * are not available, so watchdog rate get from
>>> +              * clock-frequency property given in _DSD object.
>>> +              */
>>> +             device_property_read_u64(&adev->dev, "clock-frequency",
>>> +                                      &wdt->rate);
>>> +             if (!wdt->rate) {
>>> +                     dev_err(&adev->dev, "no clock-frequency property\n");
>>> +                     return -ENODEV;
>>> +             }
>>>        }
>>>
>>>        wdt->adev = adev;
>>> --
>>> 2.7.4
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

