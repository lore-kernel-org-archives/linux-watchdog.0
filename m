Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44208 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbbESTMp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 15:12:45 -0400
Message-ID: <555B8B2A.5030706@codeaurora.org>
Date: Tue, 19 May 2015 14:12:42 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] [v3] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1431740145-21723-1-git-send-email-timur@codeaurora.org> <5556B5A3.1080208@roeck-us.net>
In-Reply-To: <5556B5A3.1080208@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter Roeck wrote:

>> +config ARM_SBSA_WDT
>> +    tristate "ARM Server Base System Architecture watchdog"
>> +    depends on ARM64 || COMPILE_TEST
>
> COMPILE_TEST doesn't work with the current code - see below.

Ok, I'll remove it.  I never liked it anyway.

> I still don't understand why you can not use the standard arch_sys_counter
> provided for arm but have to call arm-internal functions directly.
> That seems quite broken to me.

I tried to use clk_get_sys(), but that failed because there are no 
clocks defined on my platform (the 'clocks' list in clkdev.c is empty). 
  I don't think the clock API is fully functional on an ARM ACPI system.

I was originally using functions like arch_timer_read_counter(), but 
that function is not exported, so I couldn't compile my driver as module 
if I used it.

>> +#include <linux/acpi.h>
>> +
>> +/* Watchdog Interface Identification Registers */
>> +struct arm_sbsa_watchdog_ident {
>> +    __le32 w_iidr;    /* Watchdog Interface Identification Register */
>> +    uint8_t res2[0xFE8 - 0xFD0];
>> +    __le32 w_pidr2;    /* Peripheral ID2 Register */
>
> Does this register have any use ?

I don't use it in this driver, but it is part of the hardware.

>> +struct arm_sbsa_watchdog_data {
>> +    struct watchdog_device wdev;
>> +    unsigned int pm_status;
>
> You can use bool here.

Ok.

>> +static int arm_sbsa_wdt_start(struct watchdog_device *wdev)
>> +{
>> +    struct arm_sbsa_watchdog_data *data =
>> +        container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
>> +
>> +    /* Writing to the control register will also reset the counter */
>> +    writel(1, &data->control->wcs);
>> +
>
> Is it ok to always overwrite the entire wcs register ?

Yes.  Writes to bits 1-31 have no affect.

>> +static unsigned int arm_sbsa_wdt_timeleft(struct watchdog_device *wdev)
>> +{
>> +    struct arm_sbsa_watchdog_data *data =
>> +        container_of(wdev, struct arm_sbsa_watchdog_data, wdev);
>> +    uint64_t diff = readq(&data->control->wcv) -
>> arch_counter_get_cntvct();
>> +
> Due to this readq the code doesn't compile on arm,
> nor on any other architecture which does not implement readq.

>> +    return diff / arch_timer_get_cntfrq();
>
> .. and as mentioned before this won't compile on 32 bit targets.

That's why I have in my Kconfig:

	depends on ARM64

It will never be compiled on a 32-bit ARM platform.

>> +static struct watchdog_info arm_sbsa_wdt_info = {
>> +    .options = WDIOF_SETTIMEOUT | _WDIOF_KEEPALIVEPING,
>
>      WDIOF_MAGICCLOSE ?

Is it preferred to enable this feature?  It seems like a policy setting 
that shouldn't be defined by the driver.

>> +    /* We only support architecture version 0 */
>> +    iidr = readl(&data->control->ident.w_iidr);
>> +    if (((iidr >> 16) & 0xf) != 0) {
>> +        dev_info(&pdev->dev,
>> +             "only architecture version 0 is supported\n");
>
> dev_err ?
> It might make sense to display the detected version as well.

Ok.

>> +    watchdog_set_drvdata(&data->wdev, data);
>> +
> You don't ever call watchdog_get_drvdata(), so this is unnecessary.

Ok

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
