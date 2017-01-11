Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:45740 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbdAKOvb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Jan 2017 09:51:31 -0500
Subject: Re: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed
 functions
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
 <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
 <94c4d5c0-f639-eab1-6706-335977690e88@roeck-us.net>
 <a45ed205-7c1b-a298-50c0-fc8b80a846c5@sigmadesigns.com>
 <20170111143917.hedhyfu6m5dopag7@pengutronix.de>
CC: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mans Rullgard <mans@mansr.com>,
        Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <3d6670d5-bc35-62cf-81b9-9d41a2f4e803@mentor.com>
Date: Wed, 11 Jan 2017 16:50:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170111143917.hedhyfu6m5dopag7@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Uwe,

On 01/11/2017 04:39 PM, Uwe Kleine-König wrote:
> On Wed, Jan 11, 2017 at 01:31:47PM +0100, Marc Gonzalez wrote:
>> On 11/01/2017 11:52, Guenter Roeck wrote:
>>
>>> On 01/11/2017 01:07 AM, Marc Gonzalez wrote:
>>>
>>>>> @@ -134,12 +134,15 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>>>>>  	err = clk_prepare_enable(dev->clk);
>>>>>  	if (err)
>>>>>  		return err;
>>>>> +	err = devm_add_action_or_reset(&pdev->dev,
>>>>> +				       (void(*)(void *))clk_disable_unprepare,
>>>>> +				       dev->clk);
>>>>> +	if (err)
>>>>> +		return err;
> 
> This looks wrong. There is no clk_unprepare_disable when
> devm_add_action_or_reset fails.

actually there is a call to clk_disable_unprepare() on error path, you may
take a look at devm_add_action_or_reset() implementation.

Your comment is valid for devm_add_action() function though, but it's not
the case here.

--
With best wishes,
Vladimir
