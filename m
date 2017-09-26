Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35179 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965786AbdIZHGt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Sep 2017 03:06:49 -0400
Subject: Re: [PATCH v3 1/2] watchdog: dw_wdt: add stop watchdog operation
To: Oleksij Rempel <ore@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20170925052531.1692-1-o.rempel@pengutronix.de>
 <20170925161643.GA32601@roeck-us.net>
 <2203f151-99c8-6c58-8766-70813fafe64d@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1bd8aa83-97bc-550b-3a2b-46ae857e21c1@roeck-us.net>
Date: Tue, 26 Sep 2017 00:06:45 -0700
MIME-Version: 1.0
In-Reply-To: <2203f151-99c8-6c58-8766-70813fafe64d@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/25/2017 10:17 PM, Oleksij Rempel wrote:
> Hi,
> 
> On 25.09.2017 18:16, Guenter Roeck wrote:
>> On Mon, Sep 25, 2017 at 07:25:30AM +0200, Oleksij Rempel wrote:
>>> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>>
>>> The only way of stopping the watchdog is by resetting it.
>>> Add the watchdog op for stopping the device and reset if
>>> a reset line is provided.
>>>
>>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>> Cc: Wim Van Sebroeck <wim@iguana.be>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: linux-watchdog@vger.kernel.org
>>> ---
>>>
>>> changes v3:
>>>   - don't return error if rst is not present and set WDOG_HW_RUNNING bit
>>>     to notify watchdog core.
>>>
>>> changes v2:
>>>   - test if dw_wdt->rst is NULL instead of IS_ERR
>>>
>>>   drivers/watchdog/dw_wdt.c | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
>>> index 36be987ff9ef..6cc56b18ee52 100644
>>> --- a/drivers/watchdog/dw_wdt.c
>>> +++ b/drivers/watchdog/dw_wdt.c
>>> @@ -135,6 +135,21 @@ static int dw_wdt_start(struct watchdog_device *wdd)
>>>       return 0;
>>>   }
>>> +static int dw_wdt_stop(struct watchdog_device *wdd)
>>> +{
>>> +    struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
>>> +
>>> +    if (!dw_wdt->rst) {
>>> +        set_bit(WDOG_HW_RUNNING, &wdd->status);
>>
>> Setting WDOG_HW_RUNNING should be dropped from dw_wdt_start().
> 
> you mean, this patch is OK, and i need to provide one more which is removing WDOG_HW_RUNNING from dw_wdt_start(). Correct?
> 

No. You are providing a stop function, thus the start function should not set the flag.

Guenter
