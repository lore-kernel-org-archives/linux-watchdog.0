Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34712 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbGBJDM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Jul 2015 05:03:12 -0400
Received: by lbnk3 with SMTP id k3so27923311lbn.1
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2015 02:03:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5594826F.6090203@roeck-us.net>
References: <1435783930-20184-1-git-send-email-ariel@vanguardiasur.com.ar>
	<1435783930-20184-2-git-send-email-ariel@vanguardiasur.com.ar>
	<CAGhQ9VzLX_hy2Z=jUH6on0_sOZBp_mg5cC0JXkHntWxxrr2K6A@mail.gmail.com>
	<5594826F.6090203@roeck-us.net>
Date: Thu, 2 Jul 2015 11:03:10 +0200
Message-ID: <CAGhQ9VwXnc9+QfCWG785UCuKtdg9AJ_R24dVcUF17tkxXu0bpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
From: Joachim Eastwood <manabian@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Ariel D'Alessandro" <ariel@vanguardiasur.com.ar>,
	linux-watchdog@vger.kernel.org, wim@iguana.be,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 2 July 2015 at 02:14, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/01/2015 04:04 PM, Joachim Eastwood wrote:
>>
>> Hi Ariel,
>>
>
>>> +/*
>>> + * NXP LPC18xx Watchdog Timer (WDT)
>>
>>
>> I think you should use "Windowed Watchdog Timer (WWDT)" here since
>> that is name from the user manual, even though the driver doesn't have
>> window functionality.
>> At least use wwdt for the compatible string, ie: "nxp,lpc1850-wwdt".
>>
>> I don't think Guenter asked you to remove the "Windowed" part last
>> time, but only asked what it meant.
>
>
> I did, separately, but I don't want to start a war of words either.
> No one will know what that term means, and I am personally not too hot
> having to explain it to others.

Fine.

My only request then is to make the compatible string
"nxp,lpc1850-wwdt", to leave the WWDT name somewhere. As this is the
name you will find through out the user manual for this hw block.


regards,
Joachim Eastwood


> If you insist using the term, please add a comment into the code
> explaining what it is and that the driver does not support it.
>
> Guenter
>
