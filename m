Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:65515 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbaKMEJ0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Nov 2014 23:09:26 -0500
Received: by mail-la0-f46.google.com with SMTP id gm9so12311532lab.5
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Nov 2014 20:09:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1415805483-26268-3-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>
	<1415805483-26268-3-git-send-email-Naidu.Tellapati@imgtec.com>
Date: Wed, 12 Nov 2014 20:09:24 -0800
Message-ID: <CAL1qeaHrjccd4KYAUMvWEKqhM9DFNyKWE=-2k0ux+76XR+Q5tQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] DT: watchdog: Add ImgTec PDC Watchdog Timer binding documentation
From: Andrew Bresticker <abrestic@chromium.org>
To: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: wim@iguana.be, linux@roeck-us.net,
	James Hartley <James.Hartley@imgtec.com>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	linux-watchdog@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jude.Abraham@imgtec.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 12, 2014 at 7:18 AM,  <Naidu.Tellapati@imgtec.com> wrote:
> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>
> Add the devicetree binding document for ImgTec PDC Watchdog Timer.
>
> Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

> diff --git a/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt b/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
> new file mode 100644
> index 0000000..2f13896
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
> @@ -0,0 +1,18 @@
> +*ImgTec PowerDown Controller (PDC) Watchdog Timer (WDT)
> +
> +Required properties:
> +- compatible : Should be "img,pistachio-pdc-wdt"

I don't see anything Pistachio-specific about this driver or binding
and it looks like IP revision is probable via the WD_CORE_REV
register, so I think you can drop the "pistachio".

> +- reg : Should contain WDT registers location and length
> +- clock-names: Should contain "wdt"

I believe there are two clocks: the 32kHz watchdog timer operating
clock and the system interface gate clock.  Perhaps call them "wdt"
and "sys"?

> +- clocks: phandles to input clocks
> +- interrupts : Should contain WDT interrupt

Not sure the interrupt will really be necessary.

> +Examples:
> +
> +wdt@18102100 {
> +       compatible = "img,pistachio-pdc-wdt";
> +       reg = <0x18102100 0x20>;

The TRM I have shows the watchdog registers occupying a full 256 bytes.

> +       clocks = <&pdc_wdt_clk>;
> +       clock-names = "wdt";
> +       interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
> +};
> --
> 1.7.0.4
>
