Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53501 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579AbbHIU6V (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 9 Aug 2015 16:58:21 -0400
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com [209.85.213.178])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: timur@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 5401913FC34
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2015 20:58:20 +0000 (UTC)
Received: by igbpg9 with SMTP id pg9so58381351igb.0
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2015 13:58:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOZdJXWbbWQr8wGJ0R9-gSrT+U+p+6Sz_NaFFWcZSZ8qmjxJiA@mail.gmail.com>
References: <1435596377-17737-1-git-send-email-timur@codeaurora.org>
	<CAOZdJXWbbWQr8wGJ0R9-gSrT+U+p+6Sz_NaFFWcZSZ8qmjxJiA@mail.gmail.com>
Date: Sun, 9 Aug 2015 13:58:19 -0700
Message-ID: <CAOZdJXUY2j9fNsY1S0H3C6zJ4+OMsL0c5FuPxsae+q4g3wE80Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation/watchdog: add timeout and ping rate control
 to watchdog-test.c
From: Timur Tabi <timur@codeaurora.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jul 22, 2015 at 8:56 PM, Timur Tabi <timur@codeaurora.org> wrote:
> On Mon, Jun 29, 2015 at 11:46 AM, Timur Tabi <timur@codeaurora.org> wrote:
>> The watchdog test program is much more useful if it can configure the
>> timeout value and ping rate.  This will allow you to test actual timeouts.
>>
>> Adds the -t parameter to set the timeout value (in seconds), and -p to set
>> the ping rate (number of seconds between pings).
>>
>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>
> Wim, any chance of getting this patch into 4.2?

Wim?  If not 4.2, then 4.3?  I think it's a pretty harmless patch, and
it works well for us.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
