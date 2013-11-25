Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50894 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab3KYMHd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Nov 2013 07:07:33 -0500
Message-ID: <52933D46.6090901@ti.com>
Date: Mon, 25 Nov 2013 14:06:30 +0200
From: "ivan.khoronzhuk" <ivan.khoronzhuk@ti.com>
MIME-Version: 1.0
To: Sekhar Nori <nsekhar@ti.com>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Kumar Gala <galak@kernel.crashing.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Strashko Grygorii <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/6] watchdog: davinci: change driver to use WDT core
References: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com> <1384795139-19466-2-git-send-email-ivan.khoronzhuk@ti.com> <52933AE4.3070608@ti.com>
In-Reply-To: <52933AE4.3070608@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/25/2013 01:56 PM, Sekhar Nori wrote:
> On Monday 18 November 2013 10:48 PM, Ivan Khoronzhuk wrote:
>> @@ -211,29 +129,34 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>>
>>   	clk_prepare_enable(wdt_clk);
>>
>> -	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
>> -		heartbeat = DEFAULT_HEARTBEAT;
>> +	wdd			= &wdt_wdd;
>> +	wdd->info		= &davinci_wdt_info;
>> +	wdd->ops		= &davinci_wdt_ops;
>> +	wdd->min_timeout 	= 1;
>> +	wdd->max_timeout 	= MAX_HEARTBEAT;
>
> Some checkpatch warnings. Please fix.
>
> WARNING: please, no space before tabs
> #273: FILE: drivers/watchdog/davinci_wdt.c:135:
> +^Iwdd->min_timeout ^I= 1;$
>
> WARNING: please, no space before tabs
> #274: FILE: drivers/watchdog/davinci_wdt.c:136:
> +^Iwdd->max_timeout ^I= MAX_HEARTBEAT;$
>
> total: 0 errors, 2 warnings, 0 checks, 249 lines checked
>
> Thanks,
> sekhar
>

Thanks, I will

-- 
Regards,
Ivan Khoronzhuk
