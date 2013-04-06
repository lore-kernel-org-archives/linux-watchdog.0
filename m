Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:46804 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410Ab3DFITi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Apr 2013 04:19:38 -0400
From: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: Fix race condition in registration code
Date: Sat, 6 Apr 2013 10:19:34 +0200
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
References: <1365222163-26761-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365222163-26761-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201304061019.34473.a.miskiewicz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Saturday 06 of April 2013, Guenter Roeck wrote:
> A race condition exists when registering the first watchdog device.
> Sequence of events:
>=20
> - watchdog_register_device calls watchdog_dev_register
> - watchdog_dev_register creates the watchdog misc device by calling
>   misc_register.
>   At that time, the matching character device (/dev/watchdog0) does not=
 yet
>   exist, and old_wdd is not set either.
> - Userspace gets an event and opens /dev/watchdog
> - watchdog_open is called and sets sets wdd =3D old_wdd, which is still=
 NULL,
>   and tries to dereference it. This causes the kernel to panic.
>=20
> Seen with systemd trying to open /dev/watchdog immediately after
> it was created.
>=20
> Reported-by: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>

Please use
Reported-by: Arkadiusz Mi=C5=9Bkiewicz <arekm@maven.pl>

I have to use gmail address because maven.pl domain is blocked due to som=
e=20
unknown, secret reason and vger.kernel.org postmasters (Dave M etc) are l=
ess=20
than helpful:

"We are under no obligation to explain why you were banned nor to remove
the ban.

If you don't like this, you can run your own list server and on it determ=
ine
your own set of policies."


> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Arkadiusz,
>=20
> would be great if you can test this in your system.

Did few reboots without oops but this test isn't reliable. Previously I w=
asn't=20
able to reproduce this on demand. It just happens sometime. If any proble=
m=20
popup I'll let you know.

So for now
Tested-by: Arkadiusz Mi=C5=9Bkiewicz <arekm@maven.pl>

>=20
>  drivers/watchdog/watchdog_dev.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/watchdog/watchdog_dev.c
> b/drivers/watchdog/watchdog_dev.c index 08b48bb..faf4e18 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -523,6 +523,7 @@ int watchdog_dev_register(struct watchdog_device
> *watchdog) int err, devno;
>=20
>  	if (watchdog->id =3D=3D 0) {
> +		old_wdd =3D watchdog;
>  		watchdog_miscdev.parent =3D watchdog->parent;
>  		err =3D misc_register(&watchdog_miscdev);
>  		if (err !=3D 0) {
> @@ -531,9 +532,9 @@ int watchdog_dev_register(struct watchdog_device
> *watchdog) if (err =3D=3D -EBUSY)
>  				pr_err("%s: a legacy watchdog module is probably present.\n",
>  					watchdog->info->identity);
> +			old_wdd =3D NULL;
>  			return err;
>  		}
> -		old_wdd =3D watchdog;
>  	}
>=20
>  	/* Fill in the data structures */


--=20
Arkadiusz Mi=C5=9Bkiewicz, arekm / maven.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
