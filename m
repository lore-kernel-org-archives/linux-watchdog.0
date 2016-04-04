Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33457 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530AbcDDMhC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2016 08:37:02 -0400
Date: Mon, 4 Apr 2016 14:36:54 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: "fixed-term.Oleksij.Rempel" <fixed-term.Oleksij.Rempel@de.bosch.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, dirk.behme@de.bosch.com,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/4] watchdog: renesas-wdt: add driver
Message-ID: <20160404123654.GA2983@katana>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
 <1459511786-4286-2-git-send-email-wsa@the-dreams.de>
 <57010C13.7040007@rempel-privat.de>
 <20160404104508.GA1383@katana>
 <57025C5A.2060704@de.bosch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <57025C5A.2060704@de.bosch.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> we are using it. So it should be implemented in this driver as well,
> if it is not supported by HW, then we will need to use second timer or
> watchdog for pretimeout interrupt.

As I said, I have no task like this assigned (and no personal interest,
too). So, you'd need to do it yourself, hire me, or request this feature
=66rom Renesas (and hope that they pass the task to me ;)).

> Please correct me if i'm wrong - module parameter is a way to ignore
> kernel config. For same purpose, to disable wdt at runtime "magic 'V'"
> should be used.

I have to admit that I don't have a specific use-case, I just did
general support as requested. So, I followed the style that basically
every other watchdog driver has this parameter.


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAl/mAAoJEBQN5MwUoCm2A3UP/iONBwdLCfED3o7MNxoCuB1h
2FA8IcFkl98vR1jbF+Vm9MzageeJsJbv4osCjny2UYksiDaQRHBTpgMbnSmc/0wS
KMG+7+brhMpAvT6lhXwn4JefEeAqu+ANp0ipKrigMK+GRx+0uA0K0mSSFpg77WKO
iR4DWsLCFC8oP+WqQ5QE77ZPwReLe/YUXyuhlG5oB496G3XLfKDN82nuGidtYKQz
xgi0vZTq7rVWCiRKib4+ip28GFx3BVfa3li7Py/63VNZxZjQ9llUP5YKLagwwbeL
X44OVzwhntSA49Pjsas+aQ5xIEzkRHQZAY4q9hE+hCc/6dGMdlWUp3G7LbzBm41f
BycBByg8rTaiBpjCn2oqiZAAvO+SQbuQ2KdZwvqGG02wEll7g6iiDKnZduoSuEkt
0R35QLdY2fDcwhT3t7sEhm8PyHCHUQN4+ZH1I37frr8qCpFE7zPThBHkwQRpbod1
kXDIpj525T8lUXZFN8ooFrUG1kJ8DqGFSO4slrnrAKYrnC+5TCU2k180mueibxUq
UWzJMSGkpmtqe0Jz3GhTVw5/FaIoZGkfDOpSss0X57r/I+Tv4Hpo0p2DwvO8uF3T
dChW7n5DhYp36aAKM1DpUiQkHF7n78q0Zq+NMu07yj8UwjdR+tDPcbEkTDRxYBWK
s9HyuajooWWAeHAhn1XV
=wCDX
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
