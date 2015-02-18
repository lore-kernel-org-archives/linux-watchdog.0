Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:48619 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbbBRJeL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Feb 2015 04:34:11 -0500
Received: by mail-wi0-f182.google.com with SMTP id l15so738244wiw.3
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Feb 2015 01:34:10 -0800 (PST)
Date: Wed, 18 Feb 2015 09:34:03 +0000
From: Lee Jones <lee.jones@linaro.org>
To: David Paris <david.paris@st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux@roeck-us.net
Subject: Re: [PATCH v2 4/9] ARM: STi: DT: STiH407: Add Device Tree node for
 the LPC
Message-ID: <20150218093403.GB18042@x1>
References: <1421927767-28889-1-git-send-email-lee.jones@linaro.org>
 <1421927767-28889-5-git-send-email-lee.jones@linaro.org>
 <54C208D9.6050006@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <54C208D9.6050006@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 23 Jan 2015, David Paris wrote:
> On 01/22/2015 12:56 PM, Lee Jones wrote:
> >On current ST platforms the LPC controls a number of functions.  Thi=
s
> >patch enables support for the LPC Watchdog and LPC RTC devices on LP=
C1
> >and LPC2 respectively.
> >
> >Signed-off-by: David Paris <david.paris@st.com>
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >---
> >  arch/arm/boot/dts/stih407-family.dtsi | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/d=
ts/stih407-family.dtsi
> >index 3e31d32..04448a7 100644
> >--- a/arch/arm/boot/dts/stih407-family.dtsi
> >+++ b/arch/arm/boot/dts/stih407-family.dtsi
> >@@ -7,6 +7,7 @@
> >   * publishhed by the Free Software Foundation.
> >   */
> >  #include "stih407-pinctrl.dtsi"
> >+#include <dt-bindings/mfd/st-lpc.h>
> >  #include <dt-bindings/reset-controller/stih407-resets.h>
> >  / {
> >  	#address-cells =3D <1>;
> >@@ -274,5 +275,24 @@
> >  			status =3D "disabled";
> >  		};
> >+
> >+		/* Watchdog and Real-Time Clock */
> >+		lpc@8787000 {
> >+			compatible =3D "st,stih407-lpc";
> >+			reg =3D <0x8787000 0x1000>;
> >+			interrupts =3D <GIC_SPI 129 IRQ_TYPE_EDGE_RISING>;
> In case of Watchdog, "interrupt" property is not used. So I think we
> can remove it ?

Although we don't use it, this still accurately describes the h/w, so
unless there are any severe objections, I think it can stay.

> >+			clocks =3D <&clk_s_d3_flexgen CLK_LPC_0>;
> >+			timeout-sec =3D <120>;
> >+			st,syscfg =3D <&syscfg_core>;
> >+			st,lpc-mode =3D <ST_LPC_MODE_WDT>;
> >+		};
> >+
> >+		lpc@8788000 {
> >+			compatible =3D "st,stih407-lpc";
> >+			reg =3D <0x8788000 0x1000>;
> >+			interrupts =3D <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>;
> >+			clocks =3D <&clk_s_d3_flexgen CLK_LPC_1>;
> >+			st,lpc-mode =3D <ST_LPC_MODE_RTC>;
> >+		};
> >  	};
> >  };
>=20

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
