Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50066 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab3IOUK5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 15 Sep 2013 16:10:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: [PATCH v4 4/4] ARM: bcm4760: Add restart hook
Date: Sun, 15 Sep 2013 22:10:36 +0200
Cc: Domenico Andreoli <domenico.andreoli@linux.com>,
	Olof Johansson <olof@lixom.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
References: <20130914152032.401907974@gmail.com> <201309152009.26462.arnd@arndb.de> <20130915185220.GA32054@glitch>
In-Reply-To: <20130915185220.GA32054@glitch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201309152210.36738.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sunday 15 September 2013, Domenico Andreoli wrote:
> issue here is that there is already a proper watchdog driver, the sp805.
> 
> so I guess now the task shifts to adding restart hook support to it, right?

Yes, correct.

There is an interesting question however: we have to deal with the same driver
being used in some machines that need to use it as the only way to reset the
system, as well as the case where you actually want to use some other method.

An easy way to handle this would be a boolean device tree property that
tells the driver whether or not to register, but we might want to
come up with a more sophisticated way to have multiple reset handlers
registered an prioritized so we try the "best" one first. Maybe someone
else has an opinion on this. If not, just do the property.

	Arnd
