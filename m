Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35346 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab2JEMG7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Oct 2012 08:06:59 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1610482oag.19
        for <linux-watchdog@vger.kernel.org>; Fri, 05 Oct 2012 05:06:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121005111642.GA12462@game.jcrosoft.org>
References: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
 <1349432169-13006-2-git-send-email-fabio.porcedda@gmail.com> <20121005111642.GA12462@game.jcrosoft.org>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Fri, 5 Oct 2012 14:06:38 +0200
Message-ID: <CAHkwnC8cZ26Z8jXx4LU3wBbGn2FC3-rjn+m861G3_Ue58yqfjw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/4] watchdog: core: dt: add support for the
 timeout-sec dt property
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 5, 2012 at 1:16 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 12:16 Fri 05 Oct     , Fabio Porcedda wrote:
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> ---
>>  Documentation/watchdog/watchdog-kernel-api.txt |  4 ++++
>>  drivers/watchdog/watchdog_core.c               | 27 ++++++++++++++++++++++++++
>>  include/linux/watchdog.h                       |  4 ++++
>>  3 files changed, 35 insertions(+)
>>
>> diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
>> index 086638f..2208db7 100644
>> --- a/Documentation/watchdog/watchdog-kernel-api.txt
>> +++ b/Documentation/watchdog/watchdog-kernel-api.txt
>> @@ -212,3 +212,7 @@ driver specific data to and a pointer to the data itself.
>>  The watchdog_get_drvdata function allows you to retrieve driver specific data.
>>  The argument of this function is the watchdog device where you want to retrieve
>>  data from. The function returns the pointer to the driver specific data.
>> +
>> +The watchdog_init_timeout function allows you to initialize the timeout field
>> +using the module timeout parameter or retrieving the timeout-sec property from
>> +the device tree.
>> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
>> index 3796434..646be48 100644
>> --- a/drivers/watchdog/watchdog_core.c
>> +++ b/drivers/watchdog/watchdog_core.c
>> @@ -143,6 +143,33 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
>>  }
>>  EXPORT_SYMBOL_GPL(watchdog_unregister_device);
>>
>> +/**
>> + * watchdog_init_timeout() - initialize the timeout field
>> + * @parm_timeout: timeout module parameter, it takes precedence over the
>> + *                timeout-sec property.
>> + * @node: Retrieve the timeout-sec property only if the parm_timeout
>> + *        is out of bounds.
>> + */
>> +void watchdog_init_timeout(struct watchdog_device *wdd,
>> +                        unsigned int parm_timeout, struct device_node *node)
>> +{
>> +     unsigned int t = 0;
>> +
>> +     if ((parm_timeout >= wdd->min_timeout) &&
>> +         (parm_timeout <= wdd->max_timeout)) {
>> +             wdd->timeout = parm_timeout;
>> +             return;
>> +     }
>> +
>> +     if (!node)
>> +             return;
>> +
>> +     of_property_read_u32(node, "timeout-sec", &t);
> why I bother to comment
> *make this of generic* this is not watchdog specific other driver can use it

You mean to add the function in of.h and use that function inside
watchdog_init_timeout or to
use the of_* function instead of the watchdog_init_timeout function?

Do you like the use of watchdog_init_timeout function inside the
at91sam9_wdt driver?

Best regards
-- 
Fabio Porcedda
