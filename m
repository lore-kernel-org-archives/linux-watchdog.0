Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:38581 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaJIMNJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 9 Oct 2014 08:13:09 -0400
Received: by mail-oi0-f50.google.com with SMTP id i138so2396272oig.23
        for <linux-watchdog@vger.kernel.org>; Thu, 09 Oct 2014 05:13:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20141009120838.GA12751@mwanda>
References: <20141009120838.GA12751@mwanda>
Date: Thu, 9 Oct 2014 14:13:08 +0200
Message-ID: <CAOQ7t2am6z0nngwQJngwCujrELOk+vKLeGBBFb93kpzW=x8p9g@mail.gmail.com>
Subject: Re: ARM: meson: add watchdog driver
From: Carlo Caione <carlo@caione.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Carlo Caione <carlo@caione.org>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 9, 2014 at 2:08 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Carlo Caione,

Hi Dan,

> The patch 2b0523c42849: "ARM: meson: add watchdog driver" from Sep
> 20, 2014, leads to the following static checker warning:
>
>         drivers/watchdog/meson_wdt.c:54 meson_restart_handle()
>         warn: was hexadecimal intended '100'

Good catch,

> drivers/watchdog/meson_wdt.c
>    51  static int meson_restart_handle(struct notifier_block *this, unsigned long mode,
>     52                                  void *cmd)
>     53  {
>     54          u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN | 100;
>                                                                        ^^^
> Is it supposed to be 0x100 here?  Anyway, magic numbers are bad so this
> should be changed probably.

Yes. It is actually an arbitrary really small value. Nothing special.
I'll submit a patch to fix it with your Reported-by

Thank you,


-- 
Carlo Caione
