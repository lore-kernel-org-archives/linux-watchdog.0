Return-path: <narmstrong@baylibre.com>
Subject: Re: [RFC PATCH 1/3] watchdog: Add Meson GXBB Watchdog Driver
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
References: <1464249112-13658-1-git-send-email-narmstrong@baylibre.com>
 <1464249112-13658-2-git-send-email-narmstrong@baylibre.com>
 <57470026.3000501@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <57480470.4000708@baylibre.com>
Date: Fri, 27 May 2016 10:25:20 +0200
MIME-Version: 1.0
In-Reply-To: <57470026.3000501@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/26/2016 03:54 PM, Guenter Roeck wrote:
> On 05/26/2016 12:51 AM, Neil Armstrong wrote:
>> Add watchdog specific driver for Amlogic Meson GXBB SoC.
>>
> 
> Wondering - why RFC ?

For these precious comments !
Thanks Guenter.

> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>   drivers/watchdog/Makefile         |   1 +
>>   drivers/watchdog/meson_gxbb_wdt.c | 287 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 288 insertions(+)
>>   create mode 100644 drivers/watchdog/meson_gxbb_wdt.c
>>
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 9bde095..7679d93 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile

[...]

>> +
>> +unsigned int meson_gxbb_wdt_status(struct watchdog_device *wdt_dev)
>> +{
>> +    struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
>> +
>> +    return !!(readl(data->reg_base + GXBB_WDT_CTRL_REG) & GXBB_WDT_CTRL_EN);
> 
> This function is not supposed to return 0/1 but a bit mask with relevant
> WDIOF_bits set. sbsa_gwdt.c is buggy (oops, and I reviewed it ;-), so
> please don't use it as example; it doesn't make much sense to return
> a kernel-only flag to user space.
> 
> Overall I would suggest to not implement the function at all. We'll have
> to revisit it - its current implementation in the watchdog core does not
> make much sense and for the most part only returns 0 to user space.
> The only driver implementing it (sbsa) returns a bad value. It is also
> _not_ supposed to return the "watchdog running" status as currently
> implemented (there is no WDIOF_ flag indicating that the watchdog is
> running).

Ok, will remove it.

>> +}
>> +
>> +int meson_gxbb_wdt_ping(struct watchdog_device *wdt_dev)
>> +{
>> +    struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
>> +
>> +    writel(0, data->reg_base + GXBB_WDT_RSET_REG);
>> +
>> +    return 0;
>> +}
>> +
>> +int meson_gxbb_wdt_set_timeout(struct watchdog_device *wdt_dev,
>> +                   unsigned int timeout)
>> +{
>> +    struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
>> +
>> +    if (watchdog_active(wdt_dev))
>> +        meson_gxbb_wdt_stop(wdt_dev);
>> +
> 
> Is the stop/start sequence mandatory ? It leaves the system unprotected
> for a few cycles, so it is undesirable.

No, it's not mandatory, it's a good point.

>> +
>> +    data->wdt_dev.parent = &pdev->dev;
>> +    data->wdt_dev.info = &meson_gxbb_wdt_info;
>> +    data->wdt_dev.ops = &meson_gxbb_wdt_ops;
>> +    data->wdt_dev.max_hw_heartbeat_ms = GXBB_WDT_TCNT_SETUP_MASK;
>> +    data->wdt_dev.min_hw_heartbeat_ms = 1;
> 
> Does the device require a minimum time between heartbeats ?
> Just asking, because you violate it yourself below.
> 
> If you want to set the minimum timeout, that would be min_timeout.

Ok, these values are not very clear actually.

>> +    data->wdt_dev.timeout = DEFAULT_TIMEOUT;
>> +    watchdog_set_drvdata(&data->wdt_dev, data);
>> +
>> +    watchdog_init_timeout(&data->wdt_dev, DEFAULT_TIMEOUT, &pdev->dev);
>> +
> 
> DEFAULT_TIMEOUT is unnecessary here. Since the default timeout is already set,
> it makes the call useless.
> 
>> +    ret = watchdog_register_device(&data->wdt_dev);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Setup with 1ms timebase */
>> +    writel(((clk_get_rate(data->clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
>> +        GXBB_WDT_CTRL_EE_RESET |
>> +        GXBB_WDT_CTRL_CLK_EN |
>> +        GXBB_WDT_CTRL_CLKDIV_EN,
>> +        data->reg_base + GXBB_WDT_CTRL_REG);
>> +    meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
> 
> set_timeout already calls the ping function. Also, the functions should be called
> prior to watchdog registration to avoid race conditions.
> 
>> +    meson_gxbb_wdt_ping(&data->wdt_dev);
> 
> This is unusual. If the watchdog can be already running, it might make sense
> to tell the core about it (set WDOG_HW_RUNNING in the status field), so it
> can send heartbeats until user space opens the device.

Yes, since meson_gxbb_wdt_set_timeout() already ping, this is useless.
