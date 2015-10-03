Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34266 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbbJCWN1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 3 Oct 2015 18:13:27 -0400
Received: by iow1 with SMTP id 1so115879367iow.1
        for <linux-watchdog@vger.kernel.org>; Sat, 03 Oct 2015 15:13:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443909258-24914-1-git-send-email-harald@ccbib.org>
References: <1443909258-24914-1-git-send-email-harald@ccbib.org>
Date: Sat, 3 Oct 2015 19:13:26 -0300
Message-ID: <CAOMZO5A=dUVUXh+-zYBq6F9FGwk2rRiqS2PXfOLrsAqHKpDyBA@mail.gmail.com>
Subject: Re: [PATCHv2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
From: Fabio Estevam <festevam@gmail.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>, rtc-linux@googlegroups.com,
	linux-watchdog@vger.kernel.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Harald,

On Sat, Oct 3, 2015 at 6:54 PM, Harald Geyer <harald@ccbib.org> wrote:
> When the watchdog is enabled, we set a persitent bit. After booting
> we query the bit and see if the system was reset by the watchdog.
>
> This is somewhat similar to what the legacy driver from freescale
> does. However we use STMP3XXX_RTC_PERSISTENT2 instead of
> STMP3XXX_RTC_PERSISTENT1. I tried that first, but it seems I can't
> clear the bit there once it is set. I didn't find any documentation
> what this register does - only vague hints that it is meant to
> control the boot ROM.
>
> Part of the code from the legacy driver touching this register
> is still included. Maybe this is stale, but this patch doesn't
> touch any of it because I don't know what it really does or is
> meant to do.
>
> Signed-off-by: Harald Geyer <harald@ccbib.org>

I read your commit log, but it is not clear for me what is the real
issue you are trying to solve with this patch.

Please clarify.

Regards,

Fabio Estevam
