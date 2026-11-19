Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795100665;
	b=2BQy7x70ksN3GOwMXAuhnmGP+UNM/gr0YflBlCBf01Vg1Wf5BgElL0uMnhzl4T7zlBor
	 SFQ5MvbVihP/ZxenXrYrqLcy9YafIOrzl8WCYwwzMBlewZxoowx/Pqwovsfr34wCjDoIL
	 eev1E4iXjABbLqnl+AhyUeXZ+CnR8p0/DuqA4FQeFHvO0Uk2VABRnY9Q0xzGr7YYQP88T
	 ZAJlQZtjpOW0fWi7InYLib9l8qekRVAHvvnbsLZ9779NMYn206dyCoWoPUZR3QCwpiLNX
	 neP9EEZoEsMcI4LJhgVAi9OGaM9+xd4nAsu5EBRPaUOQG3AUxGenQIaMURgDMq69EcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=U/xfIUzlZGP18Nh1lgiunUPPO6Hisi4KNm8qpDR6vB8=;
	b=UD0yML3/AG4fknp5/N/9Ml9thdEninJKdxtmUCwkSIhdYTWCXyGdRZn7SuPKuCoRodAX
	 AbutFOVtxjjnJ1j0s7k1aNevS9dOC0tXZXgK2aJm2xevD439oHnU5hPja6pou6z2lbKvV
	 fwNOJZ8sKApyrqrGeg/dfMDd18AfnfrviJzElslUaqpVNd+7crDWltSe+KfKFRuKYtMix
	 OfxS1wSThx/vkS4cYMQYkNqweujvaNg59m8sqSjDilzqGeS4i0LhnDT5gmtJiMGxAv4XC
	 y0MiaoYWPpVavQ/rRdeUcPby2xHmPr8EHYQZiex/THTfjYQygEqn8MtNUTWJIs65aaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b="Xo/dpT5O";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F3606A320
	for <linux-watchdog@vger.kernel.org>; Thu, 19 Nov 2026 15:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B0F3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=Xo/dpT5O
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso1509374f8f.2
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Nov 2026 07:04:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795100663; cv=none;
        d=google.com; s=arc-20260327;
        b=JWnupSfkTwaePPfIZf0shQFIUYQYkjp9PFZKP8/j/qUXtbOj6lCGvHQOnrDbnyh7os
         /cVx2g2oQx+uRaS1rsZN3un9CmS47DC+KU7QAMlQRsIO5u7Pdx0Q8jVLwm7tf+Wuwijf
         vGWABF4HOAut1IdGMuKxpTEiVv9LIgBlv/RYZpIxrDu4mVjJQFrZTPE11SLkYa0vDzkn
         lnBtMUnGsfdRzXVrlvbJaBBEOFwlbdINNZ86ylRmNt3kG56/PXjhhbIZQQP8nKjAB7eN
         QfYHUkkeh3j42YWIRRQIAEvwLukSkEXCQtf8z2TP4MHZlOhIBRPijqB5Ko3c2Tk5WdZE
         qD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U/xfIUzlZGP18Nh1lgiunUPPO6Hisi4KNm8qpDR6vB8=;
        fh=acnN4kw/ShY3M0svh8MLzJ3h3WBa4rwJZfC+K+mmWJc=;
        b=qr8Qm3Eifx5jqeKUMGyiDff4Zizh+UdHkwuY+eyty+zQE54hmPl0Ir6NafTbvcc7rW
         hCB7jrSBTh1Jw/kYyl4WA3uGB/tkgX+8HvMv8fsj315RuuYmKoQxemyNne3mjxlOisgA
         ivBb5Ix3zsQ5T8MzDvO/+mYqRQ48++zalKZVj4LLkWHWMrzvLSC2H1l4nrfeNN8mxP7Y
         BXn7F+uJVcT6jaGTXBrhcT2c2pe3HMXnfrDKMpMBvfpXRmDPNU3XyW9WTaCkNuuoSbUj
         Of1QII1L6LvrlpZqKCfcpow/p6FvMNu/OiKAOzdEj7NtOGAOm0pgjWF/fkKQWVLsggwD
         F7nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795100663; x=1795705463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U/xfIUzlZGP18Nh1lgiunUPPO6Hisi4KNm8qpDR6vB8=;
        b=Xo/dpT5Op3aIYs8USkXdoIeSMH8SlB8sCNBGbHUqU5KVLqPGCu1ufjlYWkjmOZDknK
         9upxw6zS6BrkebMEbRoHQJ/aqZTDyZBeI7OyBSZZ+KcKP1flYE4YcvK7OLZdN7Fd+Y71
         CyFTiVwvSrN+F42G/9p6pl8NJzwUG8oO4rYy24jw21CmhY6ZGEy0YNTcb7YITPd+bRLn
         PTvoEy9T70skcdukPXbU9bjVjiCG6AVMtA8hu6iSEM/Rw0BQBYtuXXETBBgzj7edbkPU
         UGi7vZ6cDPEVDgbMZHI+bmssIVs/9n+kCX6LySqra9yRgtGuMPeFxqydflsTYjsH2y4O
         TgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100663; x=1795705463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/xfIUzlZGP18Nh1lgiunUPPO6Hisi4KNm8qpDR6vB8=;
        b=V5szXTQ5Bqn3eRsxk9ohfRCZQ0ouyehreyMo1XHiZM0JsnAy5clRnCoiDgnXrJz8Jv
         Vtvnz+QlgfanZYF++OdfIIOxYRIdML+/sBo8edyhqZxMWUbhgQDGnsDzUUjIOVhIiTUL
         fJan6VLq3iugECY8wQLTnooTwyPTkzTvPZnyqPBfwLmF7gvGLA25gHHHE/wxwQDXtz7O
         8xfNC4tefPYrVRCR2NNfHgSiT0kPcQ4u4Wc3qnICyja7RO5wuaHfYJIyO8QDRTK6d/LK
         5CY4cRPnB7PEJDneo21AftBpkHz+EL6nyw8C5a/9GIh/VUFWAfbi5aMclpYohWh1vMLt
         11RQ==
