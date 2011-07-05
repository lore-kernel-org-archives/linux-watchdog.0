Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:39972 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab1GEWZm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 Jul 2011 18:25:42 -0400
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] Add watchdog driver for Intel E6XX
In-Reply-To: Your message of "Mon, 04 Jul 2011 15:29:08 +0200."
             <1309786148-5138-2-git-send-email-alexander.stein@systec-electronic.com>
From: Valdis.Kletnieks@vt.edu
References: <20110701110002.GA9326@infomag.iguana.be>
            <1309786148-5138-2-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1309904673_18528P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Jul 2011 18:24:33 -0400
Message-ID: <61870.1309904673@turing-police.cc.vt.edu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--==_Exmh_1309904673_18528P
Content-Type: text/plain; charset=us-ascii

On Mon, 04 Jul 2011 15:29:08 +0200, Alexander Stein said:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

> +config IE6XX_WATCHDOG
> +	tristate "Intel E6XX watchdog"
> +	depends on WATCHDOG && PCI && X86
> +	select MFD_CORE
> +	select LPC_SCH
> +	---help---
> +	  Hardware driver for the watchdog timer built into the Intel
> +	  E6XX (TunnelCreek) processor.

That addresses my comment on the patchset, feel free to stick an Acked-By: or
whatever is called for in there...


--==_Exmh_1309904673_18528P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFOE48hcC3lWbTT17ARAum+AJ93gakw8kROiW4d06eXaVOut0ql6gCZAYgx
ANj8C/UJXc3JQIRIdHQuCDM=
=7vfM
-----END PGP SIGNATURE-----

--==_Exmh_1309904673_18528P--

