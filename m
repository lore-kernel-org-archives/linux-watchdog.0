Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37472 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945934AbbDXTc7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Apr 2015 15:32:59 -0400
Received: by igblo3 with SMTP id lo3so22746161igb.0
        for <linux-watchdog@vger.kernel.org>; Fri, 24 Apr 2015 12:32:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1429902534-2348-2-git-send-email-eric@anholt.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net> <1429902534-2348-2-git-send-email-eric@anholt.net>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 24 Apr 2015 15:32:28 -0400
Message-ID: <CAJhHMCAz3ichPmTvdeXx+6+JK7uNvfyh4m4_Jg8mFYi5ZcHRNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to
 the WDT driver.
To: Eric Anholt <eric@anholt.net>
Cc: "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	"open list:WATCHDOG DEVICE D..." <linux-watchdog@vger.kernel.org>,
	linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Apr 24, 2015 at 3:08 PM, Eric Anholt <eric@anholt.net> wrote:
> Since the WDT is what's used to drive restart and power off, it makes
> more sense to keep it there, where the regs are already mapped and
> definitions for them provided.  Note that this means you may need to
> add CONFIG_BCM2835_WDT to retain functionality of your kernel.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: linux-watchdog@vger.kernel.org


Any reason not to select BCM2835_WDT in the config by default then?

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8b11f44..dd4856d 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -116,6 +116,7 @@ config ARCH_BCM2835
        select CLKSRC_OF
        select PINCTRL
        select PINCTRL_BCM2835
+       select BCM2835_WDT
        help
          This enables support for the Broadcom BCM2835 SoC. This SoC is
          used in the Raspberry Pi and Roku 2 devices.



-- 
Pranith