X-Forwarded-Encrypted: i=1; AL+hErHU7HZ7Uqi5SdzY8ziVxapo/YZWT28hQKUE9piDoDxswuNSf1p6rAYpBNg9dzzRNmamxgFAbkh03JfnK8zhBw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9aziCPEMQlG84zz6GTIT0dt7HnLqJ8VDPVe7oziQGs0rpZg0/Q
	UuwvmWc7a7raVDEJ6yTQuP1YuK52CvrpCZ7kDP+g5TUOawoN7rvwKXNuTgejFasv98+d8JkQign
	1rpssN66KdH0Px1Ak+2kn/l9A0SmA5xkvVhKT3mWpTg==
X-Gm-Gg: AZFdTZdJhZHMSxPNaqUz2ibapkdvMIBOcKuevIvPle6LGm9UVj2I2dXVVoS3nlW4V+f
	tJWnH0HZdQv+IAGxSRuuX3i2vZfViS2aIJ7GstYSERb274lo769fNHjPv2xZx3Yg7uGw4nygFw7
	hkfEFcD2qOD4YeEY+E8akxIrcdI+2KVstexyYRY+ZU0p9xKGWEgiUC1wQF2mkWqJTMR76dJsIh5
	oUJ0AWJIKm1Fg2U5SftmAwhJ47TbZnT+Upt4LvgzX2svRNkggSSMy0mgDBFGPystTvOWdWe9FB4
	RFfj4J1cKEJ7qcq+OaeMxyd+A/pY4RaQdZWc5c6EUXSmGW9yFQsimgaJqNDjKLZ3Kj8p/QSLlHG
	SVL0X3rEXs9FxU7ewNsxhdIqVXQblitI0YNgnDksxZbbyGR8d1tZn6N+9pUocvg47NUzK8bNNxp
	NsXg7dVG3WmFi42y0K3+UX2XoJWpSBw18kRnJmGgGNfWoazKNnYDcok2g=
X-Received: by 2002:a5d:5d0c:0:b0:4a7:593a:f421 with SMTP id
 ffacd0b85a97d-4a7593af8b3mr11790674f8f.47.1795100662453; Thu, 19 Nov 2026
 07:04:22 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com> <20261118092147.2017658-3-prajwal.n@oss.qualcomm.com>
