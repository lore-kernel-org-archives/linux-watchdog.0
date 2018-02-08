Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:43547 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeBHI6Z (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 8 Feb 2018 03:58:25 -0500
Received: by mail-io0-f179.google.com with SMTP id 72so5031193iom.10
        for <linux-watchdog@vger.kernel.org>; Thu, 08 Feb 2018 00:58:25 -0800 (PST)
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Feb 2018 09:58:24 +0100
Message-ID: <CACRpkdb9roNoC-OvJPVumffr_-NwUtrsWczM2jGj8bv_9KiJaw@mail.gmail.com>
Subject: GPIO WDT and open drain
To: Alexander Shiyan <shc_work@mail.ru>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

I converted your driver for GPIO watchdog to use GPIO descriptors
in the last merge window.

It seems there is no upstream device tree for this driver, so I guess
you have some system using it, and it would be nice to hear if you
can confirm that it still works for you.

I was thinking a bit about this code:

        /* Put GPIO back to tristate */
        if (priv->hw_algo == HW_ALGO_TOGGLE)
                gpiod_direction_input(priv->gpiod);

I think the right thing is to remove these lines and instead use
this in the device tree:

gpios = <&gpio0 5 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

Also we should update the DTS example to use open drain.

This will fall back to software emulation setting the line as input
to drive it high just like the driver does if the hardware doesn't have
explicit open drain support.

The semantic effect would be that the open drain semantic will
be used also when pinging the watchdog, i.e the line will be set
as input to pull the line high. AFAICT this should work, but
obviously it needs to be tested on hardware.

Yours,
Linus Walleij
