Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36175 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753407AbcDDPX3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2016 11:23:29 -0400
Date: Mon, 4 Apr 2016 17:23:24 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/4] watchdog: add driver for Renesas Gen3 WDT
 watchdogs
Message-ID: <20160404152324.GH2983@katana>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
 <CAMuHMdXQFD281m7iWc7RRdunW8Fo9nQfLBwytD1L3abW1ephtw@mail.gmail.com>
 <20160404145919.GE2983@katana>
 <CAMuHMdU3m74FV_+XTD0n7_SmW97aUD0ZpJ2q=YLmsAEtjF+udQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <CAMuHMdU3m74FV_+XTD0n7_SmW97aUD0ZpJ2q=YLmsAEtjF+udQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> That's indeed silly. Can't we have it as a low-priority restart handler, to
> restart the system if PSCI fails to do so?

+1. But my PSCI knowledge is 0. Unlike my task list :/


--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAobsAAoJEBQN5MwUoCm2gWgP/1vZwpWzanEnUO1LaQFsb5ei
xmkzo8HZUjOlf3M9rEaoN6djnoiHuY4Hy94lh7UfdEtK4JYhC30CM6KmYtsunqfo
Kq66AYKxLNTn6EqhqJMLQ+EAabkw18i3RK6Tu4SR0ktk7hwmE8W/TmACrI7IdWC0
cojXUXo8SsGCxUeNY8qosIZapkUf76wOWAaQGaYvu7BtvkU7CjEkDwCs58XAhyRK
5xuyHWy+wdxV6a5mODNljR+BK8N0/TK3auKbblK1c+TNSGfMNUTLspWuTF/aNuEw
RHMxusL4DJV75+fHnUaV3YgEsP+siK0rSysnkOK15hgR14OQDFLeMG3GXdrk2EQp
Ks010do4hn6bq/q/+ZLOuoJn1bgk6wSeHXdHgSib8TXjq2blTz4J/69fmDHOSfxq
zxj+uzZ6TDpmpKSNVhg+r9qQjK7Mq+wrCIJK0tpkPo+q6xL/9uTQDRHx1IcZ5LdM
gAfLDdLroRRJ0j7fXpi6I0l0QU7QhpH/VX+eJi8j7X70vlzCQSLsbal/v3TcBlOi
q36KCjVO6wv02g6JpHMX74yAs809Z0sHB+DjwCiEnGvqQmv4+PTCaLUSQa4aqDoe
aEWV8HNSLhKZGtFCvb/mUJasmEVLv6qjsep40pzL1P5vY93lH/VOa5f9/eEeic6D
o4HO/9N2w+RMrvvmF9dZ
=H1z6
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
