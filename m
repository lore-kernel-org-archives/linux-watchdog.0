Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:38872 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbdHOHN2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Aug 2017 03:13:28 -0400
Received: by mail-wr0-f175.google.com with SMTP id m57so513109wrm.5
        for <linux-watchdog@vger.kernel.org>; Tue, 15 Aug 2017 00:13:27 -0700 (PDT)
Date: Tue, 15 Aug 2017 08:13:24 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [GIT PULL] Immutable branch between MFD, Input and RTC due for the
 v3.14 merge window
Message-ID: <20170815071324.uh74pxo6puhh3qqm@dell>
References: <20170814163424.2197-1-wsa@the-dreams.de>
 <20170814163424.2197-2-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170814163424.2197-2-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Enjoy!

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-rtc-v4.14

for you to fetch changes up to 0335a9554b4d6acc2d17efe752bff54ce59b57eb:

  mfd: dm355evm_msp: Move header file out of I2C realm (2017-08-15 08:06:14 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Input and RTC due for the v3.14 merge window

----------------------------------------------------------------
Wolfram Sang (1):
      mfd: dm355evm_msp: Move header file out of I2C realm

 drivers/input/misc/dm355evm_keys.c        | 2 +-
 drivers/mfd/dm355evm_msp.c                | 2 +-
 drivers/rtc/rtc-dm355evm.c                | 2 +-
 include/linux/{i2c => mfd}/dm355evm_msp.h | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/linux/{i2c => mfd}/dm355evm_msp.h (100%)
 
-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
