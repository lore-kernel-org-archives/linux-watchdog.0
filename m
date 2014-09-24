Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46346 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbaIXBlY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 23 Sep 2014 21:41:24 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XWba8-000Wgy-BI
	for linux-watchdog@vger.kernel.org; Wed, 24 Sep 2014 01:41:24 +0000
Message-ID: <54222123.2050703@roeck-us.net>
Date: Tue, 23 Sep 2014 18:40:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jisheng Zhang <jszhang@marvell.com>
CC: "wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] watchdog: dw_wdt: add restart handler support
References: <1411458132-5410-1-git-send-email-jszhang@marvell.com>	<1411458132-5410-3-git-send-email-jszhang@marvell.com>	<20140923183159.GB24930@roeck-us.net> <20140924091101.60e065cd@xhacker>
In-Reply-To: <20140924091101.60e065cd@xhacker>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/23/2014 06:11 PM, Jisheng Zhang wrote:
[ ... ]
>>> +	dw_wdt.restart_handler.notifier_call = dw_wdt_restart_handle;
>>> +	dw_wdt.restart_handler.priority = 128;
>>> +	ret = register_restart_handler(&dw_wdt.restart_handler);
>>> +	if (ret)
>>> +		pr_warn("cannot register restart handler\n");
>>
>> Please use dev_warn(&pdev->dev, ...).
>
> Yep, that's what I thought when patching the code. But the original source is
> using pr_*(), so I use pr_warn() to keep unification. Is there any better
> solution?
>

Good point. Makes sense, then, to leave that as cleanup.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

