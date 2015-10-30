Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:35151 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbbJ3O1U (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 10:27:20 -0400
Date: Fri, 30 Oct 2015 10:17:34 -0400
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	robh+dt@kernel.org, kernel@savoirfairelinux.com
Subject: Re: [PATCH 1/4] of: add vendor prefix for Technologic Systems
Message-ID: <20151030141733.GA7403@localhost>
References: <1445978021-13961-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1445978021-13961-2-git-send-email-damien.riegel@savoirfairelinux.com>
 <25965423.XR5PXSyeuf@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25965423.XR5PXSyeuf@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 30, 2015 at 01:50:37PM +0100, Arnd Bergmann wrote:
> On Tuesday 27 October 2015 16:33:38 Damien Riegel wrote:
> >  truly  Truly Semiconductors Limited
> > +ts     Technologic Systems
> >  usi    Universal Scientific Industrial Co., Ltd.
> > 
> 
> The stock ticker symbol 'ts' is https://en.wikipedia.org/wiki/Tenaris,
> which is unlikely to conflict here, but it's still better to avoid using
> very short names when that is not also the stock ticker symbol for the
> same company. How about using 'technologic'?

Okay. I will change the vendor prefix to 'technologic' and resubmit once
I get feedback on the v2 of this patch serie.

Damien
