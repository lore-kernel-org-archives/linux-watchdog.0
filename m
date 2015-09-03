Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41845 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbbICDCF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Sep 2015 23:02:05 -0400
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com [209.85.213.170])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: timur@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 55884140D2B
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2015 03:02:02 +0000 (UTC)
Received: by igcrk20 with SMTP id rk20so39877165igc.1
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Sep 2015 20:02:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1435596377-17737-1-git-send-email-timur@codeaurora.org>
References: <1435596377-17737-1-git-send-email-timur@codeaurora.org>
Date: Wed, 2 Sep 2015 22:02:01 -0500
Message-ID: <CAOZdJXW9Z6FniAi5Js=L-ZiKqK=VuH9PbnGUzBro9MOZ7aDA8Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation/watchdog: add timeout and ping rate control
 to watchdog-test.c
From: Timur Tabi <timur@codeaurora.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jun 29, 2015 at 11:46 AM, Timur Tabi <timur@codeaurora.org> wrote:
> The watchdog test program is much more useful if it can configure the
> timeout value and ping rate.  This will allow you to test actual timeouts.
>
> Adds the -t parameter to set the timeout value (in seconds), and -p to set
> the ping rate (number of seconds between pings).
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Wim, can you take this patch for 4.3?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
