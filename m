Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37885 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdE3JJ7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 May 2017 05:09:59 -0400
Received: by mail-wm0-f42.google.com with SMTP id d127so88810207wmf.0
        for <linux-watchdog@vger.kernel.org>; Tue, 30 May 2017 02:09:58 -0700 (PDT)
Date: Tue, 30 May 2017 10:09:53 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [RESEND PATCH V7 7/7] MAINTAINERS: da9062/61 updates to the
 Dialog Semiconductor search terms
Message-ID: <20170530090953.bcrsclh77uwvtjzi@dell>
References: <cover.1495546845.git.stwiss.opensource@diasemi.com>
 <d1c3ceda19be1363cd37bb52fd7fae5b1b9a164e.1495546845.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1c3ceda19be1363cd37bb52fd7fae5b1b9a164e.1495546845.git.stwiss.opensource@diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 23 May 2017, Steve Twiss wrote:

> From: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> Additions to search terms for files supported by Dialog Semiconductor.
> This update will allow Dialog support to follow files for device tree
> bindings (onkey, thermal and watchdog) and source code for chip thermal
> monitoring drivers.
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ---
> Hi all,
>=20
> Is there anybody willing to take this patch through their tree please?
>=20
> Dialog Semiconductor support would like to add to the MAINTAINERS searc=
h
> terms. This update will allow us to follow all of our files for device
> tree bindings and the source code relating to chip thermal monitoring
> described in this patch set.
>=20
> All dependencies for this patch have been accepted into linux-next:
>=20
> bindings/input/da90??-onkey.txt     -> linux-next.git/commit/?id=3D406d=
5a2de0718622241eff35831f6fed0316a7d4
> bindings/thermal/da90??-thermal.txt -> linux-next.git/commit/?id=3D28c1=
b08d2a156ef16e912a4c618a529e586e5dbc
> bindings/watchdog/da92??-wdt.txt    -> linux-next.git/commit/?id=3Dbe62=
f363a8d5b1703c08d2cb462786a68215bcca
> drivers/thermal/da90??-thermal.c    -> linux-next.git/commit/?id=3D6085=
67aac3206ae886c79688fbb8a62c473b55ef
>=20
> Regards,
> Steve Twiss, Dialog Semiconductor
>=20
>=20
> This patch applies against linux-next and v4.12-rc2
>=20
> v6 -> v7
>  - NO CODE CHANGE
>  - Rebased from v4.11-rc3 to v4.11-rc11
>  - Updated the commit message
>  - Moved the following names from CC: to TO: e-mail fields
>    - Lee Jones
>    - Liam Girdwood
>    - Mark Brown
>=20
> v5 -> v6
>  - NO CODE CHANGE
>  - Rebased from v4.8 to v4.11-rc3
>  - Patch renamed from [PATCH V5 8/8] to [PATCH V5 7/7]
>=20
> v4 -> v5
>  - NO CODE CHANGE
>  - Rebased from v4.8 to v4.9
>=20
> v3 -> v4
>  - NO CODE CHANGE
>  - Patch renamed from [PATCH V3 9/9] to [PATCH V4 8/8]
>=20
> v2 -> v3
>  - NO CODE CHANGE
>  - Patch renamed from [PATCH V2 10/10] to [PATCH V3 9/9]
>=20
> v1 -> v2
>  - NO CODE CHANGE
>=20
>=20
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e98464..a580bed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3988,7 +3988,10 @@ W:	http://www.dialog-semiconductor.com/products
>  S:	Supported
>  F:	Documentation/hwmon/da90??
>  F:	Documentation/devicetree/bindings/mfd/da90*.txt
> +F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
> +F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
>  F:	Documentation/devicetree/bindings/regulator/da92*.txt
> +F:	Documentation/devicetree/bindings/watchdog/da92??-wdt.txt
>  F:	Documentation/devicetree/bindings/sound/da[79]*.txt
>  F:	drivers/gpio/gpio-da90??.c
>  F:	drivers/hwmon/da90??-hwmon.c
> @@ -4003,6 +4006,7 @@ F:	drivers/power/supply/da9052-battery.c
>  F:	drivers/power/supply/da91??-*.c
>  F:	drivers/regulator/da903x.c
>  F:	drivers/regulator/da9???-regulator.[ch]
> +F:	drivers/thermal/da90??-thermal.c
>  F:	drivers/rtc/rtc-da90??.c
>  F:	drivers/video/backlight/da90??_bl.c
>  F:	drivers/watchdog/da90??_wdt.c

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
