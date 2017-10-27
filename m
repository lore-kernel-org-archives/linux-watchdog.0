Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:54085 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbdJ0NmP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 27 Oct 2017 09:42:15 -0400
Subject: Re: [PATCH v3 2/2] watchdog: Add Spreadtrum watchdog driver
To: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, baolin.wang@linaro.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d1efd94bfbc92b89e246b0b745d976d547b145b6.1509070855.git.eric.long@spreadtrum.com>
 <b7c53cbdc36c3a4434ad2488a6646f6365cdfe77.1509070855.git.eric.long@spreadtrum.com>
 <88fc46de-dabf-b702-0c86-a51c26d263e0@roeck-us.net>
 <20171027075433.GA13942@spreadtrum.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <bc5dd263-3673-67ed-e42a-5725d1a2bee2@roeck-us.net>
Date: Fri, 27 Oct 2017 06:42:11 -0700
MIME-Version: 1.0
In-Reply-To: <20171027075433.GA13942@spreadtrum.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/27/2017 12:54 AM, Eric Long wrote:
> Hi Guenter,
> 
> Thanks for you commonts.
> 
> On Thu, Oct 26, 2017 at 10:23:40PM -0700, Guenter Roeck wrote:
>> On 10/26/2017 07:28 PM, Eric Long wrote:
>>> This patch adds the watchdog driver for Spreadtrum SC9860 platform.
>>>
>>> Signed-off-by: Eric Long <eric.long@spreadtrum.com>
>>> ---
>>> Change since v2:
>>>   - Rename all the macors, add SPRD tag at the head of the macro names.
>>>   - Rename SPRD_WDT_CLK as SPRD_WTC_CNT_STEP.
>>>   - Remove the code which check timeout value at the wrong place.
>>>   - Add min/max timeout value limit.
>>>   - Remove set WDOG_HW_RUNNING status at sprd_wdt_enable().
>>>   - Add timeout/pretimeout judgment when set them.
>>>   - Support WATCHDOG_NOWAYOUT status.
>>>
>>> Changes since v1:
>>>   - Use pretimeout instead of own implementation.
>>>   - Fix timeout loop when loading timeout values.
>>>   - use the infrastructure to read and set "timeout-sec" property.
>>>   - Add conditions when start or stop watchdog.
>>>   - Change the position of enabling watchdog.
>>>   - Other optimization.
>>> ---
>>>   drivers/watchdog/Kconfig    |   8 +
>>>   drivers/watchdog/Makefile   |   1 +
>>>   drivers/watchdog/sprd_wdt.c | 415 ++++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 424 insertions(+)
>>>   create mode 100644 drivers/watchdog/sprd_wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index c722cbf..4a77e17 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -787,6 +787,14 @@ config UNIPHIER_WATCHDOG
>>>   	  To compile this driver as a module, choose M here: the
>>>   	  module will be called uniphier_wdt.
>>> +config SPRD_WATCHDOG
>>> +	tristate "Spreadtrum watchdog support"
>>> +	depends on ARCH_SPRD || COMPILE_TEST
>>> +	select WATCHDOG_CORE
>>> +	help
>>> +	  Say Y here to include support watchdog timer embedded
>>> +	  into the Spreadtrum system.
>>
>> Maybe better "supported by" instead of "embedded into". Or at least
>> "embedded in".
> 
> OK, I will fix it.
>   
>>> +
>>>   # AVR32 Architecture
>>>   config AT32AP700X_WDT
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index 56adf9f..187cca2 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -87,6 +87,7 @@ obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
>>>   obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
>>>   obj-$(CONFIG_STM32_WATCHDOG) += stm32_iwdg.o
>>>   obj-$(CONFIG_UNIPHIER_WATCHDOG) += uniphier_wdt.o
>>> +obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
>>>   # AVR32 Architecture
>>>   obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
>>> diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
>>> new file mode 100644
>>> index 0000000..5fc3dde
>>> --- /dev/null
>>> +++ b/drivers/watchdog/sprd_wdt.c
>>> @@ -0,0 +1,415 @@
>>> +/*
>>> + * Spreadtrum watchdog driver
>>> + * Copyright (C) 2017 Spreadtrum - http://www.spreadtrum.com
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * General Public License for more details.
>>> + */
>>> +
>>> +#include <linux/bitops.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/err.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/watchdog.h>
>>> +
>>> +#define SPRD_WDT_LOAD_LOW		0x0
>>> +#define SPRD_WDT_LOAD_HIGH		0x4
>>> +#define SPRD_WDT_CTRL			0x8
>>> +#define SPRD_WDT_INT_CLR		0xc
>>> +#define SPRD_WDT_INT_RAW		0x10
>>> +#define SPRD_WDT_INT_MSK		0x14
>>> +#define SPRD_WDT_CNT_LOW		0x18
>>> +#define SPRD_WDT_CNT_HIGH		0x1c
>>> +#define SPRD_WDT_LOCK			0x20
>>> +#define SPRD_WDT_IRQ_LOAD_LOW		0x2c
>>> +#define SPRD_WDT_IRQ_LOAD_HIGH		0x30
>>> +
>>> +/* WDT_CTRL */
>>> +#define SPRD_WDT_INT_EN_BIT		BIT(0)
>>> +#define SPRD_WDT_CNT_EN_BIT		BIT(1)
>>> +#define SPRD_WDT_NEW_VER_EN		BIT(2)
>>> +#define SPRD_WDT_RST_EN_BIT		BIT(3)
>>> +
>>> +/* WDT_INT_CLR */
>>> +#define SPRD_WDT_INT_CLEAR_BIT		BIT(0)
>>> +#define SPRD_WDT_RST_CLEAR_BIT		BIT(3)
>>> +
>>> +/* WDT_INT_RAW */
>>> +#define SPRD_WDT_INT_RAW_BIT		BIT(0)
>>> +#define SPRD_WDT_RST_RAW_BIT		BIT(3)
>>> +#define SPRD_WDT_LD_BUSY_BIT		BIT(4)
>>> +
>>> +/* 1s equale to 32768 counter steps */
>>
>> equal ?
>>
> 
> OK, I will fix it.
> 
>>> +#define SPRD_WDT_CNT_STEP		32768
>>> +
>>> +#define SPRD_WDT_UNLOCK_KEY		0xe551
>>> +#define SPRD_WDT_MIN_TIMROUT		3
>>
>> TIMROUT ot TIMEOUT ?
>>
> 
> OK, I will fix it.
> 
>>> +#define SPRD_WDT_MAX_TIMEOUT		60
>>
>> Is that really the maximum supported timeout ? Seems a bit low.
>> Shouldn't it be something like (U32_MAX / SPRD_WDT_CNT_STEP) ?
>>
> 
> It supports the max value like as U32_MAX/SPRD_WDT_CNT_STEP,
> but it doesn't unnecessary to support so big value, if the system can not
> response it in 60s, the watchdog could trigger timeout.
> 
It is customary to provide the highest possible value here.
No one is forced to set such high values. You are making a choice for
others here. But, sure, if you insist; not worth arguing about.

