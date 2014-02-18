Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47335 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752856AbaBRRrT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Feb 2014 12:47:19 -0500
Date: Tue, 18 Feb 2014 14:47:13 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: wim@iguana.be, olof@lixom.net, festevam@gmail.com,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: orion_wdt: Use %pa to print 'phys_addr_t'
Message-ID: <20140218174712.GC10691@localhost>
References: <1392726234-16977-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1392726234-16977-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 18, 2014 at 09:23:54AM -0300, Fabio Estevam wrote:
> When building an ARM multi_v7_defconfig with LPAE option selected we =
get the
> following build warning:
>=20
> drivers/watchdog/orion_wdt.c:272:2: warning: format '%x' expects argu=
ment of type 'unsigned int', but argument 4 has type 'phys_addr_t' [-Wf=
ormat=3D]
>=20
> Fix it by using %pa to print 'phys_addr_t'.
>=20
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
