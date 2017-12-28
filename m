Return-Path: <mathieu.malaterre@gmail.com>
Return-path: <mathieu.malaterre@gmail.com>
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20171228162939.3928-6-paul@crapouillou.net>
References: <20171228162939.3928-1-paul@crapouillou.net> <20171228162939.3928-6-paul@crapouillou.net>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 28 Dec 2017 18:33:39 +0100
Message-ID: <CA+7wUswad_8CvHtLOJDRy9WcVKoqwqyaMOGXFQzjYZ4_4oDmFg@mail.gmail.com>
Subject: Re: [PATCH 5/7] MIPS: jz4780: dts: Fix watchdog node
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

Hi Paul,

On Thu, Dec 28, 2017 at 5:29 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> - The previous node requested a memory area of 0x100 bytes, while the
>   driver only manipulates four registers present in the first 0x10 bytes.
>
> - The driver requests for the "rtc" clock, but the previous node did not
>   provide any.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index 9b5794667aee..a52f59bf58c7 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -221,7 +221,10 @@
>
>         watchdog: watchdog@10002000 {
>                 compatible = "ingenic,jz4780-watchdog";
> -               reg = <0x10002000 0x100>;
> +               reg = <0x10002000 0x10>;
> +
> +               clocks = <&cgu JZ4780_CLK_RTCLK>;
> +               clock-names = "rtc";
>         };
>
>         nemc: nemc@13410000 {
> --
> 2.11.0
>
>

Looks good, thanks for fixing my mess. Tested on MIPS Creator CI20:

Dec 28 17:27:50 ci20 watchdog[17531]: starting daemon (5.14):
Dec 28 17:27:50 ci20 watchdog[17531]: int=1s realtime=yes sync=no
soft=no mla=0 mem=0
Dec 28 17:27:50 ci20 watchdog[17531]: ping: no machine to check
Dec 28 17:27:50 ci20 watchdog[17531]: file: no file to check
Dec 28 17:27:50 ci20 watchdog[17531]: pidfile: no server process to check
Dec 28 17:27:50 ci20 watchdog[17531]: interface: no interface to check
Dec 28 17:27:50 ci20 watchdog[17531]: temperature: no sensors to check
Dec 28 17:27:50 ci20 watchdog[17531]: test=none(0) repair=none(0)
alive=/dev/watchdog heartbeat=none to=root no_act=no force=no
Dec 28 17:27:50 ci20 watchdog[17531]: watchdog now set to 60 seconds
Dec 28 17:27:50 ci20 watchdog[17531]: hardware watchdog identity:
jz4740 Watchdog

pkill + reboot = ok

Reviewed-by: Mathieu Malaterre <malat@debian.org>