In-Reply-To: <20261118092147.2017658-3-prajwal.n@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 19 Nov 2026 20:34:10 +0530
X-Gm-Features: Aa3M54qA46P4CBwTVibgo3CkNCtjBKOcB5q3HFcfCaT5Pb10pwRkUMcTPEIId_Q
Message-ID: <CAAhSdy2ZKBc8A522viUWZbn418MC-C2cy7pQYLBFYn4gsTvJ8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] drivers/watchdog: Add RISC-V SBI watchdog driver
To: Prajwal N <prajwal.n@oss.qualcomm.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	wim@linux-watchdog.org, linux@roeck-us.net, radim.krcmar@oss.qualcomm.com, 
	anup.patel@oss.qualcomm.com, linux-riscv@lists.infradead.org, 
	linux-watchdog@vger.kernel.org, prajwal.n.oss@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 2:52=E2=80=AFPM Prajwal N <prajwal.n@oss.qualcomm.c=
om> wrote:
>
> Add the RISCV_SBI_WATCHDOG Kconfig option, which depends on
> RISCV and RISCV_SBI support.

Kconfig option is always needed when adding new driver so
there is not much value in having this statement in commit
description.

>
> Add a watchdog driver for the RISC-V SBI watchdog extension.
> The driver integrates with the Linux watchdog framework to
> configure and control the watchdog. The driver invokes the
> SBI watchdog using the standard SBI calls.
>
> Support pretimeout event notifications using Message Signaled
> Interrupts (MSIs).
>
> Signed-off-by: Prajwal N <prajwal.n@oss.qualcomm.com>
> ---
>  drivers/watchdog/Kconfig         |  10 +
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/riscv_sbi_wdt.c | 436 +++++++++++++++++++++++++++++++
>  3 files changed, 447 insertions(+)
>  create mode 100644 drivers/watchdog/riscv_sbi_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f7d0a0c2c0ef..d6b4e8ccd057 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2164,6 +2164,16 @@ config STARFIVE_WATCHDOG
>           Say Y here to support the watchdog of StarFive JH7100 and JH711=
0
>           SoC. This driver can also be built as a module if choose M.
>
> +config RISCV_SBI_WATCHDOG
> +       tristate "RISC-V SBI based Watchdog support"
> +       depends on RISCV_SBI
> +       default RISCV
> +       select WATCHDOG_CORE

Drop "select WATCHDOG_CORE" instead extend "depends on"
to include WATCHDOG_CORE (just like other watchdog drivers).

You will also need a separate third patch to enable WATCHDOG_CORE
in arch/riscv/configs/defconfig.

