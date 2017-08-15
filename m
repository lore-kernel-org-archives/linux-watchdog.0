Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:38238 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbdHOIUV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Aug 2017 04:20:21 -0400
Received: by mail-wr0-f179.google.com with SMTP id m57so945895wrm.5
        for <linux-watchdog@vger.kernel.org>; Tue, 15 Aug 2017 01:20:21 -0700 (PDT)
Date: Tue, 15 Aug 2017 09:20:17 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] Immutable branch between MFD, ARM, USB and Video due for
 the v4.14 merge window
Message-ID: <20170815082017.6k4xf3hp5wpabzrc@dell>
References: <20170814163424.2197-1-wsa@the-dreams.de>
 <20170814163424.2197-3-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170814163424.2197-3-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Enjoy!

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-arm-usb-video-v4.14

for you to fetch changes up to 9787076c43a86f3465d46aa344cc3e2f607ae72f:

  mfd: tps65010: Move header file out of I2C realm (2017-08-15 08:27:22 +0100)

----------------------------------------------------------------
Immutable branch between MFD, ARM, USB and Video due for the v4.14 merge window
----------------------------------------------------------------
Wolfram Sang (1):
      mfd: tps65010: Move header file out of I2C realm

 arch/arm/mach-omap1/board-h2-mmc.c      | 2 +-
 arch/arm/mach-omap1/board-h2.c          | 2 +-
 arch/arm/mach-omap1/board-h3-mmc.c      | 2 +-
 arch/arm/mach-omap1/board-h3.c          | 2 +-
 arch/arm/mach-omap1/board-osk.c         | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c     | 2 +-
 drivers/mfd/tps65010.c                  | 2 +-
 drivers/usb/host/ohci-omap.c            | 2 +-
 drivers/usb/phy/phy-isp1301-omap.c      | 2 +-
 drivers/video/fbdev/omap/lcd_h3.c       | 2 +-
 include/linux/{i2c => mfd}/tps65010.h   | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)
 rename include/linux/{i2c => mfd}/tps65010.h (99%)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
