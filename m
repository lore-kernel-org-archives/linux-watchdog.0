Return-path: <slemieux.tyco@gmail.com>
Message-ID: <1495125563.14469.5.camel@gmail.com>
Subject: Re: [PATCH v2] watchdog: gpio: Add "keep-armed-on-close" feature
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Date: Thu, 18 May 2017 12:39:23 -0400
In-Reply-To: <9edc91e9-2878-eab5-157f-8b74bd6ed267@roeck-us.net>
References: <20170314141111.24888-1-slemieux.tyco@gmail.com>
	 <db6e6689-68e5-753e-c501-bb3e74407b69@roeck-us.net>
	 <1490885209.26136.14.camel@gmail.com> <1495112471.12459.4.camel@gmail.com>
	 <9edc91e9-2878-eab5-157f-8b74bd6ed267@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, 2017-05-18 at 06:50 -0700, Guenter Roeck wrote:
> On 05/18/2017 06:01 AM, Sylvain Lemieux wrote:
> > On Thu, 2017-03-30 at 10:46 -0400, Sylvain Lemieux wrote:
> >> Hi,
> >>
> >> On Thu, 2017-03-30 at 06:11 -0700, Guenter Roeck wrote:
> >>> On 03/14/2017 07:11 AM, Sylvain Lemieux wrote:
> >>>> From: Sylvain Lemieux <slemieux@tycoint.com>
> >>>>
> >>>> There is a need to allow a grace period after the watchdog software
> >>>> client has closed. It could be used for syncing the filesystem or
> >>>> allow graceful termination while still providing a hardware reset
> >>>> in case the system has hung.
> >>>>
> >>>> The "always-running" configuration from device-tree does not provide
> >>>> this since it will automatically keep the hardware watchdog alive as
> >>>> soon as the software client closes (i.e. keep toggling the GPIO line
> >>>> regardless of the state of the soft part of the watchdog).
> >>>>
> >>>> The "keep-armed-on-close" member in the GPIO watchdog implementation
> >>>> indicates if an expired timeout should cause a reset.
> >>>>
> >>>> This patch add a new "keep-armed-on-close" device-tree configuration
> >>>> that will keep the watchdog "armed" until the next timeout period after
> >>>> a close. During this period, the hardware watchdog is kept alive.
> >>>> A software watchdog client that wants to provide a grace period before
> >>>> a hard reset can set the timeout before properly closing.
> >>>>
> >>>
> >>> The description doesn't match what the code actually does, at least from
> >>> an infrastructure perspective. The infrastructure would just keep it running.
> >>>
> >> I will need to send a new version with an updated description;
> >>
> > I will submit v3 later today or tomorrow.
> > 
> >> I did not update the description after this patch was rebased on-top
> >> of the "watchdog: gpio: keepalives" patch.
> >>
> >>> What you are really asking for is something the infrastructure should possibly
> >>> do by itself automatically: To keep pinging a HW watchdog after close until
> >>> the configured (software) timeout period expires. This would be in line with
> >>> expectations.
> >>>
> > Do you want me to work on a generic version for this option?
> > 
> 
> I am not sure I understand the value of the current version (as implemented)
> in the first place. It seems to be similar to "always-running", with the exception
> that it doesn't start the watchdog immediately when loading the module. That means
> it protects the system against hard lockups, but only if the watchdog was opened
> at least once. That just seems odd, and you'll have to explain the benefit over
> "always-running", and why it would make sense to have such a selective protection.
> 
The only difference between this implementation and the "always-running"
is the way the close operation is handle; when "keep_armed_on_close"
option is selected, the watchdog will generate a timeout at the end
of the grace period.

Regarding the loading of the module, we have a separate patch, that
is apply to the GPIO watchdog to perform an early start (same way as
"always-running"); this is not part of this change, as this change
only modify the behavior of the driver on close.

> Note that devicetree property changes need to be Acked by DT maintainers.
> 
I will cc them on the new patch.

