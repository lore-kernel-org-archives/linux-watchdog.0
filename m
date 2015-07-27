Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36656 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbbG0Pdu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 11:33:50 -0400
Received: by wicgb10 with SMTP id gb10so117817154wic.1
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Jul 2015 08:33:49 -0700 (PDT)
Date: Mon, 27 Jul 2015 16:33:44 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150727153344.GC21114@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 27 Jul 2015, Matt Fleming wrote:

> From: Matt Fleming <matt.fleming@intel.com>
>=20
> Intel Sunrisepoint (Skylake PCH) has the iTCO watchdog accessible acr=
oss
> the SMBus, unlike previous generations of PCH/ICH where it was on the
> LPC bus. Because it's on the SMBus, it doesn't make sense to pass aro=
und
> a 'struct lpc_ich_info', and leaking the type of bus into the iTCO
> watchdog driver is kind of backwards anyway.
>=20
> This change introduces a new 'struct iTCO_wdt_platform_data' for use
> inside the iTCO watchdog driver and by the upcoming Intel Sunrisepoin=
t
> code, which neatly avoids having to include lpc_ich headers in the i8=
01
> i2c driver.
>=20
> A simple translation layer is provided for converting from the existi=
ng
> 'struct lpc_ich_info' inside the lpc_ich mfd driver.

Is this patch related to Andy's patch-set?

  https://lkml.org/lkml/2015/7/27/599

> Cc: Peter Tyser <ptyser@xes-inc.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> ---
>  drivers/mfd/lpc_ich.c                  | 32 ++++++++++++++++++++++++=
+++++---
>  drivers/watchdog/Kconfig               |  2 +-
>  drivers/watchdog/iTCO_wdt.c            | 11 +++++------
>  include/linux/mfd/lpc_ich.h            |  6 ------
>  include/linux/platform_data/iTCO_wdt.h | 18 ++++++++++++++++++
>  5 files changed, 53 insertions(+), 16 deletions(-)
>  create mode 100644 include/linux/platform_data/iTCO_wdt.h

How are all of these changes related?

Why do they all have to be in a single patch?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
