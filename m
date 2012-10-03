Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64544 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab2JCOKd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Oct 2012 10:10:33 -0400
Received: by obbuo13 with SMTP id uo13so7295518obb.19
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Oct 2012 07:10:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121002200753.GA12565@lunn.ch>
References: <20121002200753.GA12565@lunn.ch>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Wed, 3 Oct 2012 16:10:12 +0200
Message-ID: <CAHkwnC9a4wEko=dTpbkGXSqC0-zbjSy2AsfQPb6CnXZcEEPKzg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] watchdog: at91sam9_wdt: add device tree
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 2, 2012 at 10:07 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> Date: Tue,  2 Oct 2012 18:01:00 +0200
>> From: Fabio Porcedda <fabio.porcedda@gmail.com>
>> To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
>>         linux-arm-kernel@lists.infradead.org, Nicolas Ferre
>>         <nicolas.ferre@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD
>>         <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>
>> Cc: devicetree-discuss@lists.ozlabs.org
>> Subject: [PATCH v7 1/3] watchdog: at91sam9_wdt: add device tree
>>         support
>> Message-ID:
>>         <1349193662-23482-2-git-send-email-fabio.porcedda@gmail.com>
>>
>> Tested on an at91sam9260 board (evk-pro3)
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> +++ b/drivers/watchdog/at91sam9_wdt.c
>> @@ -32,6 +32,7 @@
>>  #include <linux/timer.h>
>>  #include <linux/bitops.h>
>>  #include <linux/uaccess.h>
>> +#include <linux/of.h>
>>
>>  #include "at91sam9_wdt.h"
>>
>> > @@ -302,11 +303,21 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
>>         return res;
>>  }
>>
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id at91_wdt_dt_ids[] = {
>> +       { .compatible = "atmel,at91sam9260-wdt" },
>> +       { /* sentinel */ }
>> +};
>
> Hi Fabio
>
> You are missing __devinitdata.

Thank you, Andrew.
I'll add __initconst, because it's const and use platform_driver_probe.

Best regards
-- 
Fabio Porcedda
