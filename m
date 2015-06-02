Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <556DCC95.806@codeaurora.org>
References: <=fu.wei@linaro.org>
	<1433217907-928-1-git-send-email-fu.wei@linaro.org>
	<1433217907-928-6-git-send-email-fu.wei@linaro.org>
	<556DCC95.806@codeaurora.org>
Date: Wed, 3 Jun 2015 00:55:11 +0800
Message-ID: <CADyBb7sXiMNtrH+Eu1Qj00TPNLMMr5cCTPObzFmKnHLsbWH79Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Timur,

Thanks , feedback inline

On 2 June 2015 at 23:32, Timur Tabi <timur@codeaurora.org> wrote:
> On 06/01/2015 11:05 PM, fu.wei@linaro.org wrote:
>
>> +/*
>> + * help functions for accessing 32bit registers of SBSA Generic Watchdog
>> + */
>> +static void sbsa_gwdt_cf_write(unsigned int reg, u32 val,
>> +                              struct watchdog_device *wdd)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +       writel_relaxed(val, gwdt->control_base + reg);
>> +}
>> +
>> +static void sbsa_gwdt_rf_write(unsigned int reg, u32 val,
>> +                              struct watchdog_device *wdd)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +       writel_relaxed(val, gwdt->refresh_base + reg);
>> +}
>> +
>> +static u32 sbsa_gwdt_cf_read(unsigned int reg, struct watchdog_device
>> *wdd)
>> +{
>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>> +
>> +       return readl_relaxed(gwdt->control_base + reg);
>> +}
>
>
> I still think you should get rid of these functions and just call
> readl_relaxed() and writel_relaxed() every time, but I won't complain again
> if you keep them.

yes, that make sense, and will reduce the size of code, and I think
the code's readability will be OK too.
will try in my next patch,

