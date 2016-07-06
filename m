Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53185 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbcGFOQ7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 Jul 2016 10:16:59 -0400
Date: Wed, 6 Jul 2016 23:16:52 +0900
From: Wolfram Sang <wsa@the-dreams.de>
To: Stefan Christ <s.christ@phytec.de>
Cc: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 0/6] Implement I2C restart handler
Message-ID: <20160706141650.GB1430@tetsubishi>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
 <20160705145839.GA3641@tetsubishi>
 <20160706091838.GC7031@lws-christ>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <20160706091838.GC7031@lws-christ>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > My idea was to introduce master_xfer_irqless or similar to struct
> > i2c_algorithm. I even discussed this shortly with Mark Brown how to
> > interact with regmap; but this was too long ago, so I forgot what we
> > agreed on :(
>=20
> Great. I was looking for exactly this kind of feedback.
>=20
> The term 'master_xfer_irqless' does not bring up anything on the internet=
 and I
> didn't find anything on the list linux-i2c. Can you point me to the discu=
ssion,
> so I can read it up and work on it?

Sadly not. It was just an idea I had in my mind and some talking with
Mark at FOSDEM. Then priorities changed and I worked on something else.
You might want to look for threads where people implemented 'irqless' or
'polling' i2c transfers. I recall at least one discussion in the last
year, but can't seem to find it now :( Dunno if there is something
worthwhile in there, though.

Regards,

   Wolfram


--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfRLSAAoJEBQN5MwUoCm2Sp0P/0mMfBBdC6nWNH2iI9QnhhhB
ZRd27VrpsONuwr51D179AUrPG3VDa5f5Nzg8MCjzoYgD6WVJeV8Fu9WL7s1vpOIF
ebqwrP/l89UlkZ9v57hsPbvV3efrb4PCZzpJw5Om+vaGqEOsXlGGJxg/Wc8P/KTD
Ij9BYz51OxXlVKrbtd7aSTfRV5SnYAK9krHC5mgmRJBef6RGh70aoh5fa+p3kA0J
aX9yB2gWSseKpymrAQD+/8JL359AEzHjmKS63KQWAg6VPDqwk/ynqMmAMiNzsutV
w7MQWOAuVTu87c1/M34wB1hfZS9TFUg2qsWHzzMgcyye/8S3Xn2JSRLxtIqzQkyT
rn+Nu8sjMNAgc3JIZRWQ8oL1BmiRxyDEYH8Itfhal9n4Mv/fRhIExhnDME5RDDOy
HTNbIfZoSNLMcKf34zK2CiDv3pRFT5aWzt5wOZx8sTVESQ7gKZMOC6YqNCvNgYMU
Zhrv6py0u3EwDVBSaONC0epVcF7fkousIsGviLJniradUJ6kmnPd1rhugQPC98Bb
Fga3Fh5NCkgVU5sOppQE+BkikgeYZZKLqRgHRmR+6Zh1EPBmNuDJZ1Qf9DxU25sV
dK6NPkODCfO4DcrMOC4aDCGWQ6qbFB19rE3d5iS+J7277CW3N318bjuObuVEMcXv
r9bEzGEXPhcTa+3KBn7p
=O7e6
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
