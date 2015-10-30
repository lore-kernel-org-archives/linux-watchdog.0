Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:52518 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965722AbbJ3Mxi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 08:53:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	robh+dt@kernel.org, kernel@savoirfairelinux.com
Subject: Re: [PATCH 2/4] watchdog: ts4800: add new driver for TS-4800 watchdog
Date: Fri, 30 Oct 2015 13:53 +0100
Message-ID: <6804900.txcGkbUFcL@wuerfel>
In-Reply-To: <1445978021-13961-3-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1445978021-13961-1-git-send-email-damien.riegel@savoirfairelinux.com> <1445978021-13961-3-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 27 October 2015 16:33:39 Damien Riegel wrote:
> +static void ts4800_write_feed(struct ts4800_wdt *wdt, u16 val)
> +{
> +       __raw_writew(val, wdt->base + TS4800_WTD_FEED);
> +}
> +
> 

Using __raw_writew() is broken when you run a big-endian kernel. Better always
use the normal writew() in device drivers.

	Arnd
