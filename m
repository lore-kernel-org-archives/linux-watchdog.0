Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35606 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab3E0F56 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 May 2013 01:57:58 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so324419obc.23
        for <linux-watchdog@vger.kernel.org>; Sun, 26 May 2013 22:57:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130527054318.GD14155@spo001.leaseweb.com>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
	<1367611878-3784-4-git-send-email-sachin.kamat@linaro.org>
	<CALp=xyPyWrjB6+6tjCM5owusHUgu2Ps3q6UjhFUd8RzSNoY+MQ@mail.gmail.com>
	<CAK9yfHwNikbaMa2z2D0xJWQU3U-kgyb2X-+K+uHxrMzucPmeww@mail.gmail.com>
	<20130527054318.GD14155@spo001.leaseweb.com>
Date: Mon, 27 May 2013 11:27:57 +0530
Message-ID: <CAK9yfHwdZ_KFK_RdYXXX=-p8FCwu+HsUHLk+H=syJ8busn8FLA@mail.gmail.com>
Subject: Re: [PATCH 4/5] watchdog: ts72xx: Remove redundant platform_set_drvdata()
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On 27 May 2013 11:13, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Sachin,
>
>> On 6 May 2013 12:32, Mika Westerberg <mika.westerberg@iki.fi> wrote:
>> > On Fri, May 3, 2013 at 11:11 PM, Sachin Kamat <sachin.kamat@linaro.org>
>> > wrote:
>> >>
>> >> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
>> >> driver is bound) removes the need to set driver data field to
>> >> NULL.
>> >>
>> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> >> Cc: Mika Westerberg <mika.westerberg@iki.fi>
>> >
>> >
>> > Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
>> >
>>
>> Looks like you missed this patch.
>
> Not really, It was allready covered in Jingoo's patch so there
> was no need to do this anymore.

Oh OK.
Thanks for applying all other patches.


-- 
With warm regards,
Sachin
