Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33113 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbbF3F5N (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 30 Jun 2015 01:57:13 -0400
MIME-Version: 1.0
In-Reply-To: <558C0634.9050802@roeck-us.net>
References: <1435227711-29875-1-git-send-email-poeschel@lemonage.de> <558C0634.9050802@roeck-us.net>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 30 Jun 2015 01:56:42 -0400
Message-ID: <CAP=VYLr5wVMBdA76U0HKP2GTN07qiCkCTtBmFG5Z_bWE0QvT9g@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: omap_wdt: early_enable module parameter
To: Guenter Roeck <linux@roeck-us.net>
Cc: poeschel@lemonage.de, wim@iguana.be,
	Jonathan Corbet <corbet@lwn.net>,
	LKML doc <linux-doc@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jun 25, 2015 at 9:46 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 06/25/2015 03:21 AM, poeschel@lemonage.de wrote:
>>
>> From: Lars Poeschel <poeschel@lemonage.de>
>>
>> Add a early_enable module parameter to the omap_wdt that starts the
>> watchdog on module insertion. The default value is 0 which does not
>> start the watchdog - which also does not change the behavior if the
>> parameter is not given.
>>
>> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

In case the info hasn't looped back around yet, this breaks the
omap builds in linux-next:

drivers/watchdog/omap_wdt.c:288:18: error: 'omap_wdt' undeclared
(first use in this function)

(Not sure how this could have ever worked as-is.)

http://kisskb.ellerman.id.au/kisskb/buildresult/12452335/

I see a patch has already been posted to arm-kernel but not
Cc'd to all originally involved so figured I'd mention it.

Paul.
--

>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
