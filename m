Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37779 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbbEHEvH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 May 2015 00:51:07 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YqaFf-000WTL-38
	for linux-watchdog@vger.kernel.org; Fri, 08 May 2015 04:51:07 +0000
Message-ID: <554C40B7.9060806@roeck-us.net>
Date: Thu, 07 May 2015 21:51:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Doug Anderson <dianders@chromium.org>, wim@iguana.be
CC: jszhang@marvell.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: dw_wdt: No need for a spinlock
References: <1431059265-9204-1-git-send-email-dianders@chromium.org>
In-Reply-To: <1431059265-9204-1-git-send-email-dianders@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/07/2015 09:27 PM, Doug Anderson wrote:
> Right now the dw_wdt uses a spinlock to protect dw_wdt_open().  The
> problem is that while holding the spinlock we call:
> -> dw_wdt_set_top()
>     -> dw_wdt_top_in_seconds()
>        -> clk_get_rate()
>           -> clk_prepare_lock()
>              -> mutex_lock()
>
> Locking a mutex while holding a spinlock is not allowed and leads to
> warnings like "BUG: spinlock wrong CPU on CPU#1", among other
> problems.
>
> There's no reason to use a spinlock.  Only dw_wdt_open() was protected
> and the test_and_set_bit() at the start of that function protects us
> anyway.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

