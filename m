Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:50476 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751115AbcBEUIF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Feb 2016 15:08:05 -0500
Date: Fri, 5 Feb 2016 14:08:03 -0600
From: Josh Cartwright <joshc@ni.com>
To: Kyle Roeschley <kyle.roeschley@ni.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [RFC 3/4] watchdog: ni9x3x_wdt: Add timeout_action sysfs
 attribute
Message-ID: <20160205200803.GC9579@jcartwri.amer.corp.natinst.com>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
 <1454635683-13668-3-git-send-email-kyle.roeschley@ni.com>
MIME-Version: 1.0
In-Reply-To: <1454635683-13668-3-git-send-email-kyle.roeschley@ni.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2016 at 07:28:02PM -0600, Kyle Roeschley wrote:
[..]
> diff --git a/drivers/watchdog/ni9x3x_wdt.c b/drivers/watchdog/ni9x3x_wdt.c
> index 13f5c10..1fce4d0 100644
> --- a/drivers/watchdog/ni9x3x_wdt.c
> +++ b/drivers/watchdog/ni9x3x_wdt.c
> @@ -15,6 +15,7 @@
>  #include <linux/acpi.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/sysfs.h>
>  #include <linux/watchdog.h>
> =20
>  #define NIWD_CONTROL	0x01
> @@ -28,6 +29,7 @@
>  #define NIWD_IO_SIZE	0x08
> =20
>  #define NIWD_CONTROL_MODE		0x80
> +#define NIWD_CONTROL_PROC_INTERRUPT	0x40
>  #define NIWD_CONTROL_PROC_RESET		0x20
>  #define NIWD_CONTROL_PET		0x10
>  #define NIWD_CONTROL_RUNNING		0x08
> @@ -48,6 +50,7 @@ struct ni9x3x_wdt {
>  	struct acpi_device *acpi_device;
>  	u16 io_base;
>  	u16 io_size;
> +	u32 irq;

Interrupts have type 'int'.

>  	spinlock_t lock;
>  	struct watchdog_device wdog;
>  };
> @@ -101,6 +104,34 @@ static unsigned int ni9x3x_wdt_wdd_get_timeleft(stru=
ct watchdog_device *wdd)
>  	return (unsigned int)((counter * (u64)NIWD_PERIOD_NS) / 1000000000);
>  }
> =20
> +static irqreturn_t ni9x3x_wdt_irq_handler(int irq, void *data)
> +{
> +	struct ni9x3x_wdt *wdt =3D data;
> +	irqreturn_t ret =3D IRQ_NONE;
> +	u8 control;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&wdt->lock, flags);

Interrupts are disabled already, so the _irqsave()/_irqrestore() is
unnecessary.

> +
> +	control =3D inb(wdt->io_base + NIWD_CONTROL);
> +
> +	if (!(NIWD_CONTROL_ALARM & control)) {
> +		dev_err(&wdt->acpi_device->dev,
> +			"Spurious watchdog interrupt, 0x%02X\n", control);

No need to print anything here, just return IRQ_NONE.  The irq core will
print a much better (and rate-limited) error when/if this occurs.

> +		goto out_unlock;
> +	}
> +
> +	/* Acknowledge the interrupt. */
> +	outb(control | NIWD_CONTROL_RESET, wdt->io_base + NIWD_CONTROL);
> +
> +	ret =3D IRQ_HANDLED;
> +
> +out_unlock:
> +	spin_unlock_irqrestore(&wdt->lock, flags);
> +
> +	return ret;
> +}

This is...strange.  You're allowing a user to enable an interrupt reset
action, but...there is no way that a user can actually _do_ anything
when that action occurs.

I'm reminded of one of these:

  https://www.youtube.com/watch?v=3DaqAUmgE3WyM

(The only reason I can think of where this would be a legitimate thing
to do was if we were relying on the watchdog interrupt to bring the CPU
out of a low power state...but AFAIK that's not something we do).

  Josh

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWtQEgAAoJEKp7ZBKwQFArA8UIAJKQg+klf3hBbqgYgeI8Xsp7
osi97ywgkjVKVjitZP+xyBXr7r2yzYkIoFFN+2kkJOz4IqQzqTEcMNub/sQlLEsC
5ICXmJmRJi4+nXZ9zxjMmTDyzgoIyw95Mt1gvj3NRgHgdDmYEYcOPsxVQ8xHYoJv
ALQDpkTEMqSqF7B06vCinmAyD51tVhJua8ZsHhwkNwLTimAg7sG3ExprKXIW9Uu5
X6LVju31T8DvfnQaaxeQ9et2+xrzundP1OXhZamYE+dTXRTEP1E/VaZT7xm/4s21
1DFEprpY6f97q/Q7SGfjqXMzKAXjmMLtcwYXFynwVeGydh6lxvpLURDolJPdYwA=
=9KLB
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
