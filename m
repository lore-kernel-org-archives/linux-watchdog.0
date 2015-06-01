Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34487 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbbFARzU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 1 Jun 2015 13:55:20 -0400
Received: by wgv5 with SMTP id 5so120985175wgv.1
        for <linux-watchdog@vger.kernel.org>; Mon, 01 Jun 2015 10:55:18 -0700 (PDT)
Date: Mon, 1 Jun 2015 18:55:13 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Valentin Rothberg <valentinrothberg@gmail.com>
Cc: Andreas Ruprecht <andreas.ruprecht@fau.de>,
	Paul Bolle <pebolle@tiscali.nl>,
	hengelein Stefan <stefan.hengelein@fau.de>, wim@iguana.be,
	david.paris@st.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: watchdog: st_wdt: select on undefined MFD_ST_LPC
Message-ID: <20150601175513.GG3329@x1>
References: <CAD3Xx4JLanN3Luo1ijtPAA5LKz8fiWU=zs2SuCGvGn6JTMka_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <CAD3Xx4JLanN3Luo1ijtPAA5LKz8fiWU=zs2SuCGvGn6JTMka_Q@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 01 Jun 2015, Valentin Rothberg wrote:

> Hi Lee,
>=20
> your commit d0c9e350b9a4 ("watchdog: st_wdt: Add new driver for ST's
> LPC Watchdog") is in today's linux-next tree (i.e., next-20150601) an=
d
> adds the following lines of code to drivers/watchdog/Kconfig.
>=20
> +config ST_LPC_WATCHDOG
> ...
> +       select MFD_ST_LPC
>=20
> The select turns out to be a NOOP since MFD_ST_LPC is not defined
> Kconfig.  Is it the correct option to be selected?  I could not find =
a
> similar option in the source, nor get any hints  from searching the
> lkml.
>=20
> I detected the issue with ./scripts/checkkconfigsymbols.py by diffing
> the last and today's linux tree.

You're right.  This symbol is legacy.  I will remove.

Thanks for reporting.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