>>> +
>>> +#define SPRD_WDT_CNT_HIGH_VALUE		16
>>
>> Maybe name it "SPRD_WDT_CNT_HIGH_SHIFT". It is not really a value,
>> it is a shift.
>>
> 
> Yes, you are right, _SHIFT will be better.
>   
>>> +#define SPRD_WDT_LOW_VALUE_MASK		GENMASK(15, 0)
>>> +#define SPRD_WDT_CNT_VALUE_MAX		GENMASK(31, 0)
>>
>> Does this mask serve a useful purpose ?
>>
> 
> OK, I will remove it, thanks!
> 
>>> +#define SPRD_WDT_LOAD_TIMEOUT		1000
>>> +
>>> +struct sprd_wdt {
>>> +	void __iomem *base;
>>> +	struct watchdog_device wdd;
>>> +	struct clk *enable;
>>> +	struct clk *rtc_enable;
>>> +	unsigned int irq;
>>> +};
>>> +
>>> +static inline struct sprd_wdt *to_sprd_wdt(struct watchdog_device *wdd)
>>> +{
>>> +	return container_of(wdd, struct sprd_wdt, wdd);
>>> +}
>>> +
>>> +static inline void sprd_wdt_lock(void __iomem *addr)
>>> +{
>>> +	writel_relaxed(0x0, addr + SPRD_WDT_LOCK);
>>> +}
>>> +
>>> +static inline void sprd_wdt_unlock(void __iomem *addr)
>>> +{
>>> +	writel_relaxed(SPRD_WDT_UNLOCK_KEY, addr + SPRD_WDT_LOCK);
>>> +}
>>> +
>>> +static inline bool sprd_wdt_is_running(struct sprd_wdt *wdt)
>>> +{
>>> +	u32 val;
>>> +
>>> +	val = readl_relaxed(wdt->base + SPRD_WDT_CTRL);
>>> +	return val & SPRD_WDT_NEW_VER_EN;
>>> +}
>>> +
>>> +static irqreturn_t sprd_wdt_isr(int irq, void *dev_id)
>>> +{
>>> +	struct sprd_wdt *wdt = (struct sprd_wdt *)dev_id;
>>> +
>>> +	sprd_wdt_unlock(wdt->base);
>>> +	writel_relaxed(SPRD_WDT_INT_CLEAR_BIT, wdt->base + SPRD_WDT_INT_CLR);
>>> +	sprd_wdt_lock(wdt->base);
>>> +	watchdog_notify_pretimeout(&wdt->wdd);
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +static u32 sprd_wdt_get_cnt_value(struct sprd_wdt *wdt)
>>> +{
>>> +	u32 val;
>>> +
>>> +	val = readl_relaxed(wdt->base + SPRD_WDT_CNT_HIGH) <<
>>> +		SPRD_WDT_CNT_HIGH_VALUE;
>>> +	val |= readl_relaxed(wdt->base + SPRD_WDT_CNT_LOW) &
>>> +		SPRD_WDT_LOW_VALUE_MASK;
>>> +
>>> +	return val;
>>> +}
>>> +
>>> +static int sprd_wdt_load_value(struct sprd_wdt *wdt, u32 timeout,
>>> +			       u32 pretimeout)
>>> +{
>>> +	u32 val, delay_cnt = 0;
>>> +	u32 tmr_step = timeout * SPRD_WDT_CNT_STEP;
>>> +	u32 prtmr_step = pretimeout * SPRD_WDT_CNT_STEP;
>>> +
>>> +	sprd_wdt_unlock(wdt->base);
>>> +	writel_relaxed((tmr_step >> SPRD_WDT_CNT_HIGH_VALUE) &
>>> +		      SPRD_WDT_LOW_VALUE_MASK, wdt->base + SPRD_WDT_LOAD_HIGH);
>>> +	writel_relaxed((tmr_step & SPRD_WDT_LOW_VALUE_MASK),
>>> +		       wdt->base + SPRD_WDT_LOAD_LOW);
>>> +	writel_relaxed((prtmr_step >> SPRD_WDT_CNT_HIGH_VALUE) &
>>> +			SPRD_WDT_LOW_VALUE_MASK,
>>> +		       wdt->base + SPRD_WDT_IRQ_LOAD_HIGH);
>>> +	writel_relaxed(prtmr_step & SPRD_WDT_LOW_VALUE_MASK,
>>> +		       wdt->base + SPRD_WDT_IRQ_LOAD_LOW);
>>> +	sprd_wdt_lock(wdt->base);
>>> +
>>> +	/*
>>> +	 * Waiting the load value operation done,
>>> +	 * it needs two or three RTC clock cycles.
>>> +	 */
>>> +	do {
>>> +		val = readl_relaxed(wdt->base + SPRD_WDT_INT_RAW);
>>> +		if (!(val & SPRD_WDT_LD_BUSY_BIT))
>>> +			break;
>>> +
>>> +		cpu_relax();
>>> +	} while (delay_cnt++ < SPRD_WDT_LOAD_TIMEOUT);
>>> +
>>> +	if (delay_cnt >= SPRD_WDT_LOAD_TIMEOUT)
>>> +		return -EBUSY;
>>> +	return 0;
>>> +}
>>> +
>>> +static int sprd_wdt_enable(struct sprd_wdt *wdt)
>>> +{
>>> +	u32 val;
>>> +	int ret;
>>> +
>>> +	ret = clk_prepare_enable(wdt->enable);
>>> +	if (ret)
>>> +		return ret;
>>> +	ret = clk_prepare_enable(wdt->rtc_enable);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	sprd_wdt_unlock(wdt->base);
>>> +	val = readl_relaxed(wdt->base + SPRD_WDT_CTRL);
>>> +	val |= SPRD_WDT_NEW_VER_EN;
>>> +	writel_relaxed(val, wdt->base + SPRD_WDT_CTRL);
>>> +	sprd_wdt_lock(wdt->base);
>>> +	return 0;
>>> +}
>>> +
>>> +static void sprd_wdt_disable(struct sprd_wdt *wdt)
>>> +{
>>> +	sprd_wdt_unlock(wdt->base);
>>> +	writel_relaxed(0x0, wdt->base + SPRD_WDT_CTRL);
>>> +	sprd_wdt_lock(wdt->base);
>>> +
>>> +	clk_disable_unprepare(wdt->rtc_enable);
>>> +	clk_disable_unprepare(wdt->enable);
>>> +}
>>> +
>>> +static int sprd_wdt_start(struct watchdog_device *wdd)
>>> +{
>>> +	struct sprd_wdt *wdt = to_sprd_wdt(wdd);
>>> +	u32 val;
>>> +	int ret;
>>> +
>>> +	ret = sprd_wdt_load_value(wdt, wdd->timeout, wdd->pretimeout);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	sprd_wdt_unlock(wdt->base);
>>> +	val = readl_relaxed(wdt->base + SPRD_WDT_CTRL);
>>> +	val |= SPRD_WDT_CNT_EN_BIT | SPRD_WDT_INT_EN_BIT | SPRD_WDT_RST_EN_BIT;
>>> +	writel_relaxed(val, wdt->base + SPRD_WDT_CTRL);
>>> +	sprd_wdt_lock(wdt->base);
>>> +	set_bit(WDOG_HW_RUNNING, &wdd->status);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int sprd_wdt_stop(struct watchdog_device *wdd)
>>> +{
>>> +	struct sprd_wdt *wdt = to_sprd_wdt(wdd);
>>> +	u32 val;
>>> +
>>> +	sprd_wdt_unlock(wdt->base);
>>> +	val = readl_relaxed(wdt->base + SPRD_WDT_CTRL);
>>> +	val &= ~(SPRD_WDT_CNT_EN_BIT | SPRD_WDT_RST_EN_BIT |
>>> +		SPRD_WDT_INT_EN_BIT);
>>> +	writel_relaxed(val, wdt->base + SPRD_WDT_CTRL);
>>> +	sprd_wdt_lock(wdt->base);
>>> +	return 0;
>>> +}
>>> +
>>> +static int sprd_wdt_set_timeout(struct watchdog_device *wdd,
>>> +				u32 timeout)
>>> +{
>>> +	struct sprd_wdt *wdt = to_sprd_wdt(wdd);
>>> +
>>> +	if (timeout == wdd->timeout)
>>> +		return 0;
>>> +
>>> +	wdd->timeout = timeout;
>>> +
>>> +	return sprd_wdt_load_value(wdt, timeout, wdd->pretimeout);
>>> +}
>>> +
>>> +static int sprd_wdt_set_pretimeout(struct watchdog_device *wdd,
>>> +				   u32 new_pretimeout)
>>> +{
>>> +	struct sprd_wdt *wdt = to_sprd_wdt(wdd);
>>> +
>>> +	if (new_pretimeout == wdd->pretimeout)
>>> +		return 0;
>>
>> This is inconsistent. pretimeout == 0 is accepted until it is set
>> to a non-zero value once, then 0 is no longer accepted. pretimeout==0
>> should reflect "pretimeout disabled". If that is not possible you
>> need to set some non-0 default value in the probe function.
>>
> 
> I understand your opinion, I will fix it.
> 
>>> +	if (new_pretimeout <= wdd->min_timeout)
>>> +		return -EINVAL;
>>
>> Why is pretimeout == wdd->min_timeout invalid ?
>>
> 
> OK, you are right, it should be pretimeout < min_timeout.
> 
>>> +
>>> +	wdd->pretimeout = new_pretimeout;
>>> +
>>> +	return sprd_wdt_load_value(wdt, wdd->timeout, new_pretimeout);
>>> +}
>>> +
>>> +static u32 sprd_wdt_get_timeleft(struct watchdog_device *wdd)
>>> +{
>>> +	struct sprd_wdt *wdt = to_sprd_wdt(wdd);
>>> +	u32 val;
>>> +
>>> +	val = sprd_wdt_get_cnt_value(wdt);
>>> +	val = val / SPRD_WDT_CNT_STEP;
>>> +
>>> +	return val;
>>> +}
>>> +
>>> +static const struct watchdog_ops sprd_wdt_ops = {
>>> +	.owner = THIS_MODULE,
>>> +	.start = sprd_wdt_start,
>>> +	.stop = sprd_wdt_stop,
>>> +	.set_timeout = sprd_wdt_set_timeout,
>>> +	.set_pretimeout = sprd_wdt_set_pretimeout,
>>> +	.get_timeleft = sprd_wdt_get_timeleft,
>>
>> Just wondering - no heartbeat function ? Having to load the timer
>> values for each heartbeat is expensive.
>>
> 
> Unfortunately, this watchdog has not RELOAD register.
>   
>>> +};
>>> +
>>> +static const struct watchdog_info sprd_wdt_info = {
>>> +	.options = WDIOF_SETTIMEOUT |
>>> +		   WDIOF_PRETIMEOUT |
>>> +		   WDIOF_MAGICCLOSE |
>>> +		   WDIOF_KEEPALIVEPING,
>>> +	.identity = "Spreadtrum Watchdog Timer",
>>> +};
>>> +
>>> +static int sprd_wdt_probe(struct platform_device *pdev)
>>> +{
>>> +	struct resource *wdt_res;
>>> +	struct sprd_wdt *wdt;
>>> +	int ret;
>>> +
>>> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>>> +	if (!wdt)
>>> +		return -ENOMEM;
>>> +
>>> +	wdt_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (!wdt_res) {
>>> +		dev_err(&pdev->dev, "failed to memory resource\n");
>>> +		return -ENOMEM;
>>> +	}
>>
>> Unnecessary error check and message. devm_ioremap_resource()
>> returns an error if res is NULL.
>>
> 
> OK, I will fix it.
>   
>>> +
>>> +	wdt->base = devm_ioremap_resource(&pdev->dev, wdt_res);
>>> +	if (IS_ERR(wdt->base))
>>
>> Move the error message to here.
>>
>>> +		return PTR_ERR(wdt->base);
>>> +
>>> +	wdt->enable = devm_clk_get(&pdev->dev, "enable");
>>> +	if (IS_ERR(wdt->enable)) {
>>> +		dev_err(&pdev->dev, "can't get the enable clock\n");
>>> +		return PTR_ERR(wdt->enable);
>>> +	}
>>> +
>>> +	wdt->rtc_enable = devm_clk_get(&pdev->dev, "rtc_enable");
>>> +	if (IS_ERR(wdt->rtc_enable)) {
>>> +		dev_err(&pdev->dev, "can't get the rtc enable clock\n");
>>> +		return PTR_ERR(wdt->rtc_enable);
>>> +	}
>>> +
>>> +	wdt->irq = platform_get_irq(pdev, 0);
>>> +	if (wdt->irq < 0) {
>>> +		dev_err(&pdev->dev, "failed to get IRQ resource\n");
>>> +		return wdt->irq;
>>> +	}
>>> +
>>> +	ret = devm_request_irq(&pdev->dev, wdt->irq, sprd_wdt_isr,
>>> +			       IRQF_NO_SUSPEND, "sprd-wdt", (void *)wdt);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "failed to register irq\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	wdt->wdd.info = &sprd_wdt_info;
>>> +	wdt->wdd.ops = &sprd_wdt_ops;
>>> +	wdt->wdd.parent = &pdev->dev;
>>> +	wdt->wdd.min_timeout = SPRD_WDT_MIN_TIMROUT;
>>> +	wdt->wdd.max_timeout = SPRD_WDT_MAX_TIMEOUT;
>>> +
>> You might want to set wdt->wdd.timeout to a default value.
>>
> 
> OK, I will set a default timeout value in case of no timeout-sec in device-tree.
>   
>>> +	ret = sprd_wdt_enable(wdt);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "failed to enable wdt\n");
>>> +		return ret;
>>> +	}
>>> +
>>
>> This needs a matching sprd_wdt_disable() call in the remove function.
>> Best way to handle this would be to add devm_add_action() here.
>>
> 
> If add devm_add_action(), it will be called in the remove function,
> but this is not our expect, if someone remove this module, we want it just timeout.
> 

But that leaves the watchdog enabled even if it was stopped (no call to
sprd_wdt_disable()).

Relying on NOWAYOUT would be a better option here. Again, you are
making a choice for the user.

>>> +	watchdog_set_nowayout(&wdt->wdd, WATCHDOG_NOWAYOUT);
>>> +	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
>>> +
>>> +	ret = watchdog_register_device(&wdt->wdd);
>>
>> Unfortunately this doesn't work. It leaves interrupts enabled
>> after the watchdog device is removed in sprd_wdt_remove(),
>> but the driver will be gone. I would suggest to use
>> devm_watchdog_register_device() and reorder calls to request
>> the interrupt after registering the watchdog device. Then you
>> can drop the remove function entirely.
>>
> 
> Yes, you are right, I understand your opinion, and it is very important,
> devm_watchdog_register_device() is better. Thanks.
> 
>>> +	if (ret) {
>>> +		sprd_wdt_disable(wdt);
>>> +		dev_err(&pdev->dev, "failed to register watchdog\n");
>>> +		return ret;
>>> +	}
>>> +	platform_set_drvdata(pdev, wdt);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int sprd_wdt_remove(struct platform_device *pdev)
>>> +{
>>> +	struct sprd_wdt *wdt = platform_get_drvdata(pdev);
>>> +
>>> +	watchdog_unregister_device(&wdt->wdd);
>>> +
>>> +	if (sprd_wdt_is_running(wdt))
>>> +		dev_crit(&pdev->dev, "Device removed: Expect reboot!\n");
>>> +	return 0;
>>> +}
>>> +
>>> +static int __maybe_unused sprd_wdt_pm_suspend(struct device *dev)
>>> +{
>>> +	struct watchdog_device *wdd = dev_get_drvdata(dev);
>>> +	struct sprd_wdt *wdt = dev_get_drvdata(dev);
>>> +
>>> +	if (watchdog_active(wdd)) {
>>> +		sprd_wdt_stop(&wdt->wdd);
>>> +		sprd_wdt_disable(wdt);
>>
>> Are you sure you only want to disable the clocks if the watchdog was active ?
>> That seems to be a bit inconsistent.
>>
> 
> This watchdog is in always on power domain, if system suspend, it needs to
> disable it, or it will timeout.
> 
That is not what I asked. I asked why it isn't

	if (watchdog_active(wdd))
		sprd_wdt_stop(&wdt->wdd);

	sprd_wdt_disable(wdt);

instead.

>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int __maybe_unused sprd_wdt_pm_resume(struct device *dev)
>>> +{
>>> +	struct watchdog_device *wdd = dev_get_drvdata(dev);
>>> +	struct sprd_wdt *wdt = dev_get_drvdata(dev);
>>> +	int ret;
>>> +
>>> +	if (watchdog_active(wdd)) {
>>> +		ret = sprd_wdt_enable(wdt);
>>> +		if (ret)
>>> +			return ret;
>>> +		ret = sprd_wdt_start(&wdt->wdd);
>>> +		if (ret) {
>>> +			sprd_wdt_disable(wdt);
>>> +			return ret;
>>> +		}
>>
>> This can leave the system in an inconsistent state. Sometimes the wdt may be
>> disabled, sometimes not.
>>
> 
> If watchdog enable failed, it means there is something wrong in this system.
>   

True.

Guenter
