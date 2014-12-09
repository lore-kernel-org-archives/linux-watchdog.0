Return-path: <stwiss.opensource@diasemi.com>
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Wim Van Sebroeck
	<wim@iguana.be>, Wolfram Sang <wsa@the-dreams.de>, Simon Horman
	<horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
CC: Support Opensource <Support.Opensource@diasemi.com>, Guenter Roeck
	<linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Subject: RE: [PATCH 1/4] watchdog: da9063: Add restart handler support
Date: Tue, 9 Dec 2014 12:37:15 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7D0B4C115@SW-EX-MBX02.diasemi.com>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
 <1418124169-7123-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418124169-7123-2-git-send-email-geert+renesas@glider.be>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On 09 December 2014 11:23 Geert Uytterhoeven wrote:

Hi Geert,

> Subject: [PATCH 1/4] watchdog: da9063: Add restart handler support
>=20
> Register a restart handler for the da9063 watchdog.  System restart is
> triggered by sending the shutdown command to the PMIC.
> As more-suitable restart handlers may exist, the priority of the
> watchdog restart handler is set to 128.
>=20
> The actual restart method was inspired by a platform-specific patch from
> the BSP by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested on r8a7791/koelsch
> ---

[...]

+static int da9063_wdt_restart_handler(struct notifier_block *this,
+				      unsigned long mode, void *cmd)
+{
+	struct da9063_watchdog *wdt =3D container_of(this,
+						   struct da9063_watchdog,
+						   restart_handler);
+	int ret;
+
+	ret =3D regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
+			   DA9063_SHUTDOWN);

I am stating the obvious here.

DA9063_REG_CONTROL_F, DA9063_SHUTDOWN will cause the sequencer to
power down to RESET Mode -- which means if this I2C command succeeds=20
there will be a sudden loss of power and any unsaved information will be=20
lost after this point.

This is exactly how I have done it in the past.

+	if (ret)
+		dev_alert(wdt->da9063->dev, "Failed to shutdown (err =3D %d)\n",
+			  ret);
+
+	return NOTIFY_DONE;
+}
+

[...]

>  static const struct watchdog_info da9063_watchdog_info =3D {
>  	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>  	.identity =3D "DA9063 Watchdog",
> @@ -163,14 +182,25 @@ static int da9063_wdt_probe(struct
> platform_device *pdev)
>  	dev_set_drvdata(&pdev->dev, wdt);
>=20
>  	ret =3D watchdog_register_device(&wdt->wdtdev);
> +	if (ret)
> +		return ret;
>=20
> -	return ret;
> +	wdt->restart_handler.notifier_call =3D da9063_wdt_restart_handler;
> +	wdt->restart_handler.priority =3D 128;
> +	ret =3D register_restart_handler(&wdt->restart_handler);
> +	if (ret)
> +		dev_err(wdt->da9063->dev,
> +			"Failed to register restart handler (err =3D %d)\n", ret);

 (I guess this is intentional).. if the restart handler doesn't get registe=
red then
this problem is just ignored and not counted as a real error.

> +
> +	return 0;
>  }
>=20
>  static int da9063_wdt_remove(struct platform_device *pdev)
>  {
>  	struct da9063_watchdog *wdt =3D dev_get_drvdata(&pdev->dev);
>=20
> +	unregister_restart_handler(&wdt->restart_handler);
> +
>  	watchdog_unregister_device(&wdt->wdtdev);
>=20
>  	return 0;

Despite the above, these are just my comments.
It all looks fine to me.

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
