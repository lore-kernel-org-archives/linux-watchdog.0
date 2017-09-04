Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36844 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753905AbdIDRg1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 4 Sep 2017 13:36:27 -0400
MIME-Version: 1.0
In-Reply-To: <20170819221823.13850-7-hauke@hauke-m.de>
References: <20170819221823.13850-1-hauke@hauke-m.de> <20170819221823.13850-7-hauke@hauke-m.de>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 4 Sep 2017 19:36:06 +0200
Message-ID: <CAFBinCACuJ8gs+k4hu+JqpbfS2oJyu2di_2rqqyAFxh8kDOivw@mail.gmail.com>
Subject: Re: [PATCH v10 06/16] MIPS: lantiq: Enable MFD_SYSCON to be able to
 use it for the RCU MFD
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Aug 20, 2017 at 12:18 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/mips/lantiq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
> index 177769dbb0e8..f5db4a426568 100644
> --- a/arch/mips/lantiq/Kconfig
> +++ b/arch/mips/lantiq/Kconfig
> @@ -17,6 +17,7 @@ config SOC_XWAY
>         bool "XWAY"
>         select SOC_TYPE_XWAY
>         select HW_HAS_PCI
> +       select MFD_SYSCON
>
>  config SOC_FALCON
>         bool "FALCON"
> --
> 2.11.0
>
