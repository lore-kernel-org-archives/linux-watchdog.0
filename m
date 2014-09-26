Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:51398 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588AbaIZJRD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Sep 2014 05:17:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Carlo Caione <carlo@caione.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-watchdog@vger.kernel.org,
	Victor Wan <victor.wan@amlogic.com>,
	Beniamino Galvani <b.galvani@gmail.com>, wim@iguana.be,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, linux@roeck-us.net,
	Jerry Cao <jerry.cao@amlogic.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 3/4] ARM: DTS: meson: update DTSI to add watchdog node
Date: Fri, 26 Sep 2014 11:16:52 +0200
Message-ID: <43154094.zHJetoiMJ3@wuerfel>
In-Reply-To: <CAOQ7t2Z9LBmsYRRdutAnsmK-VN58XjiS9i1m-HC7T8Aku_tBQg@mail.gmail.com>
References: <1411232812-11594-1-git-send-email-carlo@caione.org> <1411232812-11594-4-git-send-email-carlo@caione.org> <CAOQ7t2Z9LBmsYRRdutAnsmK-VN58XjiS9i1m-HC7T8Aku_tBQg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 26 September 2014 10:04:45 Carlo Caione wrote:
> Hi Arnd and Guenter,
> who is supposed to take in this patch? The basic support for the SoC
> is already in the arm-soc tree (thanks Arnd) and the other three
> patches of this patchset are going in through Guenter tree (thanks
> Guenter).
> 

It should go through the arm-soc tree.

	Arnd
