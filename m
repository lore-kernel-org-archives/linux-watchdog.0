Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49892 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbbAKQQm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 11 Jan 2015 11:16:42 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YALBw-0049hE-Q1
	for linux-watchdog@vger.kernel.org; Sun, 11 Jan 2015 16:16:43 +0000
Message-ID: <54B2A1E5.9030500@roeck-us.net>
Date: Sun, 11 Jan 2015 08:16:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Maarten ter Huurne <maarten@treewalker.org>
CC: Ralf Baechle <ralf@linux-mips.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Paul Burton <paul.burton@imgtec.com>,
	Paul Cercueil <paul@crapouillou.net>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: jz4740: Move reset code to the watchdog driver
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <1420914550-18335-3-git-send-email-lars@metafoo.de> <54B1CF4B.3070503@roeck-us.net> <1766434.QjfqQROysC@hyperion> <54B24566.5010109@metafoo.de>
In-Reply-To: <54B24566.5010109@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/11/2015 01:41 AM, Lars-Peter Clausen wrote:
> On 01/11/2015 02:43 AM, Maarten ter Huurne wrote:
>> On Saturday 10 January 2015 17:18:03 Guenter Roeck wrote:
>>> On 01/10/2015 10:29 AM, Lars-Peter Clausen wrote:
>>>> @@ -186,9 +208,20 @@ static int jz4740_wdt_probe(struct platform_device
>>>> *pdev)>
>>>>        if (ret < 0)
>>>>            goto err_disable_clk;
>>>>
>>>> +    drvdata->restart_handler.notifier_call = jz4740_wdt_restart;
>>>> +    drvdata->restart_handler.priority = 128;
>>>> +    ret = register_restart_handler(&drvdata->restart_handler);
>>>> +    if (ret) {
>>>> +        dev_err(&pdev->dev, "cannot register restart handler, %d\n",
>>>> +            ret);
>>>> +        goto err_unregister_watchdog;
>>>
>>> Are you sure you want to abort in this case ?
>>> After all, the watchdog would still work.
>>
>> That raises a similar question: what about the opposite case, where the
>> watchdog registration fails? If the resource acquisition part of the probe
>> fails, neither the watchdog nor the restart functionality is going to work,
>> but if the call to watchdog_register_device() fails, the restart handler
>> would still work.
>
> I think this is fine, if either the watchdog or the restart handler registration fail then the system is probably already in a rather unusable state.
>
> But that got me thinking, maybe instead of having each watchdog driver register and implement its own restart handler we should maybe add this as a functionality to the watchdog framework. Something along the lines off.
>
> watchdog_set_timeout(wdt, wdt->min_timeout);
> watchdog_start(wdt);
> mdelay(wdt->min_timeout * 2000);
>

Agreed, something like that might be useful as fallback mechanism.

Guenter