> +       help
> +         Say Y here to include support for a watchdog timer
> +         implemented by the Supervisor Binary Interface on RISCV platfor=
ms.
> +         Requires firmware support.
> +
>  # S390 Architecture
>
>  config DIAG288_WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9ac406677aba..c20c43f06ed0 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -202,6 +202,7 @@ obj-$(CONFIG_WATCHDOG_RTAS) +=3D wdrtas.o
>  # RISC-V Architecture
>  obj-$(CONFIG_ATCWDT200_WATCHDOG) +=3D atcwdt200_wdt.o
>  obj-$(CONFIG_STARFIVE_WATCHDOG) +=3D starfive-wdt.o
> +obj-$(CONFIG_RISCV_SBI_WATCHDOG) +=3D riscv_sbi_wdt.o
>
>  # S390 Architecture
>  obj-$(CONFIG_DIAG288_WATCHDOG) +=3D diag288_wdt.o
> diff --git a/drivers/watchdog/riscv_sbi_wdt.c b/drivers/watchdog/riscv_sb=
i_wdt.c
> new file mode 100644
> index 000000000000..026579a3c5cf
> --- /dev/null
> +++ b/drivers/watchdog/riscv_sbi_wdt.c
> @@ -0,0 +1,436 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RISC-V SBI watchdog driver
> + *
> + * Copyright (C) 2026 Qualcomm Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <asm/sbi.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +#include <linux/msi.h>
> +#include <linux/kernel.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irqchip/riscv-imsic.h>
> +
> +#define DRV_NAME            "riscv-sbi-wdt"
> +#define DRV_VERSION         "1.0"
> +
> +/* Watchdog default timeout in seconds */
> +#define SBI_WATCHDOG_DEFAULT_TIMEOUT           60
> +
> +/* MSI capability mask */
> +#define SBI_WATCHDOG_CAP_MSI_SUPPORT_MASK      BIT(1)
> +
> +/* Convert second to microsecond */
> +static inline u32 sec_to_usec(unsigned int sec)
> +{
> +       return (u32)(sec * 1000000ULL);
> +}
> +
> +/* Convert microsecond to second and ceil the result */
> +static inline unsigned int usec_to_sec_ceil(u32 usec)
> +{
> +       return (unsigned int) DIV_ROUND_UP_ULL(usec, 1000000ULL);
> +}
> +
> +/* Convert microsecond to second and floor the result */
> +static inline unsigned int usec_to_sec(u32 usec)
> +{
> +       return (unsigned int) (usec / 1000000ULL);
> +}
> +
> +/* SBI watchdog attributes */
> +struct sbiwdt_attributes {
> +       /* MSI and SSE capability flags */
> +       u32 wdt_capability;
> +       /* Watchdog state */
> +       u32 wdt_state;
> +       /* Minimum watchdog timeout supported in us */
> +       u32 wdt_min_period;
> +       /* Watchdog timeout period in us */
> +       u32 wdt_period;
> +       /* Time left until watchdog expiry in us */
> +       u32 wdt_time_left;
> +       /* Watchdog pretimeout in us */
> +       u32 wdt_notif_time;
> +       /* MSI target address low 32-bit */
> +       u32 wdt_notif_msi_addr_low;
> +       /* MSI target address high 32-bit */
> +       u32 wdt_notif_msi_addr_high;
> +       /* MSI data */
> +       u32 wdt_notif_msi_data;
> +};
> +
> +/* SBI watchdog global structure */
> +struct sbiwdt {
> +       /* Kernel watchdog instance */
> +       struct watchdog_device          wdd;
> +       struct sbiwdt_attributes        attrs;
> +       int                             virq;
> +};
> +
> +/* Watchdog pretimeout expiry handler */
> +static irqreturn_t sbiwdt_pretimeout_handler(int irq, void *dev_id)
> +{
> +       struct sbiwdt *wdt =3D dev_id;
> +
> +       watchdog_notify_pretimeout(&wdt->wdd);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/* Read watchdog attribute */
> +static int sbiwdt_read_attribute(enum sbi_ext_wdt_attribute_id attr_id, =
u32 *attr_val)
> +{
> +       struct sbiret sret;
> +
> +       sret =3D sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_READ_ATTRIBUTE, =
attr_id, 0, 0, 0, 0, 0);
> +       *attr_val =3D sret.value;
> +
> +       return sbi_err_map_linux_errno(sret.error);
> +}
> +
> +/* Write watchdog attribute */
> +static int sbiwdt_write_attribute(enum sbi_ext_wdt_attribute_id attr_id,=
 u32 val)
> +{
> +       struct sbiret sret;
> +
> +       sret =3D sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_WRITE_ATTRIBUTE,=
 attr_id, val, 0, 0, 0, 0);
> +
> +       return sbi_err_map_linux_errno(sret.error);
> +}
> +
> +/* Write the MSI address and data attributes in one SBI call*/
> +static int sbiwdt_write_notif_msi_message(u32 msi_addr_low, u32 msi_addr=
_high, u32 msi_data)
> +{
> +       struct sbiret sret;
> +
> +       sret =3D sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_WRITE_NOTIF_MSI_=
MESSAGE, msi_addr_low,
> +                                                               msi_addr_=
high, msi_data, 0, 0, 0);
> +
> +       return sbi_err_map_linux_errno(sret.error);
> +}
> +
> +/* Start the watchdog */
> +static int sbiwdt_start(struct watchdog_device *wdd)
> +{
> +       struct sbiret sret;
> +
> +       sret =3D sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_START, 0, 0, 0, =
0, 0, 0);
> +
> +       return sbi_err_map_linux_errno(sret.error);
> +}
> +
> +/* Stop the watchdog */
> +static int sbiwdt_stop(struct watchdog_device *wdd)
> +{
> +       struct sbiret sret;
> +
> +       sret =3D sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_STOP, 0, 0, 0, 0=
, 0, 0);
> +
> +       return sbi_err_map_linux_errno(sret.error);
> +}
> +
> +/* Pat the watchdog */
> +static int sbiwdt_pat(struct watchdog_device *wdd)
> +{
> +       struct sbiret sret;
> +
> +       sret =3D sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_PAT, 0, 0, 0, 0,=
 0, 0);
