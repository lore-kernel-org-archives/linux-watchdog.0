Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38070 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729AbbEEIbj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 May 2015 04:31:39 -0400
Subject: Re: [PATCHv7 6/8] watchdog: imx2_wdt: Convert to use new core extensions
To: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
references: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-7-git-send-email-timo.kokkonen@offcode.fi>
 <55487B1D.1060108@pengutronix.de>
Cc: Wenyou.Yang@atmel.com
From: Marc Kleine-Budde <mkl@pengutronix.de>
message-id: <55487FDB.6060708@pengutronix.de>
Date: Tue, 5 May 2015 10:31:23 +0200
mime-version: 1.0
in-reply-to: <55487B1D.1060108@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kMAcXHU77AKnpkQpx8rgtkv202CdiNQgB"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kMAcXHU77AKnpkQpx8rgtkv202CdiNQgB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2015 10:11 AM, Marc Kleine-Budde wrote:
> On 04/22/2015 01:11 PM, Timo Kokkonen wrote:
>> Fill in the HW capabilities in watchdog_device structure and call
>> watchdgog_init_params() to let watchdog core to init itself
>> properly. The watchdog core can then ping stopped watchdog and the
>> timer code in the driver can be removed.
>>
>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>=20
> This patch changes the default behaviour of the imx watchdog. Without
> the patch: If the system boot with watchdog enabled (by the bootloader)=
,
> the driver sets up a threads to pet the watchdog. With the patch,
> imx2_wdt_ping() is called once during probe but the thread is not
> started. There are no timeout or early_timeout paremters in the DT or i=
n
> the kernel command line.
>=20
> I don't like the old behaviour, but I think there are some setups that
> rely on this feature.

BTW: the start-thread-if-wd-is-active feature was added in:

    faad5de0b104 watchdog: imx2_wdt: convert to watchdog core api

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--kMAcXHU77AKnpkQpx8rgtkv202CdiNQgB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVSH/cAAoJECte4hHFiupUfOQP/jJ9bM5aLZZMik2C8MSR/DsA
/z/CoSSKgSNSGDMD4IEIdeqPMrBfj/NyaRGfnOG+w/W8CIi/mG8Ow+NtHnHLi2Oe
sHLMjeChp/WJYTKPltdCVAlBPQ+Mm2uIpkADrdAKXu+rGRxfjr5PSO2nrgEnAuu9
NCG43zgyioWVys35DTW5SsEr5DopwXcjfkGFMHFoIhAtZPFsuXtObmshJMczV/N/
xBpUjNUqGl9ZFzNJH/f4DXYQhlmmXjOws5qJKOGCWOdWwZXs/cYE3O0BZmiMcZm3
Er0eeKa0hLwfkVjVJ3H77WkQBdt+tNjmCKkA1R5XbQipRLIQzi9IRRa+uviSef8F
qF36CQEE5W2XXiF6EsZTlp9+bKMppdzY53sSO5h369zqCfAFv8J1aJBXl/59XaMy
aLy+0bne6SUNOWVIxKKOz5gCbCBVDYrot8WOQ0i23ZUHFfWJd17O27Y//vYYY0p0
wo+2xe0sOolMpaheVTQZ4WMwWt3LeYSPgcnRZ6SIsR9yYjP3KV2uaeQ8kivcJ8dp
MxHXQjSnVJdIxal8M1PxLw59kwdSa7fHH2FPKWu0a9XMZDyJSW6vfv/CI9hvW5f2
O8zXltmOTGyDZciFSWbCnoZmHcnmeYB+CrQwQnPxZuTEfEoE4u+0ZsHqc2NFsga9
T2fEUCfDYluXLLbM3jqN
=MHyR
-----END PGP SIGNATURE-----

--kMAcXHU77AKnpkQpx8rgtkv202CdiNQgB--
