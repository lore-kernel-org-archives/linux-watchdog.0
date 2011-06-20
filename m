Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59167 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab1FTQvC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Jun 2011 12:51:02 -0400
MIME-Version: 1.0
In-Reply-To: <1308567752-13451-4-git-send-email-thomas.abraham@linaro.org>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org> <1308567752-13451-4-git-send-email-thomas.abraham@linaro.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 20 Jun 2011 10:50:42 -0600
Message-ID: <BANLkTikkxpOC6M1R0g=dGvDXvCkG6EOJhQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] watchdog: s3c2410: Add support for device tree based probe
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
	linaro-dev@lists.linaro.org, patches@linaro.org,
	linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2011 at 5:02 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> This patch adds the of_match_table to enable s3c2410-wdt driver
> to be probed when watchdog device node is found in the device tree.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

You need to send this to Wim and the linux-watchdog mailing lists.  As
far as I'm concerned, it can be merged immediately.

g.

> ---
> =A0.../devicetree/bindings/watchdog/samsung-wdt.txt =A0 | =A0 12 ++++++=
++++++
> =A0drivers/watchdog/s3c2410_wdt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 10 ++++++++++
> =A02 files changed, 22 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/watchdog/samsun=
g-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt=
 b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> new file mode 100644
> index 0000000..f2617e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> @@ -0,0 +1,12 @@
> +* Samsung's Watchdog Timer Controller
> +
> +The Samsung's Watchdog controller is used for resuming system operatio=
n
> +after a preset amount of time during which the WDT reset event has not
> +occured.
> +
> +Required properties:
> +- compatible : should be "samsung,s3c2410-wdt"
> +- reg : base physical address of the controller and length of memory m=
apped
> + =A0 =A0 =A0 region.
> +- interrupts : interrupt number to the cpu.
> +
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_=
wdt.c
> index f7f5aa0..30da88f 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -589,6 +589,15 @@ static int s3c2410wdt_resume(struct platform_devic=
e *dev)
> =A0#define s3c2410wdt_resume =A0NULL
> =A0#endif /* CONFIG_PM */
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id s3c2410_wdt_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "samsung,s3c2410-wdt" },
> + =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
> +#else
> +#define s3c2410_wdt_match NULL
> +#endif
>
> =A0static struct platform_driver s3c2410wdt_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D s3c2410wdt_probe,
> @@ -599,6 +608,7 @@ static struct platform_driver s3c2410wdt_driver =3D=
 {
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "s3c2410-wdt",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D s3c2410_wdt_match,
> =A0 =A0 =A0 =A0},
> =A0};
>
> --
> 1.6.6.rc2
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
