Return-path: <carlo.caione@gmail.com>
MIME-Version: 1.0
Sender: carlo.caione@gmail.com
In-Reply-To: <1411232812-11594-4-git-send-email-carlo@caione.org>
References: <1411232812-11594-1-git-send-email-carlo@caione.org>
	<1411232812-11594-4-git-send-email-carlo@caione.org>
Date: Fri, 26 Sep 2014 10:04:45 +0200
Message-ID: <CAOQ7t2Z9LBmsYRRdutAnsmK-VN58XjiS9i1m-HC7T8Aku_tBQg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] ARM: DTS: meson: update DTSI to add watchdog node
From: Carlo Caione <carlo@caione.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>,
	Beniamino Galvani <b.galvani@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jerry Cao <jerry.cao@amlogic.com>, Victor Wan <victor.wan@amlogic.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, Sep 20, 2014 at 7:06 PM, Carlo Caione <carlo@caione.org> wrote:
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  arch/arm/boot/dts/meson.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
> index 55feb14..e6539ea 100644
> --- a/arch/arm/boot/dts/meson.dtsi
> +++ b/arch/arm/boot/dts/meson.dtsi
> @@ -70,6 +70,11 @@
>                 #size-cells = <1>;
>                 ranges;
>
> +               wdt: watchdog@c1109900 {
> +                       compatible = "amlogic,meson6-wdt";
> +                       reg = <0xc1109900 0x8>;
> +               };
> +
>                 uart_AO: serial@c81004c0 {
>                         compatible = "amlogic,meson-uart";
>                         reg = <0xc81004c0 0x14>;

Hi Arnd and Guenter,
who is supposed to take in this patch? The basic support for the SoC
is already in the arm-soc tree (thanks Arnd) and the other three
patches of this patchset are going in through Guenter tree (thanks
Guenter).

BR,

-- 
Carlo Caione
