Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:50972 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab3FAIQ5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 1 Jun 2013 04:16:57 -0400
Message-ID: <51A9ADF4.8010102@gmail.com>
Date: Sat, 01 Jun 2013 10:16:52 +0200
From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
To: Tomasz Figa <tomasz.figa@gmail.com>
CC: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	=?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, jhbird.choi@samsung.com
Subject: Re: [PATCH 0/6] Samsung watchdog support clean-up
References: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tomasz,

On 05/19/2013 12:37 AM, Tomasz Figa wrote:
> This series is aiming at cleaning up a bit watchdog support on Samsung
> SoCs. The patches tweak a bit all the watchdog handling code here and
> there, with the goal of making it DT- and multiplatform-friendly.
>
> See particular patches for more detailed descriptions.
>
> On S3C6410-based Tiny6410 board (Mini6410-compatible):
>
> Tested-by: Tomasz Figa<tomasz.figa@gmail.com>

I've tested this series on a s3c2440 based board. The system restart
works fine.

Tested-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

> Depends on:
>   - [PATCH] ARM: s5p64x0: Use common uncompress.h part for plat-samsung
>
> Tomasz Figa (6):
>    watchdog: s3c2410_wdt: Use local register definitions
>    ARM: SAMSUNG: uncompress: Use local definitions of watchdog registers
>    ARM: SAMSUNG: Add watchdog reset driver
>    ARM: SAMSUNG: Let platforms use the new watchdog reset driver
>    ARM: SAMSUNG: Remove legacy watchdog reset code
>    ARM: SAMSUNG: Remove unused plat/regs-watchdog.h header
>
>   arch/arm/Kconfig                                   |  3 +
>   arch/arm/mach-s3c24xx/Kconfig                      |  2 +
>   arch/arm/mach-s3c24xx/s3c2410.c                    |  3 +-
>   arch/arm/mach-s3c24xx/s3c244x.c                    |  3 +-
>   arch/arm/mach-s3c64xx/common.c                     |  8 +-
>   arch/arm/mach-s5p64x0/common.c                     |  4 +-
>   arch/arm/mach-s5pc100/common.c                     |  3 +-
>   arch/arm/plat-samsung/Kconfig                      |  6 ++
>   arch/arm/plat-samsung/Makefile                     |  1 +
>   arch/arm/plat-samsung/include/plat/regs-watchdog.h | 41 ---------
>   arch/arm/plat-samsung/include/plat/uncompress.h    | 15 +++-
>   .../arm/plat-samsung/include/plat/watchdog-reset.h | 38 ++-------
>   arch/arm/plat-samsung/watchdog-reset.c             | 97 ++++++++++++++++++++++
>   drivers/watchdog/s3c2410_wdt.c                     | 17 +++-
>   14 files changed, 156 insertions(+), 85 deletions(-)
>   delete mode 100644 arch/arm/plat-samsung/include/plat/regs-watchdog.h
>   create mode 100644 arch/arm/plat-samsung/watchdog-reset.c>

--
Regards,
Sylwester
