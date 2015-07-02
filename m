Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42529 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbbGBAOu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Jul 2015 20:14:50 -0400
Message-ID: <5594826F.6090203@roeck-us.net>
Date: Wed, 01 Jul 2015 17:14:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Joachim Eastwood <manabian@gmail.com>,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
References: <1435783930-20184-1-git-send-email-ariel@vanguardiasur.com.ar>	<1435783930-20184-2-git-send-email-ariel@vanguardiasur.com.ar> <CAGhQ9VzLX_hy2Z=jUH6on0_sOZBp_mg5cC0JXkHntWxxrr2K6A@mail.gmail.com>
In-Reply-To: <CAGhQ9VzLX_hy2Z=jUH6on0_sOZBp_mg5cC0JXkHntWxxrr2K6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/01/2015 04:04 PM, Joachim Eastwood wrote:
> Hi Ariel,
>

>> +/*
>> + * NXP LPC18xx Watchdog Timer (WDT)
>
> I think you should use "Windowed Watchdog Timer (WWDT)" here since
> that is name from the user manual, even though the driver doesn't have
> window functionality.
> At least use wwdt for the compatible string, ie: "nxp,lpc1850-wwdt".
>
> I don't think Guenter asked you to remove the "Windowed" part last
> time, but only asked what it meant.

I did, separately, but I don't want to start a war of words either.
No one will know what that term means, and I am personally not too hot
having to explain it to others.

If you insist using the term, please add a comment into the code
explaining what it is and that the driver does not support it.

Guenter

