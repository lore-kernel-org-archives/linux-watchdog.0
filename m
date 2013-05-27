Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.140]:36565 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756499Ab3E0Gwl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 May 2013 02:52:41 -0400
From: "Thumshirn, Johannes Tobias" <Johannes.Thumshirn@men.de>
To: Wim Van Sebroeck <wim@iguana.be>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH v3] watchdog: New watchdog driver for MEN A21 watchdogs
Date: Mon, 27 May 2013 06:45:39 +0000
Message-ID: <42A09AAC7DAAF64ABE4E4C1AD5F5E295094C82A0@MEN-EX1.intra.men.de>
References: <1368560034.24692.4.camel@joe-AO722>
 <1368643810-2789-1-git-send-email-johannes.thumshirn@men.de>
 <20130526143403.GB7603@spo001.leaseweb.com>
In-Reply-To: <20130526143403.GB7603@spo001.leaseweb.com>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

> +static int a21_wdt_notify_sys(struct notifier_block *notify, unsigned =
long code,
> +			void *unused)
> +{
> +	if (code =3D=3D SYS_DOWN || code =3D=3D SYS_HALT)
> +		gpio_set_value(GPIO_WD_ENAB, 0);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block a21_wdt_notifier =3D {
> +	.notifier_call =3D a21_wdt_notify_sys, };
...
> +	ret =3D register_reboot_notifier(&a21_wdt_notifier);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot register reboot notifier\n");
> +		goto err_register_notif;
> +	unregister_reboot_notifier(&a21_wdt_notifier);
...
> +	unregister_reboot_notifier(&a21_wdt_notifier);
...
> +static struct platform_driver a21_wdt_driver =3D {
> +	.probe =3D a21_wdt_probe,
> +	.remove =3D a21_wdt_remove,
> +	.driver =3D {
> +		.name =3D "a21-watchdog",
> +		.of_match_table =3D a21_wdt_ids,
> +	},
> +};

I prefer to have the reboot_notifier is being replaced by a platform .shu=
tdown function.
Can you also split the sysfs stuff as a second patch so that I can review=
 that seperately?

Kind regards,
Wim.


Hi Wim,

Of cause I'll do, but unfortunately I probably won't be able to do it tod=
ay, mind if you get the patch tomorrow?

Regards,
Johannes.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
