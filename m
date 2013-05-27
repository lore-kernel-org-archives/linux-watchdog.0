Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:32995 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021Ab3E0C7a (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 26 May 2013 22:59:30 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so7586256obc.29
        for <linux-watchdog@vger.kernel.org>; Sun, 26 May 2013 19:59:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALp=xyPyWrjB6+6tjCM5owusHUgu2Ps3q6UjhFUd8RzSNoY+MQ@mail.gmail.com>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
	<1367611878-3784-4-git-send-email-sachin.kamat@linaro.org>
	<CALp=xyPyWrjB6+6tjCM5owusHUgu2Ps3q6UjhFUd8RzSNoY+MQ@mail.gmail.com>
Date: Mon, 27 May 2013 08:29:29 +0530
Message-ID: <CAK9yfHwNikbaMa2z2D0xJWQU3U-kgyb2X-+K+uHxrMzucPmeww@mail.gmail.com>
Subject: Re: [PATCH 4/5] watchdog: ts72xx: Remove redundant platform_set_drvdata()
From: Sachin Kamat <sachin.kamat@linaro.org>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On 6 May 2013 12:32, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> On Fri, May 3, 2013 at 11:11 PM, Sachin Kamat <sachin.kamat@linaro.org>
> wrote:
>>
>> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
>> driver is bound) removes the need to set driver data field to
>> NULL.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Mika Westerberg <mika.westerberg@iki.fi>
>
>
> Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
>

Looks like you missed this patch.

-- 
With warm regards,
Sachin
