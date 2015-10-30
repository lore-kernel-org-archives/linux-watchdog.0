Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37699 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760068AbbJ3SEG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 14:04:06 -0400
Received: by wmff134 with SMTP id f134so17817811wmf.0
        for <linux-watchdog@vger.kernel.org>; Fri, 30 Oct 2015 11:04:05 -0700 (PDT)
Date: Fri, 30 Oct 2015 18:04:00 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 1/5] of: add vendor prefix for Technologic Systems
Message-ID: <20151030180400.GG4058@x1>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446150450-22093-2-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1446150450-22093-2-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 29 Oct 2015, Damien Riegel wrote:

> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/=
Documentation/devicetree/bindings/vendor-prefixes.txt
> index d444757..68aad78a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -211,6 +211,7 @@ toshiba	Toshiba Corporation
>  toumaz	Toumaz
>  tplink	TP-LINK Technologies Co., Ltd.
>  truly	Truly Semiconductors Limited
> +ts	Technologic Systems
>  usi	Universal Scientific Industrial Co., Ltd.
>  v3	V3 Semiconductor
>  variscite	Variscite Ltd.

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
