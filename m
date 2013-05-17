Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:58835 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669Ab3EQK6J (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 May 2013 06:58:09 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so5025266oag.18
        for <linux-watchdog@vger.kernel.org>; Fri, 17 May 2013 03:58:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130504101859.GA15645@samfundet.no>
References: <1367611878-3784-1-git-send-email-sachin.kamat@linaro.org>
	<20130504101859.GA15645@samfundet.no>
Date: Fri, 17 May 2013 16:28:08 +0530
Message-ID: <CAK9yfHzTeG63dZu19n_g3eqArsxzo77ye77S28XwRZBY3FEeEg@mail.gmail.com>
Subject: Re: [PATCH 1/5] watchdog: at32ap700x: Remove redundant platform_set_drvdata()
From: Sachin Kamat <sachin.kamat@linaro.org>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 4 May 2013 15:48, Hans-Christian Egtvedt <egtvedt@samfundet.no> wrote:
> Around Sat 04 May 2013 01:41:14 +0530 or thereabout, Sachin Kamat wrote:
>> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
>> driver is bound) removes the need to set driver data field to
>> NULL.
>
> You are sure cleaning up a lot of drivers, thanks (-:
>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>

Ping on this series Wim.

-- 
With warm regards,
Sachin