> +
> +       return sbi_err_map_linux_errno(sret.error);
> +}
> +
> +/* Set the watchdog timeout value */
> +static int sbiwdt_set_timeout(struct watchdog_device *wdd, unsigned int =
timeout)
> +{
> +       struct sbiwdt *wdt =3D watchdog_get_drvdata(wdd);
> +       u32 period_usec;
> +       int ret;
> +
> +       if (timeout <=3D wdt->wdd.pretimeout)
> +               return -EINVAL;
> +
> +       period_usec =3D sec_to_usec(timeout);
> +
> +       ret =3D sbiwdt_write_attribute(SBI_WATCHDOG_PERIOD, period_usec);
> +       if (ret)
> +               return ret;
> +
> +       wdt->attrs.wdt_period =3D period_usec;
> +       wdt->wdd.timeout =3D timeout;
> +
> +       return 0;
> +}
> +
> +/* Set the watchdog pretimeout value*/
> +static int sbiwdt_set_pretimeout(struct watchdog_device *wdd, unsigned i=
nt pretimeout)
> +{
> +       struct sbiwdt *wdt =3D watchdog_get_drvdata(wdd);
> +       u32 notif_time_usec;
> +       int ret;
> +
> +       if (pretimeout >=3D wdd->timeout)
> +               return -EINVAL;
> +
> +       notif_time_usec =3D sec_to_usec(pretimeout);
> +       ret =3D sbiwdt_write_attribute(SBI_WATCHDOG_NOTIF_TIME, notif_tim=
e_usec);
> +       if (ret)
> +               return ret;
> +
> +       wdt->wdd.pretimeout =3D pretimeout;
> +       wdt->attrs.wdt_notif_time =3D notif_time_usec;
> +
> +       return ret;
> +}
> +
> +/* Get the watchdog timeleft before expiry */
> +static unsigned int sbiwdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +       struct sbiwdt *wdt =3D watchdog_get_drvdata(wdd);
> +       unsigned int time_left_usec;
> +       int ret;
> +
> +       ret =3D sbiwdt_read_attribute(SBI_WATCHDOG_TIME_LEFT, &time_left_=
usec);
> +       if (ret) {
> +               dev_err(wdt->wdd.parent, "Failed to read watchdog time le=
ft: %d\n", ret);
> +               return 0;
> +       }
> +
> +       return usec_to_sec(time_left_usec);
> +}
> +
> +static const struct watchdog_info sbiwdt_info =3D {
> +       .options        =3D       WDIOF_SETTIMEOUT        |
> +                               WDIOF_KEEPALIVEPING     |
> +                               WDIOF_MAGICCLOSE,
> +       .identity       =3D       DRV_NAME,
> +};
> +
> +static const struct watchdog_info sbiwdt_pretimeout_info =3D {
> +       .options        =3D       WDIOF_SETTIMEOUT                |
> +                               WDIOF_KEEPALIVEPING             |
> +                               WDIOF_MAGICCLOSE                |
> +                               WDIOF_PRETIMEOUT,
> +       .identity       =3D       DRV_NAME,
> +};
> +
> +static const struct watchdog_ops sbiwdt_ops =3D {
> +       .owner          =3D THIS_MODULE,
> +       .start          =3D sbiwdt_start,
> +       .stop           =3D sbiwdt_stop,
> +       .ping           =3D sbiwdt_pat,
> +       .set_timeout    =3D sbiwdt_set_timeout,
> +       .set_pretimeout =3D sbiwdt_set_pretimeout,
> +       .get_timeleft   =3D sbiwdt_get_timeleft,
> +};
> +
> +/* The callback function from IMSIC containing the MSI address and data =
*/
> +static void sbiwdt_msi_write(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +       int ret;
> +       struct device *dev =3D msi_desc_to_dev(desc);
> +       struct sbiwdt *wdt;
> +
> +       if (!dev || !msg)
> +               return;
> +
> +       wdt =3D dev_get_drvdata(dev);
> +       if (!wdt) {
> +               dev_err(dev, "Missing SBI watchdog driver data\n");
> +               return;
> +       }
> +
> +       /* Store MSI info in attributes*/
> +       wdt->attrs.wdt_notif_msi_addr_low =3D msg->address_lo;
> +       wdt->attrs.wdt_notif_msi_addr_high =3D msg->address_hi;
> +       wdt->attrs.wdt_notif_msi_data =3D msg->data;
> +
> +       /* Pass the MSI attribute values to OpenSBI */
> +       ret =3D sbiwdt_write_notif_msi_message(wdt->attrs.wdt_notif_msi_a=
ddr_low,
> +                                               wdt->attrs.wdt_notif_msi_=
addr_high,
> +                                               wdt->attrs.wdt_notif_msi_=
data);
> +       if (ret) {
> +               dev_err(dev, "Failed to configure watchdog MSI: %d\n", re=
t);
> +               return;
> +       }
> +}
> +
> +/* Initialize the watchdog attributes */
> +static int sbiwdt_init_attributes(struct sbiwdt *wdt)
> +{
> +       int ret;
> +       u32 attr_val;
> +       u32 timeout_usec;
> +
> +       /* Read watchdog capability from firmware */
> +       ret =3D sbiwdt_read_attribute(SBI_WATCHDOG_CAPABILITY, &attr_val)=
;
> +       if (ret)
> +               return ret;
> +
> +       wdt->attrs.wdt_capability =3D attr_val;
> +
> +       /* Read watchdog min period supported in firmware */
> +       ret =3D sbiwdt_read_attribute(SBI_WATCHDOG_MIN_PERIOD, &attr_val)=
;
> +       if (ret)
> +               return ret;
> +
> +       if (!attr_val)
> +               attr_val =3D 1;
> +
> +       wdt->attrs.wdt_min_period =3D attr_val;
> +       wdt->wdd.min_timeout =3D usec_to_sec_ceil(wdt->attrs.wdt_min_peri=
od);
> +
> +       /* Initialize the watchdog timeout to default value */
> +       timeout_usec =3D sec_to_usec(SBI_WATCHDOG_DEFAULT_TIMEOUT);
> +       ret =3D sbiwdt_write_attribute(SBI_WATCHDOG_PERIOD, timeout_usec)=
;
> +       if (ret)
> +               return ret;
> +
> +       wdt->attrs.wdt_period =3D timeout_usec;
> +       wdt->wdd.timeout =3D SBI_WATCHDOG_DEFAULT_TIMEOUT;
> +       wdt->wdd.max_timeout =3D U32_MAX / USEC_PER_SEC;
> +
> +       /* Initialize the pretimeout to default value */
> +       wdt->attrs.wdt_notif_time =3D 0;
> +       wdt->wdd.pretimeout =3D 0;
> +
> +       return 0;
> +}
> +
> +/* Callback from devm for MSI cleanup */
> +static void sbiwdt_msi_free_irqs(void *dev)
> +{
> +       platform_device_msi_free_irqs_all((struct device *) dev);
> +}
> +
> +static int sbiwdt_probe(struct platform_device *pdev)
> +{
> +       struct sbiwdt *wdt;
> +       const struct imsic_global_config *imsic_global;
> +       struct irq_domain *msi_domain;
> +       struct device *dev =3D &pdev->dev;
> +       int rc;
> +
> +       /* Allocate memory for the global watchdog structure */
> +       wdt =3D devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +       if (!wdt)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, wdt);
> +       watchdog_set_drvdata(&wdt->wdd, wdt);
> +
> +       /* Initialiaze watchdog attributes */
> +       rc =3D sbiwdt_init_attributes(wdt);
> +       if (rc)
> +               return dev_err_probe(dev, rc, "Failed to read SBI watchdo=
g attributes\n");
> +
> +       wdt->wdd.parent =3D dev;
> +       wdt->wdd.info =3D &sbiwdt_info;
> +       wdt->wdd.ops =3D &sbiwdt_ops;
> +
> +       watchdog_stop_on_unregister(&wdt->wdd);
> +       watchdog_stop_on_reboot(&wdt->wdd);
> +
> +       /* Setup MSI if the capability is available */
> +       if (wdt->attrs.wdt_capability & SBI_WATCHDOG_CAP_MSI_SUPPORT_MASK=
) {
> +               imsic_global =3D imsic_get_global_config();
> +               if (!imsic_global)
> +                       return dev_err_probe(dev, -ENODEV, "IMSIC firmwar=
e node is unavailable\n");
> +
> +               msi_domain =3D irq_find_matching_fwnode(imsic_global->fwn=
ode,
> +                                                       DOMAIN_BUS_PLATFO=
RM_MSI);
> +
> +               if (!msi_domain)
> +                       return dev_err_probe(dev, -ENODEV,
> +                                            "IMSIC platform MSI domain i=
s unavailable\n");
> +
> +               dev_set_msi_domain(&pdev->dev, msi_domain);
> +
> +               /* MSI setup */
> +               rc =3D platform_device_msi_init_and_alloc_irqs(dev, 1, sb=
iwdt_msi_write);
> +               if (rc)
> +                       return dev_err_probe(dev, rc, "Failed to allocate=
 MSIs\n");
> +
> +               /* Register with devm the MSI cleanup callback */
> +               rc =3D devm_add_action_or_reset(dev, sbiwdt_msi_free_irqs=
, dev);
> +               if (rc)
> +                       return dev_err_probe(dev, rc, "Failed to add sbiw=
dt MSI cleanup\n");
> +
> +               /* Enable pretimeout only when the MSI is allocated */
> +               wdt->wdd.info =3D &sbiwdt_pretimeout_info;
> +
> +               wdt->virq =3D msi_get_virq(dev, 0);
> +               if (!wdt->virq)
> +                       return dev_err_probe(dev, -ENODEV, "Failed to get=
 MSI virtual IRQ\n");
> +
> +               rc =3D devm_request_irq(dev, wdt->virq,
> +                                       sbiwdt_pretimeout_handler,
> +                                       0, "sbiwdt-pretimeout", wdt);
> +               if (rc)
> +                       return dev_err_probe(dev, rc, "Failed to request =
pretimeout IRQ\n");
> +       }
> +
> +       rc =3D devm_watchdog_register_device(dev, &wdt->wdd);
> +       if (rc)
> +               return dev_err_probe(dev, rc, "Failed to register RISC-V =
SBI watchdog device\n");
> +
> +       dev_info(&pdev->dev, "RISC-V SBI Watchdog registered\n");
> +
> +       return 0;
> +}
> +
> +static struct platform_driver sbiwdt_driver =3D {
> +       .driver =3D {
> +                       .name =3D DRV_NAME,
> +       },
> +       .probe  =3D sbiwdt_probe,
> +};
> +
> +static struct platform_device *sbiwdt_pdev;
> +
> +static void __exit sbiwdt_exit(void)
> +{
> +       platform_device_unregister(sbiwdt_pdev);
> +       platform_driver_unregister(&sbiwdt_driver);
> +}
> +
> +static int __init sbiwdt_init(void)
> +{
> +       int ret;
> +       struct platform_device *pdev;
> +
> +       /* Probe for SBI WDT extension */
> +       if (sbi_spec_version < sbi_mk_version(3, 0) ||
> +               sbi_probe_extension(SBI_EXT_WDT) <=3D 0) {
> +               return -ENODEV;
> +       }
> +
> +       ret =3D platform_driver_register(&sbiwdt_driver);
> +       if (ret)
> +               return ret;
> +
> +       pdev =3D platform_device_register_simple(DRV_NAME, -1, NULL, 0);
> +       if (IS_ERR(pdev)) {
> +               platform_driver_unregister(&sbiwdt_driver);
> +               return PTR_ERR(pdev);
> +       }
> +
> +       sbiwdt_pdev =3D pdev;
> +
> +       return 0;
> +}
> +late_initcall(sbiwdt_init);
> +module_exit(sbiwdt_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Prajwal N <prajwal.n@oss.qualcomm.com>");
> +MODULE_DESCRIPTION("RISC-V SBI Watchdog Driver");
> --
> 2.43.0
>

Regards,
Anup