>
>> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
>> +{
>> +       struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
>> +       struct watchdog_device *wdd = &gwdt->wdd;
>> +
>> +       if (wdd->pretimeout)
>> +               /* The pretimeout is valid, go panic */
>> +               panic("SBSA Watchdog pre-timeout");
>> +       else
>> +               /* We don't use pretimeout, trigger WS1 now*/
>> +               sbsa_gwdt_set_wcv(wdd, 0);
>
>
> I don't like this.

If so, what is your idea ,if pretimeout == 0?

the reason of using WCV as (timout - pretimeout): it can provide the
longer timeout period,
(1)If we use WOR, it can only provide 10s @ 400MHz(max).
as Guenter said earlier, the default timer out for most watchdog will
be 30s, so I think 10s limit will be a little short
(2)we can always program WCV just like ping.
(3)if a timeout arrives, WOR will be use, so use it as pretimeout, but
we still can make this pretimeout longer by programming WCV(I don't
think it's necessary)


> The triggering of the hardware reset should never depend
> on an interrupt being handled properly.

if this fail, system reset in 1S, because WOR == (1s)

> You should always program WCV
> correctly in advance.  This is especially true since pre-timeout will
> probably rarely be used.

always programming WCV is doable.  But I absolutely can not agree "
pre-timeout will probably rarely be used"
If so, SBSA watchdog is just a normal watchdog,  This use case just
makes this HW useless.
If so, go to use SP805.
you still don't see the importance of this warning and pretimeout to a
real server.

If the software of a real server goes wrong, then you just directly restart it ,
never try to sync/protect the current data, never try to figure out
what is wrong with it.
I don't think that is a good server software.

At least, I don't thinks " pre-timeout will probably rarely be used"
is a good idea for a server.
in another word, in a server ,pre-timeout should always be used.

> So what happens if the CPU is totally hung and

Again, system reset in 1S, because WOR == (1s).

> this interrupt handler is never called?  When will the timeout occur?

if this interrupt hardler is never called,  what I can see is "some
one is feeding the dog".
OK, in case, WS0 is triggered, but  this interrupt hardler isn't
called, then software really goes wrong.  Then , Again, Again system
reset in 1S, because WOR == (1s).

>
>> +static int sbsa_gwdt_probe(struct platform_device *pdev)
>> +{
>> +       u64 first_period_max = U64_MAX;
>> +       struct device *dev = &pdev->dev;
>> +       struct watchdog_device *wdd;
>> +       struct sbsa_gwdt *gwdt;
>> +       struct resource *res;
>> +       void *rf_base, *cf_base;
>> +       int ret, irq;
>> +       u32 status;
>> +
>> +       gwdt = devm_kzalloc(dev, sizeof(*gwdt), GFP_KERNEL);
>> +       if (!gwdt)
>> +               return -ENOMEM;
>> +       platform_set_drvdata(pdev, gwdt);
>
>
> You should probably do this *after* calling platform_get_irq_byname().

 it just dose (pdev->) dev->driver_data = gwdt
If we got gwdt, we can do that.

But maybe I miss something(or a rule of usage),  so please let know
why this has to be called  *after* calling platform_get_irq_byname().

>
>> +
>> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> "refresh");
>> +       rf_base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(rf_base))
>> +               return PTR_ERR(rf_base);
>> +
>> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> "control");
>> +       cf_base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(cf_base))
>> +               return PTR_ERR(cf_base);
>> +
>> +       irq = platform_get_irq_byname(pdev, "ws0");
>> +       if (irq < 0) {
>> +               dev_err(dev, "unable to get ws0 interrupt.\n");
>> +               return irq;
>> +       }
>> +
>> +       /*
>> +        * Get the frequency of system counter from the cp15 interface of
>> ARM
>> +        * Generic timer. We don't need to check it, because if it returns
>> "0",
>> +        * system would panic in very early stage.
>> +        */
>> +       gwdt->clk = arch_timer_get_cntfrq();
>> +       gwdt->refresh_base = rf_base;
>> +       gwdt->control_base = cf_base;
>> +
>> +       wdd = &gwdt->wdd;
>> +       wdd->parent = dev;
>> +       wdd->info = &sbsa_gwdt_info;
>> +       wdd->ops = &sbsa_gwdt_ops;
>> +       watchdog_set_drvdata(wdd, gwdt);
>> +       watchdog_set_nowayout(wdd, nowayout);
>> +
>> +       wdd->min_pretimeout = 0;
>> +       wdd->max_pretimeout = U32_MAX / gwdt->clk;
>> +       wdd->min_timeout = 1;
>> +       do_div(first_period_max, gwdt->clk);
>> +       wdd->max_timeout = first_period_max;
>> +
>> +       wdd->pretimeout = DEFAULT_PRETIMEOUT;
>> +       wdd->timeout = DEFAULT_TIMEOUT;
>> +       watchdog_init_timeouts(wdd, pretimeout, timeout, dev);
>> +
>> +       status = sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd);
>> +       if (status & SBSA_GWDT_WCS_WS1) {
>> +               dev_warn(dev, "System reset by WDT(WCV: %llx)\n",
>> +                        sbsa_gwdt_get_wcv(wdd));
>
>
> "System was previously reset via watchdog" is much clearer.

OK

>
>> +               wdd->bootstatus |= WDIOF_CARDRESET;
>> +       }
>> +       /* Check if watchdog is already enabled */
>> +       if (status & SBSA_GWDT_WCS_EN) {
>> +               dev_warn(dev, "already enabled!\n");
>
>
> "watchdog is already enabled".

I think I don't need to print "watchdog",   dev_warn(dev,  has help us on this.
If you do so , the message will be "watchdog: watchdog0: watchdog is
already enabled"

 > Never use exclamation marks in kernel
> messages.

that make sense , will delete it.

>
>> +               sbsa_gwdt_keepalive(wdd);
>> +       }
>> +
>> +       /* update pretimeout to WOR */
>> +       sbsa_gwdt_set_pretimeout(wdd, wdd->pretimeout);
>> +
>> +       ret = devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
>> +                              pdev->name, gwdt);
>> +       if (ret) {
>> +               dev_err(dev, "unable to request IRQ %d\n", irq);
>> +               return ret;
>> +       }
>> +
>> +       ret = watchdog_register_device(wdd);
>> +       if (ret)
>> +               return ret;
>> +
>> +       dev_info(dev, "Initialized with %ds timeout, %ds pretimeout @ %u
>> Hz\n",
>> +                wdd->timeout, wdd->pretimeout, gwdt->clk);
>
>
> if (wdd->pretimeout)
>         "watchdog initialized to %us timeout and %us pre-timeout at %u
> Hz\n", wdd->timeout, wdd->pretimeout, gwdt->clk
> else
>         "watchdog initialized to %us timeout at %u Hz\n", wdd->timeout,
> gwdt->clk
>
> I think it's unlikely that users will use pre-timeout, so your code should
> treat pre-timeout as a special case, not the normal usage.

I don't think so, that why you didn't use pretimeout in your driver.
Because you don't see the meaning of "pretimeout" to a  server.

>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