> Having said that, if what you want is what the description says, not what is
> implemented, I'll be happy to accept a patch to change the infrastructure
> accordingly.
> 
I will look into modifying the infrastructure to add the support
for "keep_running_on_close"; this will replace this patch.

I will need to submit my other patch for this driver to allow
an "early start" of the watchdog
(same as what the "always-running" is doing).

Regards,
Sylvain
> Thanks,
> Guenter
> 
> > Sylvain
> > 
> >>
> > [...]
> >>
> >> Sylvain
> >>>
> >>> Guenter
> >>>
> >>>> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> >>>> ---
> >>>> * This patch depend on the:
> >>>>    "watchdog: gpio: Convert to use infrastructure triggered keepalives";
> >>>>    ref. https://lkml.org/lkml/2016/2/28/239 (version 8)
> >>>>
> >>>> Changes from v1 to v2:
> >>>> * Rebased on-top of the "watchdog: gpio: keepalives" patch.
> >>>>    - Updated the management of the "WDOG_HW_RUNNING" flag.
> >>>> * Tested with v4.11-rc1.
> >>>>
> >>>>   Documentation/devicetree/bindings/watchdog/gpio-wdt.txt |  3 +++
> >>>>   drivers/watchdog/gpio_wdt.c                             | 10 ++++++++++
> >>>>   2 files changed, 13 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> >>>> index 83d28146e39b..48db076771b2 100644
> >>>> --- a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> >>>> +++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> >>>> @@ -17,6 +17,9 @@ Optional Properties:
> >>>>   - always-running: If the watchdog timer cannot be disabled, add this flag to
> >>>>     have the driver keep toggling the signal without a client. It will only cease
> >>>>     to toggle the signal when the device is open and the timeout elapsed.
> >>>> +- keep-armed-on-close: if the watchdog timer need to keep toggling the signal
> >>>> +  when close, until the timeout elapsed, add this flag to have the driver
> >>>> +  keep toggling the signal, until the timeout elapsed.
> >>>>   - timeout-sec: Contains the watchdog timeout in seconds.
> >>>>   - start-at-init: Start kicking watchdog as soon as driver is loaded.
> >>>>
> >>>> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> >>>> index 7b46d224cb56..2f4799bee9bd 100644
> >>>> --- a/drivers/watchdog/gpio_wdt.c
> >>>> +++ b/drivers/watchdog/gpio_wdt.c
> >>>> @@ -29,6 +29,7 @@ struct gpio_wdt_priv {
> >>>>   	bool			active_low;
> >>>>   	bool			state;
> >>>>   	bool			always_running;
> >>>> +	bool			keep_armed_on_close;
> >>>>   	unsigned int		hw_algo;
> >>>>   	struct watchdog_device	wdd;
> >>>>   };
> >>>> @@ -78,6 +79,13 @@ static int gpio_wdt_stop(struct watchdog_device *wdd)
> >>>>   {
> >>>>   	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
> >>>>
> >>>> +	if(priv->keep_armed_on_close) {
> >>>> +		/* Keep the driver running on close. */
> >>>> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> >>>> +
> >>>> +		return 0;
> >>>> +	}
> >>>> +
> >>>>   	if (!priv->always_running) {
> >>>>   		gpio_wdt_disable(priv);
> >>>>   		clear_bit(WDOG_HW_RUNNING, &wdd->status);
> >>>> @@ -148,6 +156,8 @@ static int gpio_wdt_probe(struct platform_device *pdev)
> >>>>
> >>>>   	priv->always_running = of_property_read_bool(pdev->dev.of_node,
> >>>>   						     "always-running");
> >>>> +	priv->keep_armed_on_close = of_property_read_bool(pdev->dev.of_node,
> >>>> +						 "keep-armed-on-close");
> >>>>
> >>>>   	watchdog_set_drvdata(&priv->wdd, priv);
> >>>>
> >>>>
> >>>
> >>
> >>
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
