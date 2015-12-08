Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:50675 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513AbbLHKEn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Dec 2015 05:04:43 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	Lee Jones <lee.jones@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	linux-watchdog@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sascha Hauer <kernel@pengutronix.de>,
	Kumar Gala <galak@codeaurora.org>, kernel@savoirfairelinux.com,
	Shawn Guo <shawnguo@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v7 2/6] mfd: syscon: add a DT property to set value width
Date: Tue, 08 Dec 2015 11:02:26 +0100
Message-ID: <4387768.MyTgBTEZTT@wuerfel>
In-Reply-To: <20151207194218.GB6030@localhost>
References: <1448899191-13891-1-git-send-email-damien.riegel@savoirfairelinux.com> <20151207094020.GF3384@x1> <20151207194218.GB6030@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 07 December 2015 14:42:18 Damien Riegel wrote:

> Good to see this patch applied. What's going on now with the other
> patches of this serie ? How should I handle them ?

I don't see any build-time dependencies between the patches, so
please submit them to the respective maintainers.

Patch 3 and 5 should go through the watchdog tree, and Shawn can take
the other ones and submit them through arm-soc.

	Arnd
