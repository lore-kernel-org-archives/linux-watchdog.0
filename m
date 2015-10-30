Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63123 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965731AbbJ3MvG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 08:51:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	robh+dt@kernel.org, kernel@savoirfairelinux.com
Subject: Re: [PATCH 1/4] of: add vendor prefix for Technologic Systems
Date: Fri, 30 Oct 2015 13:50:37 +0100
Message-ID: <25965423.XR5PXSyeuf@wuerfel>
In-Reply-To: <1445978021-13961-2-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1445978021-13961-1-git-send-email-damien.riegel@savoirfairelinux.com> <1445978021-13961-2-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 27 October 2015 16:33:38 Damien Riegel wrote:
>  truly  Truly Semiconductors Limited
> +ts     Technologic Systems
>  usi    Universal Scientific Industrial Co., Ltd.
> 

The stock ticker symbol 'ts' is https://en.wikipedia.org/wiki/Tenaris,
which is unlikely to conflict here, but it's still better to avoid using
very short names when that is not also the stock ticker symbol for the
same company. How about using 'technologic'?

	Arnd
